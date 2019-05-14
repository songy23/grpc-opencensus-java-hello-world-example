/*
 * Copyright 2018, OpenCensus Authors
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

package io.opencensus.examples.grpc.helloworld;

import io.opencensus.common.Duration;
import io.opencensus.exporter.metrics.ocagent.OcAgentMetricsExporter;
import io.opencensus.exporter.metrics.ocagent.OcAgentMetricsExporterConfiguration;
import io.opencensus.exporter.trace.ocagent.OcAgentTraceExporter;
import io.opencensus.exporter.trace.ocagent.OcAgentTraceExporterConfiguration;
import java.util.logging.Logger;
import javax.annotation.Nullable;

/** Util methods. */
final class HelloWorldUtils {

  private static final Logger logger = Logger.getLogger(HelloWorldUtils.class.getName());

  private static final String SERVICE_NAME = "ocagent-java-exporter-quickstart";
  private static final Duration RETRY_INTERVAL = Duration.create(10, 0);
  private static final Duration EXPORT_INTERVAL = Duration.create(5, 0);

  static int getPortOrDefaultFromArgs(String[] args, int index, int defaultPort) {
    int portNumber = defaultPort;
    if (index < args.length) {
      try {
        portNumber = Integer.parseInt(args[index]);
      } catch (NumberFormatException e) {
        logger.warning(
            String.format("Port %s is invalid, use default port %d.", args[index], defaultPort));
      }
    }
    return portNumber;
  }

  static String getStringOrDefaultFromArgs(
      String[] args, int index, @Nullable String defaultString) {
    String s = defaultString;
    if (index < args.length) {
      s = args[index];
    }
    return s;
  }

  static void registerAgentExporters(String endPoint) {
    OcAgentTraceExporter.createAndRegister(
        OcAgentTraceExporterConfiguration.builder()
            .setEndPoint(endPoint)
            .setServiceName(SERVICE_NAME)
            .setUseInsecure(true)
            .setEnableConfig(false)
            .build());

    OcAgentMetricsExporter.createAndRegister(
        OcAgentMetricsExporterConfiguration.builder()
            .setEndPoint(endPoint)
            .setServiceName(SERVICE_NAME)
            .setUseInsecure(true)
            .setRetryInterval(RETRY_INTERVAL)
            .setExportInterval(EXPORT_INTERVAL)
            .build());
  }

  private HelloWorldUtils() {}
}
