# --- Build Stage ---
FROM gradle:8.0-jdk17 AS build
WORKDIR /app

COPY . .
RUN gradle build --no-daemon

# --- Run Stage ---
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
