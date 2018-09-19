Terraform Intro Demo
==============

This project contains some simple terraform code to show some of the simple features of terraform managing AWS infrastructure in a single account.
To see a overview of all the steps and the final code, see the master branch.

Step 2
----
This step dds an index.html file to the S3 bucket created in step 1.
It configures the bucket to run as a simple website.
You can see the file in the S3 console and you should be able to open it up in you browser.
To do that you'll need to look at bucket name, in this example it is `terraform-intro-demo-bucket`. The URL will be in the following format; `http://<bucket-name>.s3.amazonaws.com`. 
So our bucket becomes `http://terraform-intro-demo-bucket.s3.amazonaws.com`

