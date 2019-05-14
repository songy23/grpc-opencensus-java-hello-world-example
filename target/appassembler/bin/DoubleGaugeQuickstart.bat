@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\io\opencensus\opencensus-api\0.20.0\opencensus-api-0.20.0.jar;"%REPO%"\io\grpc\grpc-context\1.19.0\grpc-context-1.19.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-grpc-metrics\0.20.0\opencensus-contrib-grpc-metrics-0.20.0.jar;"%REPO%"\com\google\guava\guava\26.0-android\guava-26.0-android.jar;"%REPO%"\org\checkerframework\checker-compat-qual\2.5.2\checker-compat-qual-2.5.2.jar;"%REPO%"\com\google\j2objc\j2objc-annotations\1.1\j2objc-annotations-1.1.jar;"%REPO%"\io\opencensus\opencensus-contrib-http-util\0.20.0\opencensus-contrib-http-util-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-http-jetty-client\0.20.0\opencensus-contrib-http-jetty-client-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-http-servlet\0.20.0\opencensus-contrib-http-servlet-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-zpages\0.20.0\opencensus-contrib-zpages-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-metrics-ocagent\0.20.0\opencensus-exporter-metrics-ocagent-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-monitored-resource-util\0.20.0\opencensus-contrib-monitored-resource-util-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-proto\0.2.0\opencensus-proto-0.2.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-stats-stackdriver\0.20.0\opencensus-exporter-stats-stackdriver-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-exemplar-util\0.20.0\opencensus-contrib-exemplar-util-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-contrib-resource-util\0.20.0\opencensus-contrib-resource-util-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-metrics-util\0.20.0\opencensus-exporter-metrics-util-0.20.0.jar;"%REPO%"\com\google\auth\google-auth-library-credentials\0.13.0\google-auth-library-credentials-0.13.0.jar;"%REPO%"\com\google\cloud\google-cloud-monitoring\1.65.0\google-cloud-monitoring-1.65.0.jar;"%REPO%"\com\google\cloud\google-cloud-core\1.65.0\google-cloud-core-1.65.0.jar;"%REPO%"\com\google\http-client\google-http-client\1.28.0\google-http-client-1.28.0.jar;"%REPO%"\com\google\api\api-common\1.7.0\api-common-1.7.0.jar;"%REPO%"\com\google\api\gax\1.42.0\gax-1.42.0.jar;"%REPO%"\org\threeten\threetenbp\1.3.3\threetenbp-1.3.3.jar;"%REPO%"\com\google\auth\google-auth-library-oauth2-http\0.13.0\google-auth-library-oauth2-http-0.13.0.jar;"%REPO%"\com\google\http-client\google-http-client-jackson2\1.28.0\google-http-client-jackson2-1.28.0.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-core\2.9.6\jackson-core-2.9.6.jar;"%REPO%"\com\google\protobuf\protobuf-java-util\3.6.1\protobuf-java-util-3.6.1.jar;"%REPO%"\com\google\api\grpc\proto-google-iam-v1\0.12.0\proto-google-iam-v1-0.12.0.jar;"%REPO%"\com\google\cloud\google-cloud-core-grpc\1.65.0\google-cloud-core-grpc-1.65.0.jar;"%REPO%"\com\google\api\gax-grpc\1.42.0\gax-grpc-1.42.0.jar;"%REPO%"\io\grpc\grpc-alts\1.18.0\grpc-alts-1.18.0.jar;"%REPO%"\org\apache\commons\commons-lang3\3.5\commons-lang3-3.5.jar;"%REPO%"\io\grpc\grpc-grpclb\1.18.0\grpc-grpclb-1.18.0.jar;"%REPO%"\com\google\api\grpc\proto-google-cloud-monitoring-v3\1.47.0\proto-google-cloud-monitoring-v3-1.47.0.jar;"%REPO%"\io\grpc\grpc-netty-shaded\1.18.0\grpc-netty-shaded-1.18.0.jar;"%REPO%"\io\grpc\grpc-auth\1.18.0\grpc-auth-1.18.0.jar;"%REPO%"\javax\annotation\javax.annotation-api\1.3.2\javax.annotation-api-1.3.2.jar;"%REPO%"\io\opencensus\opencensus-exporter-stats-prometheus\0.20.0\opencensus-exporter-stats-prometheus-0.20.0.jar;"%REPO%"\io\prometheus\simpleclient\0.6.0\simpleclient-0.6.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-trace-jaeger\0.20.0\opencensus-exporter-trace-jaeger-0.20.0.jar;"%REPO%"\io\jaegertracing\jaeger-client\0.33.1\jaeger-client-0.33.1.jar;"%REPO%"\io\jaegertracing\jaeger-thrift\0.33.1\jaeger-thrift-0.33.1.jar;"%REPO%"\org\apache\thrift\libthrift\0.11.0\libthrift-0.11.0.jar;"%REPO%"\org\apache\httpcomponents\httpclient\4.4.1\httpclient-4.4.1.jar;"%REPO%"\commons-logging\commons-logging\1.2\commons-logging-1.2.jar;"%REPO%"\commons-codec\commons-codec\1.9\commons-codec-1.9.jar;"%REPO%"\org\apache\httpcomponents\httpcore\4.4.1\httpcore-4.4.1.jar;"%REPO%"\com\squareup\okhttp3\okhttp\3.9.0\okhttp-3.9.0.jar;"%REPO%"\com\squareup\okio\okio\1.13.0\okio-1.13.0.jar;"%REPO%"\io\jaegertracing\jaeger-core\0.33.1\jaeger-core-0.33.1.jar;"%REPO%"\io\opentracing\opentracing-api\0.31.0\opentracing-api-0.31.0.jar;"%REPO%"\io\opentracing\opentracing-util\0.31.0\opentracing-util-0.31.0.jar;"%REPO%"\io\opentracing\opentracing-noop\0.31.0\opentracing-noop-0.31.0.jar;"%REPO%"\io\jaegertracing\jaeger-tracerresolver\0.33.1\jaeger-tracerresolver-0.33.1.jar;"%REPO%"\io\opentracing\contrib\opentracing-tracerresolver\0.1.5\opentracing-tracerresolver-0.1.5.jar;"%REPO%"\io\opencensus\opencensus-exporter-trace-stackdriver\0.20.0\opencensus-exporter-trace-stackdriver-0.20.0.jar;"%REPO%"\com\google\cloud\google-cloud-trace\0.83.0-beta\google-cloud-trace-0.83.0-beta.jar;"%REPO%"\com\google\api\grpc\proto-google-cloud-trace-v1\0.48.0\proto-google-cloud-trace-v1-0.48.0.jar;"%REPO%"\com\google\api\grpc\proto-google-cloud-trace-v2\0.48.0\proto-google-cloud-trace-v2-0.48.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-trace-logging\0.20.0\opencensus-exporter-trace-logging-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-exporter-trace-ocagent\0.20.0\opencensus-exporter-trace-ocagent-0.20.0.jar;"%REPO%"\io\grpc\grpc-core\1.19.0\grpc-core-1.19.0.jar;"%REPO%"\com\google\code\gson\gson\2.7\gson-2.7.jar;"%REPO%"\com\google\errorprone\error_prone_annotations\2.2.0\error_prone_annotations-2.2.0.jar;"%REPO%"\com\google\code\findbugs\jsr305\3.0.2\jsr305-3.0.2.jar;"%REPO%"\org\codehaus\mojo\animal-sniffer-annotations\1.17\animal-sniffer-annotations-1.17.jar;"%REPO%"\io\grpc\grpc-netty\1.19.0\grpc-netty-1.19.0.jar;"%REPO%"\io\netty\netty-codec-http2\4.1.32.Final\netty-codec-http2-4.1.32.Final.jar;"%REPO%"\io\netty\netty-codec-http\4.1.32.Final\netty-codec-http-4.1.32.Final.jar;"%REPO%"\io\netty\netty-codec\4.1.32.Final\netty-codec-4.1.32.Final.jar;"%REPO%"\io\netty\netty-handler\4.1.32.Final\netty-handler-4.1.32.Final.jar;"%REPO%"\io\netty\netty-buffer\4.1.32.Final\netty-buffer-4.1.32.Final.jar;"%REPO%"\io\netty\netty-common\4.1.32.Final\netty-common-4.1.32.Final.jar;"%REPO%"\io\netty\netty-handler-proxy\4.1.32.Final\netty-handler-proxy-4.1.32.Final.jar;"%REPO%"\io\netty\netty-transport\4.1.32.Final\netty-transport-4.1.32.Final.jar;"%REPO%"\io\netty\netty-resolver\4.1.32.Final\netty-resolver-4.1.32.Final.jar;"%REPO%"\io\netty\netty-codec-socks\4.1.32.Final\netty-codec-socks-4.1.32.Final.jar;"%REPO%"\io\grpc\grpc-protobuf\1.19.0\grpc-protobuf-1.19.0.jar;"%REPO%"\com\google\protobuf\protobuf-java\3.6.1\protobuf-java-3.6.1.jar;"%REPO%"\com\google\api\grpc\proto-google-common-protos\1.12.0\proto-google-common-protos-1.12.0.jar;"%REPO%"\io\grpc\grpc-protobuf-lite\1.19.0\grpc-protobuf-lite-1.19.0.jar;"%REPO%"\io\grpc\grpc-stub\1.19.0\grpc-stub-1.19.0.jar;"%REPO%"\io\prometheus\simpleclient_httpserver\0.6.0\simpleclient_httpserver-0.6.0.jar;"%REPO%"\io\prometheus\simpleclient_common\0.6.0\simpleclient_common-0.6.0.jar;"%REPO%"\io\opencensus\opencensus-impl\0.20.0\opencensus-impl-0.20.0.jar;"%REPO%"\io\opencensus\opencensus-impl-core\0.20.0\opencensus-impl-core-0.20.0.jar;"%REPO%"\com\lmax\disruptor\3.4.2\disruptor-3.4.2.jar;"%REPO%"\io\netty\netty-tcnative-boringssl-static\2.0.8.Final\netty-tcnative-boringssl-static-2.0.8.Final.jar;"%REPO%"\javax\servlet\javax.servlet-api\3.1.0\javax.servlet-api-3.1.0.jar;"%REPO%"\org\eclipse\jetty\jetty-client\9.4.12.v20180830\jetty-client-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-http\9.4.12.v20180830\jetty-http-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-util\9.4.12.v20180830\jetty-util-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-io\9.4.12.v20180830\jetty-io-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-server\9.4.12.v20180830\jetty-server-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-servlet\9.4.12.v20180830\jetty-servlet-9.4.12.v20180830.jar;"%REPO%"\org\eclipse\jetty\jetty-security\9.4.12.v20180830\jetty-security-9.4.12.v20180830.jar;"%REPO%"\org\slf4j\slf4j-log4j12\1.7.25\slf4j-log4j12-1.7.25.jar;"%REPO%"\org\slf4j\slf4j-api\1.7.25\slf4j-api-1.7.25.jar;"%REPO%"\log4j\log4j\1.2.17\log4j-1.2.17.jar;"%REPO%"\io\opencensus\opencensus-examples\0.21.0-SNAPSHOT\opencensus-examples-0.21.0-SNAPSHOT.jar

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS%  -classpath %CLASSPATH% -Dapp.name="DoubleGaugeQuickstart" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" io.opencensus.examples.gauges.DoubleGaugeQuickstart %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
