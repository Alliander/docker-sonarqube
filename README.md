## Docker image voor SonarQube

De file *Dockerfile-alliander-sonarqube* beschrijft het standaard SonarQube image
versie 7.7 waar standaard een aantal language plugins in zitten. Deze worden
gebruikt. Verder is er wel een aparte Dockerfile-alliander-sonarqube zodat dit 
image geplaatst kan worden op DockerHub en Openshift hier gebruik van kan maken.
Openshift stelt een aantal eisen aan de rechten op folders, etc... 

De Dockerfile wordt gelezen door de BuildConfig in Openshift en maakt een nieuw
image dat in de registry van het cluster wordt opgeslagen. Dit image wordt
uiteindelijk gebruikt.

Het maken/update van de image doe je met:
```console
$ docker build -t alliander/sonarqube:7.7 .
```

Push het image naar DockerHub:
```console
$ docker push alliander/sonarqube:7.7
```

### Bouwen in Openshift
Voeg eerste de ImageStream toe en daarna de BuildConfig om het image te bouwen.

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

