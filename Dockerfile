FROM alliander/sonarqube:7.7

EXPOSE 9000

ENTRYPOINT ["./bin/run.sh"]
