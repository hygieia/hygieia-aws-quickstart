# hygieia-quickstart

Get up and running with Hygieia quickly, with minimal fuss

# Project Structure

```
        .
        ├── bin                           # Scripts used for quickstart
        │   ├── config                    # User specified properties
        │   ├── delete
        │   ├── deploy
        │   └── package
        ├── cfn                           # CloudFormation templates
        │   ├── director.template
        │   ├── micro-service.template
        │   └── security.template
        ├── deploy.properties             # User specified properties
        ├── LICENSE
        ├── packaged.template             # Created by bin/package
        └── README.md
```

## Quickstart Steps

### 1.  Clone this repository to a machine configured to access to your AWS Account via AWS CLI.

```
        $ git clone https://github.com/singlestone/hygieia-quickstart.git
        $ cd hygieia-quickstart
```

### 2.  Create a `deploy.properties` file

| Property                 | Default Value | Required?                    | Type?  |
| ------------------------ | ------------- | ---------------------------- | ------ |
| ClusterName              | Hygieia       | No                           | string |
| CreateMongoDB            |               | Yes                          | bool   |
| CreateJenkinsCollector   |               | Yes                          | bool   |
| CreateSonarQubeCollector |               | Yes                          | bool   |
| CreateGitHubCollector    |               | Yes                          | bool   |
| CreateJiraCollector      |               | Yes                          | bool   |
| MongoDBHost              |               | Yes if `CreateMongoDB=false` | string |
| MongoDBPort              | 27017         | No                           | string |
| DatabaseUsername         | dashboarduser | No                           | string |
| DatabasePassword         |               | Yes                          | string |
| DatabaseName             | dashboarddb   | No                           | string |

At a minimum, the required properties above should be set to deploy the Hygieia-Quickstart.

### 3. Edit `bin/config` and start packaging/deploying

Inside the included `bin/config`, a set of variables is defined. An existing S3 Bucket is required for deployment. You will need to set `bin/config` `S3_BUCKET` parameter to the name of your S3 Bucket. You can also edit the CloudFormation Stack Name through the `STACK_NAME` variable or the AWS Region via `AWS_REGION`, if desired.

Now that `bin/config` is updated, we can run

```
$ bin/package
```

This will run `aws cloudformation package`, which will package our local artifacts and push them to the S3 Bucket defined in `bin/config`. This also produces a file called `packaged.template` which is deployed in the next step.

### 4. Deploy

```
$ bin/deploy
```

This script will run `aws cloudformation deploy` and pass in your properties from `deploy.properties`. A changeset will be created and a CloudFormation stack will be created/updated.

### 5. Collector Config

Any collectors that were deployed can be configured through the Hygieia Administrator UI (accessed via cog in top right corner of browser--shown when logged in as 'admin'). The first user created with name 'admin' is the administrator user. You can create this user using the sign-up functionality of the Hygieia UI.

These collectors can also be configured through the `deploy.properties` file. The currently configurable options are listed below:

```
JenkinsHost
JenkinsUser
JenkinsApiKey
JenkinsServerName

SonarUser
SonarPassword
SonarHost
SonarMetrics
SonarVersion

GitHubHost
GitHubPersonalAccessToken
GitHubCommitThresholdDays

JiraHost
JiraCredentials
JiraSprintDataFieldName
JiraStoryPointsFieldName
JiraIssueTypeNames
JiraEpicFieldName
```

Note these options will have no effect unless their respective `CreateXXXXCollector` is set `true`.

### Sample `deploy.properties` files

#### Using a MongoDB Container:

```
ClusterName=Hygieia
CreateMongoDB=true
CreateJenkinsCollector=true
CreateSonarQubeCollector=true
CreateGitHubCollector=false
CreateJiraCollector=false

VpcId=vpc-fba03cae
SubnetA=subnet-bb234059
SubnetB=subnet-fjbi20a3

DatabaseUsername=dashboarduser
DatabasePassword=dbpassword
DatabaseName=dashboarddb
```

#### Using an external MongoDB instance/cluster:

```
ClusterName=Hygieia
CreateMongoDB=false
CreateJenkinsCollector=true
CreateSonarQubeCollector=true
CreateGitHubCollector=false
CreateJiraCollector=false

VpcId=vpc-fba03cae
SubnetA=subnet-bb234059
SubnetB=subnet-fjbi20a3

MongoDBHost=52.519.33.254
MongoDBPort=27017
DatabaseUsername=dashboarduser
DatabasePassword=dbpAssword1
DatabaseName=dashboarddb
```
