#!/bin/bash

script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

echo ----Starting Doomsday pack----
source $script_path/tex-deng.sh

echo ----starting Risen3d pack----
source $script_path/tex-r3d.sh

echo ----starting zdoom pack----
source $script_path/tex-zd.sh
