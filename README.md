# Launching a [Spring Boot](https://spring.io/) (Java) Application with Docker

This guide explains how to set up and launch a [Spring Boot](https://spring.io/) (Java) application with Apache using Docker.

## Prerequisites

Before starting, ensure you have the following tools installed on your machine:

- [Docker](https://www.docker.com/products/docker-desktop)

## Dockerfile Content

This Dockerfile configures a container for a [Spring Boot](https://spring.io/) (Java) application with Maven.

```Dockerfile
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

# Expose the port on which the Spring Boot application runs
EXPOSE 8080

# Define the entry point to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

```
## Steps to Launch the Application

1. Build the Docker Image

To build the Docker image, use the following command in the directory containing the Dockerfile:

```
docker build -t door-spring .
```

2. Run the Container

Once the image is built, run a container from this image:

```
docker run -p 8080:80 door-spring
```

3. Access the Application

Open your browser and go to the following URL to see your application running:

```
http://localhost:8080
```

4. Environment Variables

If you need to configure additional environment variables, modify the .env file that was copied into the container during the image build.

## Publishing the Image on Docker Hub

1. Log In to Docker Hub

Before publishing your image, log in to Docker Hub with your Docker account:

```
docker login
```

2. Tag the Image

Tag the image you built with your Docker Hub username and the image name:

```
docker tag door-spring your_dockerhub_username/door-spring:latest
```
Replace your_dockerhub_username with your Docker Hub username.

3. Push the Image to Docker Hub

Push the tagged image to Docker Hub:

```
docker push your_dockerhub_username/door-spring:latest
```

