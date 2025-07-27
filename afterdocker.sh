wget https://github.com/eternalwill43/mgeconfig/archive/refs/heads/master.zip
bsdtar -xf master.zip --strip-components=1
cd tf2-data/tf/
wget https://github.com/sapphonie/MGEMod/releases/download/v3.0.9/mge.zip
unzip -o mge.zip
wget https://github.com/ldesgoui/tf2-comp-fixes/releases/download/v1.16.19/tf2-comp-fixes.zip
unzip -o tf2-comp-fixes.zip
wget https://github.com/eldoradoel/sm-ripext-websocket/releases/download/2.4.0/sm-ripext--ubuntu-20.04.zip
unzip -o sm-ripext--ubutu-20.04.zip
cd addons
wget https://github.com/dalegaard/srctvplus/releases/download/v3.0/srctvplus.so
wget https://github.com/dalegaard/srctvplus/releases/download/v3.0/srctvplus.vdf
cd sourcemod
wget https://github.com/sapphonie/StAC-tf2/releases/download/v6.3.8a/stac.zip
unzip -o stac.zip
cd plugins
wget https://github.com/F2/F2s-sourcemod-plugins/releases/download/20250725-1753439198523/f2-sourcemod-plugins.zip
unzip -o f2-sourcemod-plugins.zip
cd ../scripting
wget https://github.com/f2/F2s-sourcemod-plugins/archive/refs/heads/master.zip
unzip master.zip "F2s-sourcemod-plugins-master/includes/*" -d temp
rsync -a temp/F2s-sourcemod-plugins-master/includes/ ./include/
rm -rf temp
chmod +x ./mkmge.sh
./mkmge.sh