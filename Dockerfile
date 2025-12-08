# --- Build Stage ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy only pom.xml first to leverage Docker layer caching
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Now copy the project source
COPY src ./src

# Build the application
RUN mvn -B package

# --- Run Stage ---
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]
