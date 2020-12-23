#!/bin/sh
IME_URL=http://ys-c.ys168.com/244626543/11583974/hws5kji3M381G7J4JO5f3/yong-lin-2.5.0-0.7z
TARBALL=$(basename $IME_URL)
[ ! -e $TARBALL ] && wget -P . $IME_URL
[ ! -e yong ] && 7z x $TARBALL
mkdir -p yongPKG/usr/local/bin
mkdir -p yongPKG/usr/local/share/yong

for i in mb skin l64; do
	cp -a yong/$i yongPKG/usr/local/share/yong/
done

for i in bihua.bin normal.txt README.txt yong.ini keyboard.ini;do
	cp -a yong/$i yongPKG/usr/local/share/yong/
done
cd yongPKG
ln -sf ../share/yong/l64/yong-gtk3 usr/local/bin/yong
ln -sf ../share/yong/l64/yong-config-gtk3 usr/local/bin/yong-config
install -D ../yong/l64/gtk-im/im-yong-gtk2.so usr/local/lib/gtk-2.0/2.10.0/immodules/im-yong.so
install -D ../yong/l64/gtk-im/im-yong-gtk3.so usr/local/lib/gtk-3.0/3.0.0/immodules/im-yong.so
mkdir -p usr/local/tce.installed
cat << EOF > usr/local/tce.installed/yong
gtk-query-immodules-3.0 --update-cache
gtk-query-immodules-2.0 --update-cache
EOF
chmod +x usr/local/tce.installed/yong
# modify config file
sed -i -e 's/default=0/default=4/' \
       -e "s/select=LSHIFT RSHIFT/select=; '/" \
       -e "s/CNen=LCTRL/CNen=LSHIFT/"   \
       -e "s/page=- =/page=, ./"   \
       -e "/keypad=0/a\ABCD=1"   \
usr/local/share/yong/yong.ini

cat ../yong/entry/cloud.ini >> usr/local/share/yong/yong.ini
sed -i -e 's/4=gbk/4=pinyin/' \
       -e 's/5=pinyin/5=cloud/' \
usr/local/share/yong/yong.ini

# modify end

# change default skin
png="iVBORw0KGgoAAAANSUhEUgAAAB4AAAATCAIAAAAIzCorAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sFCwYzDrySergAAAAhSURBVDjLY/z8+TMDbQATA83AqNGjRo8aPWr0qNEj3mgAvhgC/8aR0LcAAAAASUVORK5CYII="
echo $png | base64 -d  > usr/local/share/yong/skin/name1.png
for name in skin skin0 skin1 skin2; do
  sed -i -e 's/s2t=84,3/name=90,6/' \
         -e 's/s2t_s=jian1.png/name_img=name1.png/' \
         -e 's/s2t_t=fan1.png/name_font=Bold 18/' \
         -e 's/keyboard=108,3/name_color=#3975ce/' \
         -e '/keyboard_img/d' usr/local/share/yong/skin/${name}.ini
done
# modify end
cd ..
mksquashfs yongPKG yong.tcz
