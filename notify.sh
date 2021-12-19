#!/bin/bash

# 間隔の指定 [s]
span=300

# Global IP ファイルパス
path="./globalip.txt"

# Discord token ファイルパス
url=$(cat ./token.txt)

# notifyer
notify(){
  curl -H "Content-Type: application/json" -X POST -d '{"username": "minecraftBot", "content":"'"$1"'"}' "$2"
}

# 一定間隔で実行
while true; do
  # get global ip
  ipnow=$(curl inet-ip.info)

  # check global ip
  exec < $path
  while read line; do
    if [ $line = $ipnow ] ; then
      message="IP does not changed : $line"
      #notify "$message" "$url"
    else
      message="IP changed : $ipnow"
      notify "$message" "$url"
      echo $ipnow > globalip.txt
    fi
  done

  # 一定時間待機
  sleep $span
done
