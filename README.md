# demo - devops

Terraform is used as tool for building, changing, and versioning of infrastructue, security and compliance.

The repository is designed to support multiple environments:

- `nonprod-shared` - contains account-level infra for NonPhi account.
- `dev` - development logical environment that sits on top of the infrastructure created by nonprod-shared environment.

###### ToDo: add prod-shared, qa, stg, prod envs

## Points of Contact
 - Prakash@xyz.com - Prakash

## Developer Guidelines

### Terraform Installation
This repo uses 1.9.2 terraform version, so installing terrafrom make sure to choose the correct version.
Or, make use of tfswitch/tfenv for version switch. This enables to correctly switch between different version of terrafrom. For installation refer to below links:
- [tfswitch](https://tfswitch.warrensbox.com/Installation/)
- [tfenv](https://formulae.brew.sh/formula/tfenv)

Making use of `pre-commit` is also appreciated for terraform module changes and properly updating module ReadMe.md

### AWS Authentication
Depends on org, could be sso, privileged identity management (azure), user created in aws.

### Terraform Development
While working with terraform it is always recommended not to reun `terrafrom destory` cmd from you local environment.
Below are the steps for contributing in terraform modules:
- For now, we recommend to make changes in your branch locally.
- Authenticate to aws.
- depending upon the in which module you are making changes, switch to either dev or nonprod-shared directory.
- Run `terraform init` cmd to initialize the working directory containing Terraform configuration files.
- If init is successful, run `terraform plan`. Verify the plan logs. If every thing looks fine then push your changes and create a PR.
- the PR will be reviewed, merge, and deployed.
###### ToDo: workspace implementation will done in future, to enable developer specific environments. Create a terraform ci/cd pipeline to deploy resources.

### Possible Resource Enhancements:
#### For MySql RDS
- Enable Enhanced Monitoring (if required)
- Enable RDS encryption using KMS key (if required)
- Revisit security group egress/ingerss and remove rules that are not required

#### For ec2 Instance/launch tempalte
- Create a cloudwatch alarm metric alarm (similar to rds)
- We can send ec2 logs to cloudwatch using cloudwatch agent to collect and forward logs

#### CloudTrail Auditing
- Enable CloudTrail to capture all compatible events in a region. Please refer following documentation [cloudtrail-user-guide](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html), [cloudtrail-terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail), 


##### Required Link: [Required EP](dev-demo-alb-97916946.us-east-1.elb.amazonaws.com)
