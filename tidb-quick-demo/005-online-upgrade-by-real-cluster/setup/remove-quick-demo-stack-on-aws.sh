./check_nodes.sh

aws cloudformation delete-stack \
  --stack-name quick-demo-005 \
  --region us-west-2

echo Tearing down stack - quick-demo-005 