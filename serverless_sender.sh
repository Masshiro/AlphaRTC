#!/bin/bash

target_dir="target"
target_lib_dir="${target_dir}/lib"
target_bin_dir="${target_dir}/bin"
target_pylib_dir="${target_dir}/pylib"


export LD_LIBRARY_PATH="${target_lib_dir}:$LD_LIBRARY_PATH"
export PYTHONPATH="${target_pylib_dir}:$PYTHONPATH"
export PATH="target/lib:$PATH"
export PATH="target/bin:$PATH"

executable="$target_bin_dir/peerconnection_serverless"
config_file="$target_bin_dir/sender_pyinfer.json"

# 检查可执行文件是否存在
if [[ ! -f "$executable" ]]; then
    echo "Error: Executable file '$executable' not found."
    exit 1
fi

# 检查配置文件是否存在
if [[ ! -f "$config_file" ]]; then
    echo "Error: Configuration file '$config_file' not found."
    exit 1
fi

# 执行命令
echo "Executing: $executable $config_file"
"$executable" "$config_file"