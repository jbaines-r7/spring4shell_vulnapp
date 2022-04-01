FROM --platform=linux/amd64 openjdk:11

EXPOSE 8080

RUN apt update
RUN apt install -y maven

ADD . / /springy
WORKDIR /springy
RUN mvn package

RUN wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.77/bin/apache-tomcat-8.5.77.zip
RUN unzip apache-tomcat-8.5.77.zip
RUN chmod +x apache-tomcat-8.5.77/bin/*.sh

RUN cp target/vulnerable-1.0.0.0.war apache-tomcat-8.5.77/webapps/

CMD ["./apache-tomcat-8.5.77/bin/catalina.sh", "run"]
