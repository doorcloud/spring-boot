# Use the official Maven base image to build the project
FROM maven:3.8.5-openjdk-17-slim AS build

# Create a working directory
WORKDIR /app

# Copy Maven configuration files
COPY pom.xml .

# Download Maven dependencies
RUN mvn dependency:go-offline

# Copy project sources
COPY src ./src

# Generate the JAR file
RUN mvn package -DskipTests

# Use the official OpenJDK base image for Java 17 Alpine
FROM openjdk:17-jdk-alpine

# Copy the generated JAR file from the previous build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Download the OpenTelemetry Java agent
RUN wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.28.0/opentelemetry-javaagent.jar -O /app/opentelemetry-javaagent.jar

# Expose the port on which the Spring Boot application runs
EXPOSE 8080

# Define the entry point to run the application
ENTRYPOINT ["java", "-javaagent:/app/opentelemetry-javaagent.jar", "-jar", "/app/app.jar"]
