# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/opencraft/listaflow/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "listaflow"; then

  # Create a new window inline within session layout definition.
  tmux setenv -t listaflow PYTHON_ENV_PATH /home/navin/work/python_shared_venvs/py38/
  tmux setenv -t listaflow NVIM_SERVER /tmp/listaflow-nvim.pipe
  tmux setenv -t listaflow GIT_PARENT_BRANCH master
  new_window
  run_cmd "activate"
  run_cmd "v"
  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
