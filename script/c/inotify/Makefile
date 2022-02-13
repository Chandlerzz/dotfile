inoswp:
	gcc -Wall -g -o ~/bin/inoswp ~/dotfile/script/c/inotify/inotify_swp.c
debug:
	gcc -Wall -g -o ~/bin/inoswp ~/dotfile/script/c/inotify/inotify_swp.c
	gdb -q -args inoswp /tmp/swp
clean:
	rm ~/bin/inoswp
inoswp1:
	cc -std=c99 -D_XOPEN_SOURCE=600 -D_DEFAULT_SOURCE -g -I../lib -pedantic -Wall -W -Wmissing-prototypes -Wno-sign-compare -Wimplicit-fallthrough -Wno-unused-parameter   inotify_swp.c ../libtlpi.a  ../libtlpi.a -lrt -o inotify_swp
inoswp2:
	cc -std=c99 -D_XOPEN_SOURCE=600 -D_DEFAULT_SOURCE -g -I../lib -pedantic -Wall -W -Wmissing-prototypes -Wno-sign-compare -Wimplicit-fallthrough -Wno-unused-parameter   inotify_swp.c ../libtlpi.a  ../libtlpi.a -lrt -o ~/bin/inoswp
