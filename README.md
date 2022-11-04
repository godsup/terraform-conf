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
