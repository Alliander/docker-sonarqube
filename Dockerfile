FROM sonarqube:7.7-community

USER root 

# Run as user app:app
RUN addgroup --gid 2222 app && useradd --gid 2222 --shell /bin/bash --uid 2222 app && chown -R 2222:2222 /opt/sonarqube

# Switch to user app
USER app

ENV TZ=Europe/Amsterdam

RUN rm /opt/sonarqube/extensions/plugins/sonar-python-plugin-*.jar && \
    rm /opt/sonarqube/extensions/plugins/sonar-javascript-plugin-*.jar && \
    rm /opt/sonarqube/extensions/plugins/sonar-php-plugin-*.jar
    
COPY /language-plugins/* /opt/sonarqube/extensions/plugins/

