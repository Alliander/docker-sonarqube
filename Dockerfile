FROM alliander/sonarqube:7.7.0

EXPOSE 9000

USER sonarqube
# ENTRYPOINT ["./bin/run.sh"]
ENTRYPOINT ["sleep 3600"]
