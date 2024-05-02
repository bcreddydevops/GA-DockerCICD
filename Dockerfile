FROM tomcat:8.5.76-jdk11-openjdk-slim
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/my-app.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
