FROM sonarqube:6.7.1-alpine

COPY /language-plugins/sonar-java-plugin-5.0.1.12818.jar /opt/sonarqube/extensions/plugins
COPY /language-plugins/sonar-javascript-plugin-4.0.0.5862.jar /opt/sonarqube/extensions/plugins

ENV TZ=Europe/Amsterdam
