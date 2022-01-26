#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/inotify.h>

#define EVENT_SIZE  ( sizeof (struct inotify_event) )
#define BUF_LEN     ( 1024 * ( EVENT_SIZE + 16 ) )

int main( int argc, char **argv ) 
{
    int length = 0;
    int i = 0;
    int fd;
    int wd[1];
    char buffer[BUF_LEN];

    fd = inotify_init();

    if ( fd < 0 ) {
        perror( "inotify_init" );
    }

    wd[0] = inotify_add_watch( fd, "/tmp/inotify1", IN_CREATE);
    wd[1] = inotify_add_watch (fd, "/tmp/inotify2", IN_CREATE);

    if ( length < 0 ) {
        perror( "read" );
    }  

    while (1){
        length = read( fd, buffer, BUF_LEN );  
        struct inotify_event *event = ( struct inotify_event * ) &buffer[ i ];
        if ( event->len ) {
            if (event->wd == wd[0]) printf("%s\n", "In /tmp/inotify1: ");
            else printf("%s\n", "In /tmp/inotify2: ");
            if ( event->mask & IN_CREATE ) {
                if ( event->mask & IN_ISDIR ) {
                    printf( "The directory %s was created.\n", event->name );       
                }
                else {
                    printf( "The file %s was created.\n", event->name );
                }
            }
        }
    }
    ( void ) inotify_rm_watch( fd, wd[0] );
    ( void ) inotify_rm_watch( fd, wd[1]);
    ( void ) close( fd );

    exit( 0 );
}
/* gcc -Wall -g -o test inotify_example.c */
/* gdb -q test */
