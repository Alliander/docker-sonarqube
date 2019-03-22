FROM sonarqube:7.7-community

USER root 
EXPOSE 9000

COPY /usr/bin/ /usr/bin/
COPY run.sh $SONARQUBE_HOME/bin/

RUN chmod +x /usr/bin/fix-permissions.sh 

RUN sh /usr/bin/fix-permissions.sh $SONARQUBE_HOME \
    && chmod 775 $SONARQUBE_HOME/bin/run.sh \ 
    && chown -R sonarqube:sonarqube /opt/sonarqube/* \
    && chown -R sonarqube:root /opt/sonarqube/temp
    
USER sonarqube

# Run as user app:app
# RUN addgroup --gid 22222 app && useradd --gid 22222 --shell /bin/bash --uid 22222 app && chmod 777 -R /opt/sonarqube
# RUN chmod 777 -R /opt/sonarqube
# USER sonarqube

ENV SONAR_VERSION=7.7 \
    SONARQUBE_HOME=/opt/sonarqube \
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=

WORKDIR $SONARQUBE_HOME

#RUN rm /opt/sonarqube/extensions/plugins/sonar-python-plugin-*.jar && \
#    rm /opt/sonarqube/extensions/plugins/sonar-javascript-plugin-*.jar && \
#    rm /opt/sonarqube/extensions/plugins/sonar-php-plugin-*.jar
    
#COPY /language-plugins/* /opt/sonarqube/extensions/plugins/

ENTRYPOINT ["./bin/run.sh"]
    
# Switch to user app
# USER app

#ENV TZ=Europe/Amsterdam


