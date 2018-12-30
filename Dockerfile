FROM maven:3.6.0-jdk-8
#FROM openjdk:8-jdk

ENV JAVA_OPTS "-server -Xconcurrentio -Xmx1g -Xms1g -XX:+UseG1GC -XX:MetaspaceSize=100M -Ddw.server.applicationConnectors[0].bindHost=0.0.0.0 -Ddw.server.applicationConnectors[0].port=8989"

RUN mkdir -p /data && \
    mkdir -p /graphhopper

#COPY /data/* /data/

COPY . /graphhopper/

WORKDIR /graphhopper

ADD http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf /data/

RUN $MAVEN_HOME/bin/mvn --projects web -am -DskipTests=true package



VOLUME [ "/data" ]

EXPOSE 8989

ENTRYPOINT [ "./graphhopper.sh", "web" ]

CMD [ "/data/israel-and-palestine-latest.osm.pbf" ]
