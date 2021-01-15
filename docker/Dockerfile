FROM maven:3.6.3-jdk-11 AS build_jar
WORKDIR /tmp/
COPY app/pom.xml /tmp/
COPY app/src /tmp/src/
RUN mvn clean && mvn package
# ------------------------------------------------------
FROM alpine:latest as packager
RUN apk --no-cache add openjdk11-jdk openjdk11-jmods
ENV JAVA_MINIMAL="/opt/java-minimal"
RUN /usr/lib/jvm/java-11-openjdk/bin/jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --release-info="add:IMPLEMENTOR=radistao:IMPLEMENTOR_VERSION=radistao_JRE" \
    --output "$JAVA_MINIMAL"
# ------------------------------------------------------
FROM alpine:latest
ENV JAVA_HOME=/opt/java-minimal
ENV PATH="$PATH:$JAVA_HOME/bin"
WORKDIR /usr/src/app
COPY --from=packager "$JAVA_HOME" "$JAVA_HOME"
COPY --from=build_jar /tmp/target/websocket-0.0.1-SNAPSHOT.jar .
RUN apk add --update bash && rm -rf /var/cache/apk/*
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# COPY app/target/websocket-0.0.1-SNAPSHOT.jar .
COPY docker/entrypoint.sh .
COPY docker ./docker
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]