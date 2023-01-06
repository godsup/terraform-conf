## Terraform blue - green deployment

### Purpose of the deployment
Blue-green deployments and rolling deployments (canary tests) allow you to release new software gradually, and identify and mitigate the potential blast radius of a failed software release. This allows you to release new software with near-zero downtime.

### How to deploy

1. Clone repo

2. Configure AWS CLI

3. terraform init

4. terraform apply

5. After terraform apply you will be asked to enter traffic distribution:

You can enter the following variables:

blue (100% load to blue)

blue-90 (90% load to blue and 10% to green)

split (load is split 50/50 % between green and blue)

green-90 (10% load to blue and 90% to green)

green (100% load to green)
