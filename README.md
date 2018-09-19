Terraform Intro Demo
==============

This project contains some simple terraform code to show some of the simple features of terraform managing AWS infrastructure in a single account.
To see a overview of all the steps and the final code, see the master branch.

Step 6
----

This step creates an RDS instance using an `aws_db_instance` resource. It will also install the postgres client on the EC2 instance. You should be able to see the instance in the AWS console when its done.
However, at this stage you will not be able to access the RDS instance from the EC2 instance or elsewhere. Any attempt to connect will just hang. We'll fix this in the next step

    
    
