# Hygieia Quick Start

This repo is a companion to the [Hygieia](https://hygieia.github.io/) project with a goal of helping you get Hygieia up and running quickly and securely. The initial configuration is deployed to AWS and capable of supporting about 100 team dashboards out of the box. Support for additional cloud providers may be added in the future.

### Prerequisites
Before you start you will need the following:

1. A computer with a Bash shell installed
1. A [Git client](https://git-scm.com/downloads) is helpful if you want clone this repo, but is not required.

For AWS you will need:
1. An [AWS Account](https://aws.amazon.com/account/)
1. Permissions to run CloudFormation, create IAM roles and security groups. See [security.template](cfn/security.template) for the IAM roles and security groups created.
1. An [AWS Command Line Interface (CLI)](https://aws.amazon.com/cli/) installed and connected to your AWS account.
1. An [AWS S3 bucket](https://aws.amazon.com/s3/) in your account for storing the CloudFormation code used to launch Hygieia.


### Step 1: Install MongoDB

The first thing you need with Hygieia is a MongoDB database to store the data. We recommend following the [AWS MongoDB Quick Start](https://aws.amazon.com/quickstart/architecture/mongodb/) to setup your database. This secure implementation takes about 15 minutes to setup via CloudFormation and can run inside an existing VPC or one it creates. Once done, your environment will look like this:

![Figure 1](images/aws_quickstart_mongodb.png)


### Step 2: Install Hygieia

1. Clone or download this repo locally and change to the project root directory ```cd hygieia-quickstart```.
1. Create a new file named ```deploy.properties``` by copying the existing [example.properties](example.properties). Modify this file to provide your environment-specific Hygieia settings and save when done.
1. Modify the [bin/config](bin/config) file to provide the name of your S3 bucket and save when done. Optionally modify the AWS region and Stack name.
1. From the root directory, run the command ```bin/package```. This merges your ```deploy.properties``` settings and generates CloudFormation files that are uploaded to S3 bucket defined in ```bin/config```.
1. From the root directory, run the command ```bin/deploy```. This runs CloudFormation that provisions Hygieia in AWS and starts the services.

The deploy command takes about 3-4 minutes to run and creates a new CloudFormation stack named ```Hygieia-Quickstart``` by default. Outputs of the command include the URL of the new load balancer. Make note of it as this will be how you connect to the UI Server in the next step.

When done your environment will look like this.

![Figure 2](images/aws_quickstart_hygieia.png)

At this point the Hygieia UI server, API server and a set of collectors should be deployed and running. All of them should be connected to the database created in step 1.


### Step 3: Configure Hygieia

In order to start collecting data within your environment, collectors need to have connection information to source systems such as Jenkins, Jira, Sonar or GitHub. Once data is being collected, you can also create dashboards.

1. Follow the [Hygieia instructions to create an Admin user](https://hygieia.github.io/Hygieia/signup.html).
1. Open a browser and using the URL from step 2, login to your Hygieia UI Server as the Admin server.
1. Configure the installed collectors via the UI Server (cog icon in top right). Note: In order to configure a collector, the ```CreateXXXXCollector``` property in ```deploy.properties``` must be set to true. If you'd prefer, you can set collector configuration information in ```deploy.properties``` and re-run the ```bin/package``` and ```bin/deploy``` commands.
1. Follow the [Hygieia instructions to create a Team Dashboard](https://hygieia.github.io/Hygieia/create_team_dashboard.html).

If all went well you should have your first Team Dashboard up and running. Congrats!


### Feedback

If you find something unclear or have an idea for an improvement, please let us know by creating a new issue.
