#!/bin/bash
echo "↓.bashrcや.zshrcなど，フルパスで"
echo "shellのconfigファイル: "
read useshell
echo "alias pinenut=\""$(pwd)"/src/main.rb\"" > $usershell
