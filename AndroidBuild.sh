#!/bin/sh

LOCAL_PATH=`dirname $0`
LOCAL_PATH=`cd $LOCAL_PATH && pwd`

ln -sf libsdl_mixer.so $LOCAL_PATH/../../../obj/local/$1/libSDL_mixer.so
ln -sf libgl4es.a $LOCAL_PATH/../../../obj/local/$1/libGL.a
ln -sf libglu.a $LOCAL_PATH/../../../obj/local/$1/libGLU.a

[ -d hheretic-0.2.3-src ] || { curl "http://netix.dl.sourceforge.net/project/hhexen/hheretic/0.2.3/hheretic-0.2.3-src.tgz" | tar zxv && patch -p0 < hheretic-0.2.3-android.diff || exit 1 ; }

cd hheretic-0.2.3-src
if [ \! -f Makefile ] ; then
	../../setEnvironment.sh ./configure --host=arm-linux-androideabi --without-x
fi
rm -f ../libapplication.so
make -j4 CPPFLAGS="-include SDL_main.h -Iinclude -I."
mv -f hheretic-gl ../libapplication.so
