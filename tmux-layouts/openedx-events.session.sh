# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/master-devstack/src/openedx-events/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "openedx-events"; then

  # Create a new window inline within session layout definition.
  tmux setenv -t openedx-events NVIM_SERVER /tmp/openedx_events-nvim.pipe
  tmux setenv -t openedx-events GIT_PARENT_BRANCH upstream-main
  new_window
  run_cmd "activate"
  run_cmd "v"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
