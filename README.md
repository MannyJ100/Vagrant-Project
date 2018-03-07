## Title

# Vagrant Project

## Description

A vagrant project for running a virtual machine provisioned with the ELK stack

## Technologies

- ELK Stack
  - Elasticsearch
  - Kibana
  - Logstash

## Dependancies

- ChefDK
- Vagrant
- VirtualBox

## Installation and Usage

To begin with, please clone this repository to your local machine.

### Starting up the Machine

Assuming all of the dependancies for this project are installed, after cloning this repository simply run vagrant up from the root of the cloned repository.

### ELK Stack Setup

Once vagrant has finished launching the virtual machine, navigate to dev.local:9200 to see Kibana in action. At first, there will be no data in Elasticsearch for Kibana to display.

Run `sudo nano /etc/logstash/conf.d/10-syslog.conf` and when the editor opens, paste this in and save

```input {
  file {
    type => "syslog"
    path => [ "/var/log/", "/var/log/*" ]
  }
}
output {
  stdout {
    codec => rubydebug
    }
    elasticsearch {
      hosts => "http://localhost:9200" # Use the internal IP of your Elasticsearch server
    }
}```

Now run `chmod u=rwx,g=rwx,o=rwx /var/log` then `sudo service logstash restart`. Kibana will now have access to the local logs stored in syslog.

### FileBeat Setup

Now we need to set up FileBeat on a machine to send logs to logstash. This can be either on the same vagrant machine or on another one as long as it has network access to the ELK Stack machine.

Assuming a Debian based Linux system, run `curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-amd64.deb` then `sudo dpkg -i filebeat-6.2.2-amd64.deb`.

Now we need to set up FileBeat to send logs to logstash run `sudo nano /etc/filebeat/filebeat.yml` then paste this in:

```filebeat.prospectors:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*

output.elasticsearch:
  hosts: ["[ELK IP]:9200"]```

Finally run `sudo service logstash restart`


After this is all done, Kibana should be able to display the logs it is sent from the machine where LogStash is running.