# Stage 1: Build
FROM gradle:8.6-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test

# Stage 2: Run class files directly
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy compiled .class files
COPY --from=build /app/build/classes/java/main /app/classes

# Set classpath
ENV CLASSPATH=/app/classes

# Change this to your actual Main class (with package if any)
ENTRYPOINT ["java", "Main"]
