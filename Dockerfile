FROM eclipse-temurin:17-jre
LABEL maintainer='test@gmail.com'
EXPOSE 8080
ADD target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]