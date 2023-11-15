function _create_user_account() {
  local user_name="$1"
  local uid="$2"
  local group_name="$3"
  local gid="$4"
  addgroup --gid "${gid}" "${group_name}"

  adduser --disabled-password --force-badname --gecos '' \
    "${user_name}" --uid "${uid}" --gid "${gid}" # 2>/dev/null

  # copy init scripts manually
  cp /etc/skel/.* $(getent passwd ${user_name} | cut -d: -f6)/

  usermod -aG sudo "${user_name}"
  usermod -aG video "${user_name}"
}
