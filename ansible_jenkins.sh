##for centos6.x##
python get-pip.py
yum install -y libxml2 libxml2-devel libxslt libxslt-devel openssl openssl-devel libffi-devel gcc-c++ python-devel
pip install ansible==1.9.6
yum -y install openssh-server openssh-clients
yum install iputils -y


yum install java-1.8.0-openjdk-devel.x86_64

curl -o /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins

