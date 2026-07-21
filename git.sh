#!/bin/bash

###
 # @Author: LHB
 # @Date: 2026-03-13 16:31:43
 # @LastEditTime: 2026-03-24 14:21:43
 # @LastEditors: LHB
 # @Description:
 # @FilePath: /hub-web/git.sh
 # ---
###
git add .
echo "请输入commit-msg：..."
read msg
# git commit -m "feat: $msg" --no-verify
git commit -m "feat: $msg"
git push

# 提交时只需要执行 bash git.sh '参数内容'即可完成提交操作
