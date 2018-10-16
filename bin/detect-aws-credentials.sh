#!/usr/bin/env bash

if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    EMPTY_TREE=$(git hash-object -t tree /dev/null)
    against=$EMPTY_TREE
fi

# Redirect output to stderr.
exec 1>&2

if [ -n "$FILES" ]; then
   echo "Verifying the terraform format..please wait"
    terraform fmt
fi
echo
echo "*****************************"
echo
if [ -n "$FILES" ]; then
   echo "Validating the terraform code..please wait"
    terraform validate -check-variables=false
    if [ $? != 0 ]
    then
      echo "Code failed the teraform validation" >&2
      exit 1
    fi
fi
echo
echo "*****************************"
echo
if [ -n "$FILES" ]; then
    echo "Validating the terraform code for AWS Secrets..please wait"
    ACCESS_KEY=$(grep -rE --line-number 'access_key' $FILES)
    SECRET_KEY=$(grep -rE --line-number 'secret_key' $FILES)
    if [ -n "$ACCESS_KEY" ] || [ -n "$SECRET_KEY" ]; then
        exec < /dev/tty # Capture input
        echo "=========== Possible AWS Access Key IDs ==========="
        echo "${ACCESS_KEY}"
        echo ""
        if [ -n "$ACCESS_KEY" ] || [ -n "$SECRET_KEY" ]; then
            exec < /dev/tty # Capture input
            echo "=========== Possible AWS Access Key IDs ==========="
            echo "${ACCESS_KEY}"
            echo ""
        echo "=========== Possible AWS Secret Access Keys ==========="
        echo "${SECRET_KEY}"
        echo ""
            echo "=========== Possible AWS Secret Access Keys ==========="
            echo "${SECRET_KEY}"
            echo ""
        while true; do
            while true; do
                exit 1;
                    exit 1;
        done
            done
        fi
    fi
fi


exit 0
