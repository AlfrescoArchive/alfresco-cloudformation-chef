Alfresco CloudFormation Template with Chef
==========================================

*Disclaimer:* This CloudFormation template should be considered for illustrative/educational purposes only. No warranty is expressed or implied. Improvements and any other contributions are encouraged and appreciated.

*Notes:*
* Extensive documentation about how to use this template will be available soon at http://aws.amazon.com
* There are two templates one for GovCloud and the other for the rest of the AWS Regions. Don't use the GovCloud one unless you have got access to AWS GovCloud Region, otherwise it won't work.

*Demo:* Watch a 10 minutes demo here https://www.youtube.com/watch?v=pwFyVG6XV_o

Overview
--------------------

This template will instantiate a 2-node Alfresco cluster with 2 dedicated Index servers the following capabilities:
* All Alfresco and Index nodes will be placed inside a Virtual Private Cloud (VPC) each node in a differente AZ, dame Region.
* An Elastic Load Balancer instance with "sticky" sessions based on the Tomcat JSESSIONID.
* Shared S3 ContentStore
* MySQL database on RDS instances with RDS slave in another AZ.
* Each Alfresco and Index node will be in a separate Availability Zone.
* Auto-scaling roles that will add extra Alfresco and Index nodes when certain performance thresholds are reached.
* Result of the AWS CloudFormation template deployment:
![AWS Alfresco diagram](img/aws-alfresco.png "AWS Alfresco Diagram")

Basic Usage
-----------
There are a number of tasks that you must complete as part of the deployment.

Before launching the AWS CloudFormation template, you must:
* Create an Amazon EC2 key pair
	* The Amazon EC2 key pair provides SSH access to the instances created by the AWS CloudFormation template. If you already have a key pair you would like to use, you can skip this step.  
To create a key pair, use the instructions on https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html.
* Accept terms to use the CentOS 7 AMI from the AWS Market (*Step NOT REQUIRED for GovCloud since it uses RedHat 7*)
	* Alfresco and its index servers use CentOS 7 as base operating systems for this environment. To be able to use the CentOS 7 AMI, accept the use conditions from this page (login to your AWS account): https://aws.amazon.com/marketplace/pp/B00O7WM7QW/ref=sp_mpg_product_title?ie=UTF8&sr=0-10
Click Continue. You’ll then see the Launch on EC2 page. Finally, select the Manual Launch tab, and then click Accept Terms.
* Launch the [AWS Console](http://aws.amazon.com/console/cloudformation)
* Click *Create Stack*.
* Name and upload the Alfresco CloudFormation Template.
* Click *Continue*.
* Fill out the form making sure you review the following:
	* Ask for your trial license to your Alfresco Sales representative or Alfresco Support.
	* Ensure you use the name of an unique S3 bucket to be created.
	* Verify the instance sizes and be mindful of the hourly costs (that can be reviewed in the next section).
	* Provide the logins and passwords for the database and Alfresco admin accounts. These accounts and passwords will be created & set by the template.
	* Ensure you set the correct EC2 key.
* Click *Continue* and finish the wizard.

Tips
----
* The instances will take from 30 minutes to 1h to start (it depends on the AWS Region and instance types because Alfresco and its components has to be downloaded and installed).
* Use the *Events* tab to review status and any errors.
* Once the environment starts, use the *Output* tab to get the URL of the load-balancer.
* If stack deletion does not complete and the *Events* show an error related to VPC, login to the VPC console and delete the corresponding VPC; then delete the stack again.
* Internals of the deployment:
![AWS Alfresco diagram internals](img/aws-alfresco-inside.png "AWS Alfresco diagram internals")

Main differences between the regular Alfresco CloudFormation Template and the one for AWS GovCloud:
---------------------------------------------------------------------------------------------------
* Instance types may differ since GovCloud supports less types than the rest of AWS Regions.
* S3 policy has different arn for GovCloud.
* Default AMI for GovCloud is RedHat 7 instead of CentOS 7.
* We use a different configuration json file in our Chef code for RedHat 7 (chef-alfresco 0.6.18, enabled additional yum repos to install LibreOffice and Python pip, added  s3service.s3-endpoint=s3-us-gov-west-1.amazonaws.com to alfresco-global.properties).
* Login from NAT to the servers is with ec2-user instead of CentOS in GovCloud because of RedHat 7.

License
-------
   Copyright 2016 Alfresco Software, Ltd.
   Copyright 2016 Amazon Web Services, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

This work may reference software licensed under other open source licenses, please refer to these respective works for more information on license terms.
