This repository will contain templates of Ansible playbooks
that I've worked on and from other sources, I.E. Documentation, Internet, etc..



NOTES:

Most of your variables will be defined within /etc/ansible/vars or you can specify them within the hosts file

all system wide configuration will be set within /etc/ansible

any local configuration can be set where you specify but you will have to use the correct flags and path


The playbooks found within the playbooks folder are to be used as examples/templates

for further information/details see Ansible documentation.


Also the ssh key of the ansible "controller node" needs to be pushed out to all of the machines.
for more information see: https://docs.ansible.com/ansible/2.9/installation_guide/intro_installation.html (Official Ansible Documentation)


for a list of ansible modules see: https://docs.ansible.com/ansible/latest/collections/index.html#list-of-collections --> Usually, I will use ansible.builtin or ansible.posix modules...