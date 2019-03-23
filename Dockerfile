FROM alliander/sonarqube:7.7.0

EXPOSE 9000

USER root
# COPY startup.sh /opt/sonarqube/bin/
# RUN chmod +x /opt/sonarqube/bin/startup.sh && chown sonarqube:sonarqube /opt/sonarqube/bin/startup.sh

# USER sonarqube

ENTRYPOINT ["./bin/run.sh"]
# ENTRYPOINT ['/opt/sonarqube/bin/startup.sh']
