# counter-service
## Note
the work has been bone in the main branch.
## Terraform
the directory aws contains two directory using terraform:
- vpc: to create the vpc, 3 subnets one per zone and VM on the VPC to run the different tools like flux
- eks: to create the eks cluster

## Pipeline - CI
I have used AWS CodeBuild to create the image on ECR, the pipeline file is buildspec.yml.

## CD - Flux
I have used flux 1.22, it's using the Git: https://github.com/sbouhnik/flux-get-started.git

flux is also doing the synchronization of the POD with the ECR image

## Bonus -- Persistency an HA 
the counter is persistent on a local rep of the node.
I haven't implemented the HA due to the persistency 
