FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install curl git python-pycurl python-pip python-yaml python-paramiko python-jinja2
RUN pip install ansible==1.8.2

RUN mkdir /tmp-work

WORKDIR /tmp-work

RUN git clone https://github.com/BradleyDejong/smart-on-fhir-installer

WORKDIR smart-on-fhir-installer/provisioning

RUN ansible-playbook -c local -i 'localhost,' -vvvv smart-on-fhir-servers.yml
