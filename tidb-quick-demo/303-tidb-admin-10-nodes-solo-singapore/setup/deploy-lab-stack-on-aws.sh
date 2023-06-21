aws cloudformation create-stack \
  --stack-name lab-303-v2 \
  --on-failure DO_NOTHING \
  --template-body file://lib/_lab-303-pe-cloud-formation.json \
  --region ap-southeast-1 \
  --capabilities CAPABILITY_IAM \
  --parameters "ParameterKey=TrainerName,ParameterValue=${1}" "ParameterKey=TrainerEmail,ParameterValue=${2}"
