# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/master-devstack/src/eox-tenant/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "eox-tenant"; then

  # Create a new window inline within session layout definition.
  tmux setenv -t eox-tenant NVIM_SERVER /tmp/eox-tenant-nvim.pipe
  tmux setenv -t eox-tenant GIT_PARENT_BRANCH upstream/master
  new_window
  run_cmd "activate"
  run_cmd "v"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
