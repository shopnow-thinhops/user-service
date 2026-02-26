# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-17-alpine AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/target/user-service-0.0.1-SNAPSHOT.war /app/user-service.war

EXPOSE 5865
ENTRYPOINT exec java -jar /app/user-service.war --spring.config.location=/app/src/main/resources/application.properties 
