FROM openjdk:17-jdk-slim
LABEL maintainer="test@gmail.com"
EXPOSE 8080
ADD target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]