#!/bin/sh
user=$(grep sshd /var/log/auth.log* -h | grep -F 'Accepted' | tail -2 | head -1 | awk '{for(i=1;i<=NF;i++)if($i=="for")print $(i+1)}') # get username from last login
ipaddr=$(grep sshd /var/log/auth.log* -h | grep -F 'Accepted' | tail -2 | head -1 | awk '{for(i=1;i<=NF;i++)if($i=="from")print $(i+1)}') # get ip address from last login
time=$(grep sshd /var/log/auth.log* -h | grep -F 'Accepted' | tail -2 | head -1 | awk '{for(i=NF;i>=1;i--)if($i=="darkrouter")print $(i-1)}') # get time from last login
date=$(grep sshd /var/log/auth.log* -h | grep -F 'Accepted' | tail -2 | head -1 | tr -s ' ' | cut -d" " -f1,2) # get date from last login

host=$(cat /sys/firmware/devicetree/base/model)
mem=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
kern=$(uname -rm)
os=$(grep PRETTY_NAME /etc/os-release | cut -d\" -f2)

printf "%b" "\033[0;36m" "
    ____             __                    __
   / __ \\____ ______/ /___________  __  __/ /____  _____\t\033[1;36mOS:\033[0m $os\033[0;36m
  / / / / __ \`/ ___/ //_/ ___/ __ \\/ / / / __/ _ \\/ ___/\t\033[1;36mHost:\033[0m $host\033[0;36m
 / /_/ / /_/ / /  / ,< / /  / /_/ / /_/ / /_/  __/ /\t\t\033[1;36mKernel:\033[0m $kern\033[0;36m
/_____/\\__,_/_/  /_/|_/_/   \\____/\\__,_/\\__/\\___/_/\t\t\033[1;36mMemory:\033[0m $mem\n
Welcome to Alpine!\nLast login: $date $time from $ipaddr with user $user\nHave lot of fun..\n"

# just so I do not forget..
: '
    Black \033[0;30m

    Red \033[0;31m

    Green \033[0;32m

    Yellow \033[0;33m

    Blue \033[0;34m

    Purple \033[0;35m

    Cyan \033[0;36m

    White \033[0;37m


   Normal 0

   Bold 1

  Underline 4
'
