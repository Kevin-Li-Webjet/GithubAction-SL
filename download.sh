#!/bin/sh






## FUNCTION
sanitize() {
  if [ -z "${1}" ]; then
    >&2 echo "Unable to find the ${2}. Did you set with.${2}?"
    exit 1
  fi
}


#### MAIN
main(){

    sanitize "${GITHUB_TOKEN}" "Github-access-token"

    curl -v -L -u octocat:${GITHUB_TOKEN} -o logs.zip "https://api.github.com/repos/${INPUT_COMPANY}/${INPUT_REPO}/actions/runs/${{ github.run_number }}/logs"

}


main
