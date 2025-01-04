#!/usr/bin/env bash

cmd=$@
current_dir=${PWD##*/}
echo $current_dir

if [[ $current_dir = "edx-platform" ]]; then
	cd ~/work/opencraft/tutor-env/
	mise x -C ~/work/opencraft/tutor-env/ -- tutor dev exec cms bash -c "unset DJANGO_SETTINGS_MODULE; unset SERVICE_VARIANT; export EDXAPP_TEST_MONGO_HOST=mongodb; $cmd"
else
	$cmd
fi
