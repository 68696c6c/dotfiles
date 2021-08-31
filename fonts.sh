git clone https://github.com/powerline/fonts.git --depth=1
cd fonts || exit
./install.sh DroidSansMono
cp DroidSansMono/"Droid Sans Mono for Powerline.otf" /Library/Fonts/"Droid Sans Mono for Powerline.otf"
cd ..
rm -rf fonts
