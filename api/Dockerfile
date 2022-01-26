FROM openjdk:8-jre

VOLUME ["/hygieia/logs"]

RUN mkdir -p /hygieia/config

EXPOSE 8080

ENV PROP_FILE /hygieia/config/application.properties

ENV AUTH_EXPIRATION_TIME=36000
ENV AUTH_SECRET=hygieiasecret

WORKDIR /hygieia

COPY target/*.jar /hygieia/
COPY docker/properties-builder.sh /hygieia/

CMD ./properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar *.jar --spring.config.location=$PROP_FILE