#!/usr/bin/env bash

#Checking requirements
if [[ `getconf LONG_BIT` != "64" ]]
then
        echo "AWS publisher requires a 64bit OS."
        exit 1
fi

if [[ $UID -ne 0 ]]; then
        echo "$0 must be run as root."
        exit 1
fi

#Stopping the aws-publisher.
if [[ -e /etc/init.d/aws-publisher ]];then
    	echo "AWS Publisher is already installed, trying to stop the service."
    	echo "*****"
	service aws-publisher stop
fi

mkdir -p /usr/local/ec2/aws-publisher/lib /usr/local/ec2/aws-publisher/bin /var/log/aws-publisher
echo 
echo "*****"
echo "Getting the required libraries from the installation bucket."
wget -q -P /usr/local/ec2/aws-publisher/lib/aws-java-sdk-1.3.21 https://s3.amazonaws.com/publisher-bucket/lib/aws-java-sdk-1.3.21/aws-java-sdk-1.3.21.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/ https://s3.amazonaws.com/publisher-bucket/lib/awsPublisher.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-codec-1.7 https://s3.amazonaws.com/publisher-bucket/lib/commons-codec-1.7/commons-codec-1.7.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-configuration-1.9 https://s3.amazonaws.com/publisher-bucket/lib/commons-configuration-1.9/commons-configuration-1.9.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-daemon-1.0.10 https://s3.amazonaws.com/publisher-bucket/lib/commons-daemon-1.0.10/commons-daemon-1.0.10.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-lang-2.6 https://s3.amazonaws.com/publisher-bucket/lib/commons-lang-2.6/commons-lang-2.6.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-logging-1.1.1 https://s3.amazonaws.com/publisher-bucket/lib/commons-logging-1.1.1/commons-logging-1.1.1.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-logging-1.1.1 https://s3.amazonaws.com/publisher-bucket/lib/commons-logging-1.1.1/commons-logging-adapters-1.1.1.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/commons-logging-1.1.1 https://s3.amazonaws.com/publisher-bucket/lib/commons-logging-1.1.1/commons-logging-api-1.1.1.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/httpclient-4.2.1 https://s3.amazonaws.com/publisher-bucket/lib/httpclient-4.2.1/httpclient-4.2.1.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/httpclient-4.2.1 https://s3.amazonaws.com/publisher-bucket/lib/httpclient-4.2.1/httpcore-4.2.1.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/jackson-core-1.8.7 https://s3.amazonaws.com/publisher-bucket/lib/jackson-core-1.8.7/jackson-core-asl-1.8.7.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/jackson-core-1.8.7 https://s3.amazonaws.com/publisher-bucket/lib/jackson-core-1.8.7/jackson-mapper-asl-1.8.7.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/log4j-1.2.17 https://s3.amazonaws.com/publisher-bucket/lib/log4j-1.2.17/log4j-1.2.17.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/libsigar-amd64-linux.so
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/libsigar-x86-linux.so
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/sigar-amd64-winnt.dll
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/sigar-x86-winnt.dll
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/sigar-x86-winnt.lib
wget -q -P /usr/local/ec2/aws-publisher/lib/sigar https://s3.amazonaws.com/publisher-bucket/lib/sigar/sigar.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/wel4j-core https://s3.amazonaws.com/publisher-bucket/lib/wel4j-core/wel4j-core.jar
wget -q -P /usr/local/ec2/aws-publisher/lib/wel4j-core https://s3.amazonaws.com/publisher-bucket/lib/wel4j-core/wel4j32.dll
wget -q -P /usr/local/ec2/aws-publisher/lib/wel4j-core https://s3.amazonaws.com/publisher-bucket/lib/wel4j-core/wel4j64.dll
wget -q -P /usr/local/ec2/aws-publisher/bin/ https://s3.amazonaws.com/publisher-bucket/bin/jsvc
chmod +x /usr/local/ec2/aws-publisher/bin/jsvc
echo "Retrieved the required libraries successfully."
echo 

echo "*****"
echo "Checking for a JRE at /usr/local/ec2/aws-publisher/jre/ ..."
if [[ -e /usr/local/ec2/aws-publisher/jre/bin/java ]];then
    	echo "JRE is already installed, skipping download."
    	echo "*****"
    else
		echo "JRE is not installed, downloading and installing JRE 1.7"
		wget -q -P /usr/local/ec2/aws-publisher/ https://s3.amazonaws.com/publisher-bucket/jre-7u7-linux-x64.tar.gz
		tar -C /usr/local/ec2/aws-publisher/ -zxf /usr/local/ec2/aws-publisher/jre-7u7-linux-x64.tar.gz
		mv /usr/local/ec2/aws-publisher/jre1.7.0_07 /usr/local/ec2/aws-publisher/jre && rm -f /usr/local/ec2/aws-publisher/jre-7u7-linux-x64.tar.gz
		echo "JRE 1.7 installed to /usr/local/ec2/aws-publisher/jre/"
		echo "*****"
fi

echo
echo "Installing prerequisites."
wget -q -P /etc/init.d/ https://s3.amazonaws.com/publisher-bucket/bin/aws-publisher
chmod +x /etc/init.d/aws-publisher
chkconfig --add aws-publisher
chkconfig aws-publisher on
echo "Done installing prerequisites"
echo

echo "*****"
echo "Starting the aws-agent service." 
service aws-publisher start
echo
echo "Installer completed, exiting."
exit 0
