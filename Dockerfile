# --- Build Stage ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy everything from project root
COPY . .

# Compile and package with dependencies, telling Maven to use project root as source
RUN mvn -B compile assembly:single -DdescriptorId=jar-with-dependencies

# --- Run Stage ---
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the assembled jar
COPY --from=build /app/target/*-jar-with-dependencies.jar app.jar

CMD ["java", "-jar", "app.jar"]
