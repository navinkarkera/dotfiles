# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/master-devstack/src/openedx-events/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "openedx-events"; then

  # Create a new window inline within session layout definition.
  new_window "code"
  run_cmd "activate"
  run_cmd "e"

  new_window "shell"
  run_cmd "activate"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
