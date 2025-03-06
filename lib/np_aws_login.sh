export VAULT_ADDR=https://vault.dw.geaerospace.net:8200
export AWS_CA_BUNDLE=$(brew --prefix)/etc/ca-certificates/cert.pem
export AWS_PROFILE="adw-nonprod"
AWS_ACCT_ID="600627359380"
AWS_ACCOUNT=$(aws sts get-caller-identity --query "Account" --profile $AWS_PROFILE)
if [[ $AWS_ACCOUNT == $AWS_ACCT_ID ]]; then
  echo "AWS SSO profile $AWS_PROFILE has valid session to $AWS_ACCT_ID"
else
  echo "using 'aws sso' to login to $AWS_PROFILE"
  aws sso login --sso-session $AWS_PROFILE --profile $AWS_PROFILE
fi
echo "*** checking 'caller-identity' with 'aws sts' ***"
aws sts get-caller-identity --profile $AWS_PROFILE
echo "*** Now check the Vault login ***"
VAULT_ROLE='"ge_oidc"'
VAULT_TOKEN_TTL=$(vault token lookup -format json | jq .data.ttl)
VAULT_TOKEN_ROLE=$(vault token lookup -format json | jq .data.meta.role)
# echo "checking if $VAULT_TOKEN_ROLE == $VAULT_ROLE"
if [[ $VAULT_TOKEN_ROLE == $VAULT_ROLE ]] && echo "Vault Role matches"; then
  if (($VAULT_TOKEN_TTL > 0)) && (($VAULT_TOKEN_TTL < 7000)); then
    echo "*** ! Vault is logged in but your token's ttl is $VAULT_TOKEN_TTL, let's extend the ttl to 2hrs ***"
    vault token renew -increment=120m
  else
    echo "Vault might be logged in, but the token ttl compare isn't working as expected with ttl = $VAULT_TOKEN_TTL"
    vault token renew -increment=120m
  fi
else
  echo "Login to $VAULT_ADDR with $VAULT_ROLE"
  vault login -method=oidc -no-print
fi
