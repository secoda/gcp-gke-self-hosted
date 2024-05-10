# GCP Terraform

## Initial Steps

1. `brew install --cask google-cloud-sdk`

2. `gcloud init && gcloud components install gke-gcloud-auth-plugin`

3. `gcloud auth application-default login`

4. Get the repository:

```
git clone https://github.com/secoda/gcp-self-hosted-tf
cd gcp-self-hosted-tf
cp -r example customer
brew install terraform
cd customer
terraform init
```

## Simple deployment

1. `cp rename.onprem.tfvars onprem.tfvars` then fill `onprem.tfvars` in:
You will need to:
- Set the `docker_password` with the one provided by Secoda
- Set your GCP account and billing information
- Set your email address. This is required for some Terraform automated quota adjustments
- Choose a project and folder name for Secoda (both will be created)
- Set the FQDN endpoint for Secoda
- Enter a list of authorized domains to prevent outside logins to Secoda

2. Then run:
```bash
# The order of these commands is important:
terraform apply -var-file="onprem.tfvars"  --target=module.project_setup
# Type `yes` at the prompt.
terraform apply -var-file="onprem.tfvars" --target module.secoda_deploy.google_container_cluster.primary
# Type `yes` at the prompt.
terraform apply -var-file="onprem.tfvars" --target module.secoda_deploy.helm_release.redis --target module.secoda_deploy.helm_release.elasticsearch
# Type `yes` at the prompt.
```

**Note** - Terraform will exit before the services have finished deploying and have become available.
You must wait for them to be completely deployed before moving to the next step. To monitor the services,
go to your Secoda project and type `kubernetes workloads` into the search bar, the click on `Workloads`
under `PRODUCTS & PAGES`. You should expect to see errors and warnings here as GKE provisions capacity to
launch the new containers.

Wait for the two Stateful Sets, `elasticsearch-es-default` and `redis-master` to come up as shown by `Status` of `OK` and
`1/1` value for Pods (it can take a while). You can also click on any of the workloads to view logs and operational metrics.

3. Now you may finish the installation by running
```bash
terraform apply -var-file="onprem.tfvars"
# Once again, type `yes` 
```

3. You must create a CNAME record with your DNS provider that points your your domain, i.e. `secoda.yourcompany.com` to your ingress external ip. The ingress IP will be displayed as `ingress_external_ip` output when the Terraform deployment completes.
4. Wait about 10 minutes. Then open `https://secoda.yourcompany.com` to test out the service. It will only listen on **HTTPS**. Make sure you use `https://` and not `http://`.
5. We suggest using _Cloudflare ZeroTrust_ to limit access to Secoda; optional.

## Connecting to Secoda

- Load balancer is publicly accessible by default (IP is returned after running `terraform apply`). You will not be able to connect to the IP. The ingress will only accept connections via the `domain` name. There will be a delay on first setup as the registration target happens ~5 minutes.
- We suggest using _Cloudflare ZeroTrust_ to limit access to Secoda.

## Updating Secoda

- It is configured to pull the latest images automatically on restart.
- `kubectl rollout restart deployment -n secoda` will redeploy the application with the latest images.

## Destroying the deployment (irreversible)

1. Then run:
```bash
terraform destroy -var-file="onprem.tfvars"
# Type `yes` at the prompt.
```

# Misc.

## Hashicorp Cloud

To store state in Hashicorp cloud, which we recommend, please complete the following steps. You should be a member of a _Terraform Cloud_ account before proceeding.

In this directory, run `terraform login`. In `versions.tf` please uncomment the following lines and replace `secoda` with your organization name.

```yaml
backend "remote" {
  organization = "secoda"
}
```
