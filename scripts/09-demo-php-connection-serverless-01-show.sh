#!/bin/bash

# Run 09-demo-php-connection-serverless-01-show.sh <host> <user_name> <password>
# e.g. ./09-demo-php-connection-serverless-01-show.sh gateway01.ap-southeast-1.prod.aws.tidbcloud.com <user_prefix>.root <password>

php DemoPhpConnectionServerless.php $*
