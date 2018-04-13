FROM sonarqube:7.0-alpine

COPY /language-plugins/sonar-java-plugin-5.2.0.13398.jar /opt/sonarqube/extensions/plugins
COPY /language-plugins/sonar-javascript-plugin-4.1.0.6085.jar /opt/sonarqube/extensions/plugins

ENV TZ=Europe/Amsterdam
