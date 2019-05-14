/*
 * Copyright 2019, OpenCensus Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.opencensus.examples.http.jetty.server;

import io.opencensus.contrib.http.servlet.OcHttpServletFilter;
import io.opencensus.contrib.http.util.HttpViews;
import io.opencensus.exporter.stats.prometheus.PrometheusStatsCollector;
import io.opencensus.exporter.trace.jaeger.JaegerTraceExporter;
import io.opencensus.exporter.trace.logging.LoggingTraceExporter;
import io.opencensus.trace.Tracing;
import io.opencensus.trace.config.TraceConfig;
import io.opencensus.trace.samplers.Samplers;
import io.prometheus.client.exporter.HTTPServer;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.EnumSet;
import javax.servlet.AsyncContext;
import javax.servlet.DispatcherType;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.WriteListener;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Request;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;

/** Sample application that shows how to instrument jetty server. */
public class HelloWorldServer extends AbstractHandler {

  private static final Logger logger = Logger.getLogger(HelloWorldServer.class.getName());

  public static class HelloServlet extends HttpServlet {

    private static String body = "<h1>Hello World Servlet Get</h1>";

    private static final long serialVersionUID = 1L;

    private void blockingGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

      String str = body.concat("<h3>blocking</h3>");
      ByteBuffer content = ByteBuffer.wrap(str.getBytes(StandardCharsets.UTF_8));

      PrintWriter pout = response.getWriter();

      pout.print("<html><body>");
      pout.print(str);
      pout.print("</body></html>");
      return;
    }

    private void asyncGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
      String str = body.concat("<h3>async</h3>");
      ByteBuffer content = ByteBuffer.wrap(str.getBytes(StandardCharsets.UTF_8));

      AsyncContext async = request.startAsync();
      response.setContentType("text/html");
      try {
        Thread.sleep(100);
      } catch (Exception e) {
        logger.info("Error sleeping");
      }
      ServletOutputStream out = response.getOutputStream();
      out.setWriteListener(
          new WriteListener() {
            @Override
            public void onWritePossible() throws IOException {
              while (out.isReady()) {
                if (!content.hasRemaining()) {
                  response.setStatus(200);
                  async.complete();
                  return;
                }
                out.write(content.get());
              }
            }

            @Override
            public void onError(Throwable t) {
              logger.info("Server onError callled");
              getServletContext().log("Async Error", t);
              async.complete();
            }
          });
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
      if (request.getPathInfo().contains("async")) {
        asyncGet(request, response);
      } else {
        blockingGet(request, response);
      }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
      // Read from request
      StringBuilder buffer = new StringBuilder();
      BufferedReader reader = request.getReader();
      String line;
      while ((line = reader.readLine()) != null) {
        buffer.append(line);
      }
      String data = buffer.toString();

      PrintWriter pout = response.getWriter();

      pout.print("<html><body>");
      pout.print("<h3>Hello World Servlet Post</h3>");
      pout.print("</body></html>");
      return;
    }
  }

  @Override
  public void handle(
      String target, Request baseRequest, HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    response.setContentType("text/html;charset=utf-8");
    response.setStatus(HttpServletResponse.SC_OK);
    baseRequest.setHandled(true);
    response.getWriter().println("<h1>Hello World. default handler.</h1>");
  }

  private static void initStatsExporter() throws IOException {
    HttpViews.registerAllServerViews();

    // Register Prometheus exporters and export metrics to a Prometheus HTTPServer.
    // Refer to https://prometheus.io/ to run Prometheus Server.
    PrometheusStatsCollector.createAndRegister();
    HTTPServer prometheusServer = new HTTPServer(9090, true);
  }

  private static void initTracing() {
    TraceConfig traceConfig = Tracing.getTraceConfig();

    // default sampler is set to Samplers.alwaysSample() for demonstration. In production
    // or in high QPS environment please use default sampler.
    traceConfig.updateActiveTraceParams(
        traceConfig.getActiveTraceParams().toBuilder().setSampler(Samplers.alwaysSample()).build());

    // Register LoggingTraceExporter to see traces in logs.
    LoggingTraceExporter.register();

    // Register Jaeger Tracing. Refer to https://www.jaegertracing.io/docs/1.8/getting-started/ to
    // run Jaeger
    JaegerTraceExporter.createAndRegister("http://localhost:14268/api/traces", "helloworldserver");
  }

  /**
   * HelloWorldServer starts a jetty server that responds to http request sent by {@link
   * HelloWorldClient}. The server uses http servlet which is instrumented with opencensus to enable
   * tracing and monitoring stats.
   */
  public static void main(String[] args) throws Exception {
    initTracing();
    initStatsExporter();

    Server server = new Server(8080);
    ServletContextHandler contextHandler =
        new ServletContextHandler(ServletContextHandler.SESSIONS);
    contextHandler.setContextPath("/helloworld");
    ServletHolder sh = new ServletHolder(new HelloServlet());
    contextHandler.addServlet(sh, "/request/*");

    // Enable tracing by adding OcHttpServleFilter for all path
    contextHandler.addFilter(OcHttpServletFilter.class, "/*", EnumSet.of(DispatcherType.REQUEST));

    // Uncomment following line to use B3Format for trace context propagation.
    // contextHandler.setAttribute(
    //    OC_TRACE_PROPAGATOR, Tracing.getPropagationComponent().getB3Format());

    // By default publicEndpoint parameter is set to false and incoming trace context is added as
    // a parent.
    // If the endpoint for http request is public then uncomment following line to set the
    // publicEndpoint parameter to true. When set to true incoming trace context is added as a
    // parent link instead of as a parent.
    //
    // contextHandler.setInitParameter(OC_PUBLIC_ENDPOINT, "true");

    server.setHandler(contextHandler);
    try {
      server.start();
      server.join();
    } catch (Exception e) {
      logger.error("Failed to start application", e);
    }
  }
}
