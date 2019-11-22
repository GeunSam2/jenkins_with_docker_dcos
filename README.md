# Dockerizing Jenkins
> Spec
* Base_Image : jenkins/jenkins:2.190.3-centos
* Jenkins_version : 2.190.2
* DCOS_CLI : 1.13.5
* Docker : 1.13.1

> What is Different
* User : jenkins -> root
* Docker : Install Docker inside of jenkins container
* DCOS_CLI : You can use DCOS CLI for version 1.13.5
* jq command : You can use jq command

> How to use

* Run with docker

```
docker run -d -p <host-port>:8080 \
-v /path/for/data:/var/jenkins_home \
-v /path/for/docker:/var/lib/docker \
<image-you-builded>
```

* Run with marathon / DCOS

```json
{
  "env": {
    "TZ": "Asia/Seoul"
  },
  "id": "/ci-cd/jenkins",
  "backoffFactor": 1.15,
  "backoffSeconds": 1,
  "constraints": [
    [
      "hostname",
      "LIKE",
      "ip.addr.ifyou.want"
    ]
  ],
  "container": {
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 0,
        "protocol": "tcp",
        "name": "jenkins"
      }
    ],
    "type": "DOCKER",
    "volumes": [
      {
        "containerPath": "/var/jenkins_home",
        "hostPath": "/path/for/data",
        "mode": "RW"
      },
      {
        "containerPath": "/var/lib/docker",
        "hostPath": "/path/for/docker",
        "mode": "RW"
      }
    ],
    "docker": {
      "image": "geunsam2/jenkins_dcos_docker:2.190.2",
      "forcePullImage": true,
      "privileged": true,
      "parameters": []
    }
  },
  "cpus": 2,
  "disk": 0,
  "healthChecks": [
    {
      "gracePeriodSeconds": 300,
      "intervalSeconds": 60,
      "maxConsecutiveFailures": 3,
      "portIndex": 0,
      "timeoutSeconds": 20,
      "delaySeconds": 15,
      "protocol": "MESOS_HTTP",
      "path": "/login",
      "ipProtocol": "IPv4"
    }
  ],
  "instances": 1,
  "maxLaunchDelaySeconds": 3600,
  "mem": 4096,
  "gpus": 0,
  "networks": [
    {
      "mode": "container/bridge"
    }
  ],
  "requirePorts": false,
  "upgradeStrategy": {
    "maximumOverCapacity": 1,
    "minimumHealthCapacity": 1
  },
  "killSelection": "YOUNGEST_FIRST",
  "unreachableStrategy": {
    "inactiveAfterSeconds": 0,
    "expungeAfterSeconds": 0
  },
  "fetch": []
}
```

