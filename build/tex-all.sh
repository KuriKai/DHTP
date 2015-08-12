#!/bin/bash

script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")
mkdir $base_path/built

echo ----Starting Doomsday pack----
cd "$(echo $script_path)"
source $script_path/tex-deng.sh

echo ----starting Risen3d pack----
cd "$(echo $script_path)"
source $script_path/tex-r3d.sh

echo ----starting zdoom pack----
cd "$(echo $script_path)"
source $script_path/tex-zd.sh
