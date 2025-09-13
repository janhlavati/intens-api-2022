#Korak 1 - izgradnja aplikacije
FROM maven:3-jdk-8 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests

#Korak 2 - pokretanje aplikacije
FROM openjdk:21-jdk-slim

EXPOSE 8080

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]