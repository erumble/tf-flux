#!/usr/bin/env zsh

external_tools=(
  k3d
)

for tool in ${(@)external_tools}; do
  if ! command -v $tool &>/dev/null; then
    echo "$tool not installed"
    exit 1
  fi
done

usage() {
  printf "Purpose:\n"
  printf "  Removes all traces of all the things.\n"

  printf "\nUsage:\n"
  printf "  destroy.zsh\n"

  printf "\nOptions:\n"
  format="  %-4s%s\n"
  printf $format "-f" "Perform actual cleanup task"
  printf $format "-h" "Show this help text"
}

cleanup() {
  local workspace=$(terraform workspace show)
  local tfvars=vars/${workspace}.tfvars
  terraform destroy --var-file=${tfvars} -auto-approve
  # ${workspace#*-} is a non-greedy forwards trim (#*), it erases everything up do and including the first `-`
  # ${workspace##*-} is a greedy forwards trim (##*), it erases everything up do and including the last `-`
  # backwards trims work the same way, the syntax uses `%` instead of `#`
  k3d cluster delete ${workspace#*-}
  rm -f ${tfvars}
}

while getopts ":fh" opt; do
  case  $opt in
    f  ) cleanup; exit;;
    h  ) usage; exit;;
    \? ) usage; exit;;
  esac
done

usage
