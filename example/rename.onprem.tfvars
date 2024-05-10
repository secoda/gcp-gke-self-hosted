# Copy this file to onprem.tfvars and fill it.

################################################################################
# Required
# These must be set before running for the first time.
################################################################################

# This will be provided by customer support.
docker_password = "********"

# Replace me with your endpoint domain name.
fqdn = "on-premise.secoda.co"

# Fill with your preferred region. Defaults to us-east1.
region = "us-east1"

# Set these to your GCP account values
billing_account   = "123ABC-321CBA-987CDE"
org_id            = "123456789012"
org_name          = "secoda.co"
gcp_contact_email = "example@secoda.co" #required to set quotas

# Set up authorized login domains to limit who can create accounts on your server
# this is a comma separated list with a double '\' escape on the comma
authorized_domains = "secoda.co\\,mydomain.com"

# Choose values for folder and project names or leave them set to "secoda"
project_name = "secoda"
folder_name  = "secoda"
