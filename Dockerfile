# --- Stage-1 Build------
FROM maven:3.9.6-eclipse-temurin-17 AS builder 

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

# ---- Stage-2 Production ----
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/target/bankapp.jar"]
