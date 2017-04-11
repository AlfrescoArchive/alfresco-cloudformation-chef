# Alfresco Content Services on the AWS Cloud
## Quick Start Reference Deployment

This new Quick Start automatically deploys an Alfresco Content Services cluster on the AWS Cloud. The Quick Start was created by AWS in partnership with Alfresco Software, to integrate solutions and services from both companies.
Alfresco Content Services is an Enterprise Content Management (ECM) system that is used for document and case management, project collaboration, web content publishing, and compliant records management. The flexible compute, storage, and database services that AWS offers make it an ideal platform for Alfresco Content Services. This Quick Start presents an enterprise-grade Alfresco Content Services configuration that you can adapt to virtually any scenario, and scale up, down, or out, depending on your use case.

![Quick Start Alfresco Content Services Design Architecture](https://d0.awsstatic.com/partner-network/QuickStart/datasheets/alfresco-content-services-architecture-diagram.png)

The Quick Start architecture includes the following components:
* Highly available Alfresco Content Services servers and Index servers deployed across two Availability Zones within your selected region. The servers take advantage of Auto Scaling and Elastic Load Balancing, with CPU-based thresholds that you can customize.
* Amazon Simple Storage Service (Amazon S3) for shared file storage.
* Amazon Relational Database System (Amazon RDS) Aurora in cluster (MySQL with Multi-AZ enabled in regions where Amazon Aurora currently not available) for the shared database.

The Alfresco Content Services deployment is automated by nested AWS CloudFormation templates. The templates call custom Chef cookbooks to automate installation and configuration tasks for Alfresco Content Services. The Quick Start gives you a option to either build a new AWS environment for Alfresco Content Services or use your existing AWS environment.


Deployment Guide: https://s3.amazonaws.com/quickstart-reference/alfresco/content/services/latest/doc/alfresco-content-services-on-the-aws-cloud.pdf


*Demo:* Watch a 6 minute demo here https://youtu.be/zEmoI9WwIXo
