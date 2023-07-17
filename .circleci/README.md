**CircleCI workflow description**
-
Here are two workflows which are conditionally executed based upon changes made to a specific fileset.

**config.yml** file has used the *path-filtering* orb, which allows a pipeline to continue execution based upon the specific paths of updated files (/infrastructure and /app directories).

**continue_config.yml** has two workflow:
1. infrastructure-deploy(run when changes are made in /infrastructure )
2. app-deploy((run when changes are made in /app )

**infrastructure-deploy** workflow has three jobs: create-infrastructure, hold-destroy(wait for manual approve to destroy infrastructure), and destroy-infrastructure.

**continue_config** workflow: 
- _test-cluster_ (this job check if ECS cluster exists; if not it stops executing workflow)
- _build-and-push-image_ (build and push Docker image into ECR repository)
- _dive-test_ (this job uses [Dive](https://github.com/wagoodman/dive) util to ensure you're keeping wasted space to a minimum)
- _hold-deploy_
- _deploy-image_ (deploy image to ECS cluster)

**Environment Variables**
-
You need to add environment variables in CircleCI:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- REGION
- AWS_ACCOUNT_ID
- TF_VAR_region
- STATE_BUCKET
- TF_VAR_ecr_repo
- TF_VAR_rds_passwd
- TF_VAR_cluster_name
- TF_VAR_service_name


