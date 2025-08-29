# --- Build stage: Maven + Temurin JDK 17 ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src

# 의존성 캐시 최적화
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -U -DskipTests dependency:go-offline

# 소스 복사 후 패키징
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -DskipTests package

# --- Runtime stage: Temurin JRE 17 ---
FROM eclipse-temurin:17-jre
LABEL maintainer="test@gmail.com"
WORKDIR /app
EXPOSE 8080

# 빌드 산출물만 복사
COPY --from=build /src/target/*.jar /app/app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]