# ============================================================
# PROVIDERS
# ============================================================
# Uses AWS CLI named profiles (~/.aws/credentials)
# Profile "dev"  → us-east-1  (dev environment)
# Profile "test" → us-west-2  (test environment)
# ============================================================

#defualt region is us-east-1 but we can specify the region here if we want to use a different region
 #here dev = defualt profile in provider.tf

# calling keys from my local machine dev profile credentials 
## dev environment provider block##

provider "aws" {
  alias   = "devenv" #if multiple providers are used then we have to give alias to the provider and then we can call that provider in the resource block
  region  = "us-east-1"
  profile = "dev"
}

# calling keys from my local machine prod profile credentials 
## prod environment provider block##
provider "aws" {
  alias   = "testenv" 
  region  = "us-west-2"
  profile = "test"
}



