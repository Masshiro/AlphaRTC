#!/bin/bash

# 定义变量
output_dir="out/Default"
target_dir="target"
target_lib_dir="${target_dir}/lib"
target_bin_dir="${target_dir}/bin"
target_pylib_dir="${target_dir}/pylib"


# 检查并删除现有的 out/Default 和 target 目录
if [ -d "${output_dir}" ]; then
    echo "=> Directory ${output_dir} exists. Deleting..."
    rm -rf "${output_dir}"
fi

if [ -d "${target_dir}" ]; then
    echo "=> Directory ${target_dir} exists. Deleting..."
    rm -rf "${target_dir}"
fi

# 构建 peerconnection_serverless 可执行文件
echo "=> Building peerconnection_serverless using ninja..."
gn gen "${output_dir}"
ninja -C "${output_dir}" peerconnection_serverless

# 创建目标目录
echo "=> Creating target directories..."
mkdir -p "${target_lib_dir}"
mkdir -p "${target_bin_dir}"
mkdir -p "${target_pylib_dir}"

# 复制共享库文件到目标目录
echo "=> Copying files and shared libraries..."
cp -r examples/peerconnection/serverless/corpus/* "${target_bin_dir}"
cp modules/third_party/onnxinfer/lib/*.so "${target_lib_dir}"
cp modules/third_party/onnxinfer/lib/*.so.* "${target_lib_dir}"

# 更新 LD_LIBRARY_PATH 环境变量
cp -r examples/peerconnection/serverless/corpus/* "${target_bin_dir}"

# 复制可执行文件和 python 脚本
echo "=> Copying executables and Python scripts..."
cp "${output_dir}/peerconnection_serverless" "${target_bin_dir}/peerconnection_serverless.origin"
cp examples/peerconnection/serverless/peerconnection_serverless "${target_bin_dir}"

# 复制 Python 库文件
cp modules/third_party/cmdinfer/*.py "${target_pylib_dir}/"

echo "=> Build and file copy process completed."


# 如果选项是 -path，执行这个命令
# path_command() {
#     cp -r examples/peerconnection/serverless/corpus/* "${target_bin_dir}"
#     echo "=> Updating PATH..."
#     export LD_LIBRARY_PATH="${target_lib_dir}:$LD_LIBRARY_PATH"
#     export PYTHONPATH="${target_pylib_dir}:$PYTHONPATH"
#     export PATH="target/lib:$PATH"
#     export PATH="target/bin:$PATH"
# }