#!/bin/sh

ARCH=x86_64
PATH=./:$PATH

if [ -z $1 ]; then
    echo "Please run as ./phpstorm.build.sh PhpStorm-YYYY.Q.tar.gz"
    exit
fi

#https://github.com/AppImage/AppImageKit
if ! [ -x "$(command -v appimagetool-x86_64.AppImage)" ]; then
    echo "appimagetool is required tryin to download..."
    (wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage || curl -LO  https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage) || (echo "Please install curl or wget" && exit 1)
    chmod +x appimagetool-x86_64.AppImage
fi

echo "Extracting phpstorm from tar..."
tar axf $1

dir=$(find . -type d -name "PhpStorm-*")

echo "Prepearing phpstorm directory for build appimg..."

cd $dir

cat > ./phpstorm.desktop <<\EOF
[Desktop Entry]
Type=Application
Name=phpstorm
Icon=phpstorm
Exec=phpstorm.sh %u
Categories=Development;IDE;
StartupNotify=true
EOF

ln -s bin/phpstorm.sh AppRun
ln -s bin/phpstorm.png phpstorm.png

cd ..

echo "Building appimg..."
appimagetool-x86_64.AppImage -n $dir && rm -rf $dir $1
