## Docker image voor SonarQube

Het standaard sonarqube-alpine image bevat geen enkele language plugin, ook java language plugin ontbreekt.
We hebben daarom een eigen image gemaakt dat niet veel meer is dan de standaard sonarqube-alpine image
waar één of meerdere language module(s) aan is toegevoegd, zie de Dockerfile

Het maken/update van de image doe je met:
```console
$ docker build -t alliander/sonarqube:7.7.0 .
```

Om dit image beschikbaar te hebben in de k8s omgeving(en) moet het nog gepushed worden naar onze repository:
```console
$ docker push alliander/sonarqube:7.7.0
```

### Bouwen in Openshift
Voeg eerste de ImageStream toe en daar de BuildConfig om het image te bouwen.

```yaml
apiVersion: image.openshift.io/v1
kind: ImageStream
metadata:
  labels:
    app: sonarqube
  name: sonarqube
spec:
  lookupPolicy:
    local: false
```

En daarna:
   
```yaml
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  annotations:
  name: sonarqube
spec:
  failedBuildsHistoryLimit: 5
  nodeSelector: null
  output:
    to:
      kind: ImageStreamTag
      name: 'sonarqube:7.7.0'
  postCommit: {}
  resources: {}
  runPolicy: Serial
  source:
    git:
      uri: 'https://github.com/Alliander/docker-sonarqube'
    sourceSecret:
      name: argo-cd-github
    type: Git
  strategy:
    type: Docker
    dockerStrategy:
      dockerfilePath: Dockerfile
  successfulBuildsHistoryLimit: 5
  triggers:
  - type: "ConfigChange"
  - type: "ImageChange"
```

