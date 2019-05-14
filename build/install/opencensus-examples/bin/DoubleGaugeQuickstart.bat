@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  DoubleGaugeQuickstart startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and DOUBLE_GAUGE_QUICKSTART_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\opencensus-examples-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-metrics-ocagent-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-trace-ocagent-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-proto-0.2.0.jar;%APP_HOME%\lib\opencensus-exporter-stats-stackdriver-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\google-cloud-monitoring-1.65.0.jar;%APP_HOME%\lib\opencensus-exporter-trace-stackdriver-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\google-cloud-trace-0.83.0-beta.jar;%APP_HOME%\lib\google-cloud-core-grpc-1.65.0.jar;%APP_HOME%\lib\gax-grpc-1.42.0.jar;%APP_HOME%\lib\grpc-alts-1.18.0.jar;%APP_HOME%\lib\grpc-grpclb-1.18.0.jar;%APP_HOME%\lib\grpc-protobuf-1.19.0.jar;%APP_HOME%\lib\google-cloud-core-1.65.0.jar;%APP_HOME%\lib\proto-google-cloud-monitoring-v3-1.47.0.jar;%APP_HOME%\lib\proto-google-cloud-trace-v1-0.48.0.jar;%APP_HOME%\lib\proto-google-cloud-trace-v2-0.48.0.jar;%APP_HOME%\lib\proto-google-iam-v1-0.12.0.jar;%APP_HOME%\lib\proto-google-common-protos-1.14.0.jar;%APP_HOME%\lib\opencensus-contrib-zpages-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\grpc-stub-1.19.0.jar;%APP_HOME%\lib\grpc-netty-shaded-1.19.0.jar;%APP_HOME%\lib\grpc-netty-1.19.0.jar;%APP_HOME%\lib\grpc-auth-1.19.0.jar;%APP_HOME%\lib\grpc-protobuf-lite-1.19.0.jar;%APP_HOME%\lib\grpc-core-1.19.0.jar;%APP_HOME%\lib\opencensus-contrib-grpc-metrics-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-contrib-http-servlet-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-contrib-http-jetty-client-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\gax-1.42.0.jar;%APP_HOME%\lib\google-auth-library-oauth2-http-0.13.0.jar;%APP_HOME%\lib\google-http-client-jackson2-1.28.0.jar;%APP_HOME%\lib\google-http-client-1.28.0.jar;%APP_HOME%\lib\opencensus-contrib-http-util-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-stats-prometheus-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-trace-jaeger-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-trace-logging-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-impl-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-contrib-resource-util-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-exporter-metrics-util-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-contrib-exemplar-util-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-impl-core-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\opencensus-api-0.21.0-SNAPSHOT.jar;%APP_HOME%\lib\simpleclient_httpserver-0.6.0.jar;%APP_HOME%\lib\jetty-servlet-9.4.17.v20190418.jar;%APP_HOME%\lib\jetty-security-9.4.17.v20190418.jar;%APP_HOME%\lib\jetty-server-9.4.17.v20190418.jar;%APP_HOME%\lib\javax.servlet-api-3.1.0.jar;%APP_HOME%\lib\jetty-client-9.4.17.v20190418.jar;%APP_HOME%\lib\slf4j-log4j12-1.7.25.jar;%APP_HOME%\lib\netty-tcnative-boringssl-static-2.0.8.Final.jar;%APP_HOME%\lib\protobuf-java-util-3.6.1.jar;%APP_HOME%\lib\protobuf-java-3.6.1.jar;%APP_HOME%\lib\grpc-context-1.19.0.jar;%APP_HOME%\lib\guava-26.0-android.jar;%APP_HOME%\lib\simpleclient_common-0.6.0.jar;%APP_HOME%\lib\simpleclient-0.6.0.jar;%APP_HOME%\lib\google-auth-library-credentials-0.13.0.jar;%APP_HOME%\lib\jaeger-client-0.33.1.jar;%APP_HOME%\lib\jetty-http-9.4.17.v20190418.jar;%APP_HOME%\lib\jetty-io-9.4.17.v20190418.jar;%APP_HOME%\lib\jaeger-thrift-0.33.1.jar;%APP_HOME%\lib\jaeger-tracerresolver-0.33.1.jar;%APP_HOME%\lib\jaeger-core-0.33.1.jar;%APP_HOME%\lib\libthrift-0.11.0.jar;%APP_HOME%\lib\slf4j-api-1.7.25.jar;%APP_HOME%\lib\log4j-1.2.17.jar;%APP_HOME%\lib\disruptor-3.4.2.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-compat-qual-2.5.2.jar;%APP_HOME%\lib\error_prone_annotations-2.2.0.jar;%APP_HOME%\lib\j2objc-annotations-1.1.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.17.jar;%APP_HOME%\lib\gson-2.8.2.jar;%APP_HOME%\lib\netty-codec-http2-4.1.32.Final.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.32.Final.jar;%APP_HOME%\lib\javax.annotation-api-1.3.2.jar;%APP_HOME%\lib\jetty-util-9.4.17.v20190418.jar;%APP_HOME%\lib\netty-codec-http-4.1.32.Final.jar;%APP_HOME%\lib\netty-handler-4.1.32.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.32.Final.jar;%APP_HOME%\lib\netty-codec-4.1.32.Final.jar;%APP_HOME%\lib\netty-transport-4.1.32.Final.jar;%APP_HOME%\lib\api-common-1.7.0.jar;%APP_HOME%\lib\okhttp-3.9.0.jar;%APP_HOME%\lib\opentracing-util-0.31.0.jar;%APP_HOME%\lib\opentracing-tracerresolver-0.1.5.jar;%APP_HOME%\lib\opentracing-noop-0.31.0.jar;%APP_HOME%\lib\opentracing-api-0.31.0.jar;%APP_HOME%\lib\netty-buffer-4.1.32.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.32.Final.jar;%APP_HOME%\lib\threetenbp-1.3.3.jar;%APP_HOME%\lib\httpclient-4.4.1.jar;%APP_HOME%\lib\httpcore-4.4.1.jar;%APP_HOME%\lib\okio-1.13.0.jar;%APP_HOME%\lib\netty-common-4.1.32.Final.jar;%APP_HOME%\lib\commons-lang3-3.5.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-codec-1.9.jar;%APP_HOME%\lib\jackson-core-2.9.6.jar

@rem Execute DoubleGaugeQuickstart
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %DOUBLE_GAUGE_QUICKSTART_OPTS%  -classpath "%CLASSPATH%" io.opencensus.examples.gauges.DoubleGaugeQuickstart %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable DOUBLE_GAUGE_QUICKSTART_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%DOUBLE_GAUGE_QUICKSTART_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
