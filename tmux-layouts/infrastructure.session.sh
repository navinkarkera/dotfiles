# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/opencraft/infrastructure/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "infrastructure"; then

  # Create a new window inline within session layout definition.
  tmux setenv -t infrastructure PYTHON_ENV_PATH /home/navin/work/python_shared_venvs/py310/
  tmux setenv -t infrastructure NVIM_SERVER /tmp/infrastructure-nvim.pipe
  tmux setenv -t infrastructure GIT_PARENT_BRANCH main
  new_window
  run_cmd "activate"
  run_cmd "v"
  new_window
  run_cmd "activate"
  run_cmd "cd environments/staging"
  run_cmd "echo STAGING ENV"
  run_cmd 'vault login -method="github" -address="https://vault.staging.do.opencraft.com"'
  new_window
  run_cmd "activate"
  run_cmd "cd environments/production"
  run_cmd "echo PRODUCTION ENV, PROCEED WITH CAUTION!!!"
  run_cmd 'vault login -method="github" -address="https://vault.opencraft.com"'
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
