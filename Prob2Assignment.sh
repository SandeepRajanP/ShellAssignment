#!/bin/bash

#Creating 2 instances
aws ec2 run-instances --image-id ami-14c5486b --instance-type t2.micro --key-name shellscripting --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=SandeepUploadS3Bucket},{Key=username,Value=SandeepRajanP},{Key=emailId,Value=sandeeprajan.p@quantiphi.com},{Key=Project,Value=PE_Training}]' --iam-instance-profile Arn=arn:aws:iam::488599217855:instance-profile/PE_trainee_Admin_role --user-data  '#!/bin/bash
echo "This file will be uploaded to ec2instance">upload.txt
aws s3 cp upload.txt s3://buckettraining007/uploaded.txt' --region us-east-1

aws s3 ls s3://buckettraining007/uploaded.txt
while [ $? -ne 0 ]
do
    aws s3 ls s3://buckettraining007/uploaded.txt
    if [[ $? -eq 0 ]]
    then
        break
    fi
    aws s3 ls s3://buckettraining007/uploaded.txt 
done

aws ec2 run-instances --image-id ami-14c5486b --instance-type t2.micro --key-name shellscripting --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=SandeepDownloadS3Bucket},{Key=username,Value=SandeepRajanP},{Key=emailId,Value=sandeeprajan.p@quantiphi.com},{Key=Project,Value=PE_Training}]' --iam-instance-profile Arn=arn:aws:iam::488599217855:instance-profile/PE_trainee_Admin_role --user-data '#!/bin/bash
aws s3 cp s3://buckettraining007/uploaded.txt download.txt' --region us-east-1

