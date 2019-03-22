FROM sonarqube:7.7-community

ENV TZ=Europe/Amsterdam

RUN ls -l /opt/sonarqube/extensions/plugins/*

RUN rm /opt/sonarqube/extensions/plugins/sonar-python-plugin-*.jar && \
    rm /opt/sonarqube/extensions/plugins/sonar-javascript-plugin-*.jar && \
    rm /opt/sonarqube/extensions/plugins/sonar-php-plugin-*.jar
    
COPY /language-plugins/* /opt/sonarqube/extensions/plugins/
