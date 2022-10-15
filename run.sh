#!/bin/sh

usage() {
    cat <<EOF
usage: ${0##*/} [command]
    -h          Print this help message.
    -v          Validate terraform config.
    -a          Create or update infraestructure.
    -d          Destroy infraestructure.
EOF
    exit 1
}

RUN=
while getopts "hvad" OPTION; do
    case $OPTION in
    a) RUN=apply ;;
    v) RUN=validate ;;
    d) RUN=destroy ;;
    *) usage ;;
    esac
done

dir="$PWD"

cd "$dir/terraform/organization/bsmsapp" || exit

terraform init
if [ "$RUN" = 'apply' ]; then
    terraform plan
    terraform apply --auto-approve
else
    terraform "$RUN"
fi
