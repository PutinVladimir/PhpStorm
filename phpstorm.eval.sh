#!/bin/sh

if [ -z $1 ]; then
    find ~ -maxdepth 1 -type d -name ".PhpStorm*" -printf '%f\n'
    echo "Please run as ./\e[32mphpstorm.eval.sh\e[0m \e[1;37m.\e[0mPhpStorm\e[1;37mYYYY\e[0m.\e[1;37mV\e[0m"
    exit
fi

NAME=${1#*.}

arg_split=${1#*PhpStorm}
YEAR=${arg_split%%.*}
VERSION=${arg_split#*.}

echo "Reseting evaluation $NAME period..."

rm -rf ~/$1/config/eval
sed -i '/evlsprt/d' ~/$1/config/options/options.xml
sed -i '/evlsprt/d' ~/$1/config/options/other.xml

# If not another java app in use just simple purge full .java dir or else partly clean
rm -rf ~/.java/.userPrefs/jetbrains
rm -rf ~/.java/.userPrefs/jetbrains/phpstorm
rm -rf ~/.java/.userPrefs/prefs.xml
#rm -rf ~/.java

# Optional
#rm -rf ~/.local/share/JetBrains

echo "\e[1;32mPhpStorm $YEAR.$VERSION was reset\e[0m"
