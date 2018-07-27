FROM sonarqube:7.1

COPY /language-plugins/sonar-java-plugin-5.6.0.15032.jar /opt/sonarqube/extensions/plugins
COPY /language-plugins/sonar-javascript-plugin-4.2.0.6476.jar /opt/sonarqube/extensions/plugins

ENV TZ=Europe/Amsterdam
