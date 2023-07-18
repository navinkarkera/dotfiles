# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/master-devstack/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "nutmeg-devstack"; then

  # Create a new window inline within session layout definition.
  tmux setenv -t nutmeg-devstack PYTHON_ENV_PATH /home/navin/work/python_shared_venvs/py38/
  tmux setenv -t nutmeg-devstack NVIM_SERVER /tmp/nutmeg-devstack-nvim.pipe
  tmux setenv -t nutmeg-devstack GIT_PARENT_BRANCH opencraft-release/nutmeg.2
  tmux setenv -t nutmeg-devstack OPENEDX_RELEASE nutmeg.master
  new_window
  run_cmd "activate"
  run_cmd "cd edx-platform"
  run_cmd "v"
  new_window
  run_cmd "activate"
  run_cmd "cd devstack"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
