FROM maven:3-jdk-10-slim as restore
WORKDIR /app
COPY ./pom.xml /app/pom.xml
RUN mvn install

FROM restore as build
WORKDIR /app
COPY . /app
RUN mvn compile

FROM openjdk:10-jre-slim as prod
COPY --from=build /app/target/xmexersize-0.0.1-SNAPSHOT.jar /
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "xmexersize-0.0.1-SNAPSHOT.jar"]