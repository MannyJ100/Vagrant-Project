## Title

# Vagrant Project

## Description

A vagrant project for running a virtual machine provisioned with the ELK stack

## Technologies

- Virtualisation
  - ChefDK
  - Vagrant

- ELK Stack
  - Elasticsearch
  - Kibana
  - Logstash

## Installation and Usage

To begin with, please clone this repository to your local machine.

### Dependancies

- ChefDK
- Vagrant
- VirtualBox

### Starting up the Machine

Assuming all of the dependancies for this project are installed, after cloning this repository simply run vagrant up from the root of the cloned repository.

### Using This Repository

Once vagrant has finished launching the virtual machine, navigate to dev.local:9200 to see Kibana in action. At first, there will be no data in Elasticsearch for Kibana to display.

run `sudo nano /etc/logstash/conf.d/10-syslog.conf` and when the editor opens, paste this in and save

input {
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
}

Now run `sudo service logstash restart`. Kibana will now have access to the local logs stored in syslog.
