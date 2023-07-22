# Use a base image with Maven and Java pre-installed
FROM maven:3.8.4-jdk-11

# Set the working directory
WORKDIR /app

# Copy the Maven project to the container
COPY pom.xml .
COPY src/ ./src/

# Build the application using Maven
RUN mvn clean package

# Use a smaller base image with JRE to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=0 /app/target/myapp.jar .

# Expose the application port (adjust this if your application uses a different port)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "myapp.jar"]
