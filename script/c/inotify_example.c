/* #include <stdio.h> */
/* #include <stdlib.h> */
/* #include <unistd.h> */
/* #include <errno.h> */
/* #include <sys/types.h> */
/* #include <sys/inotify.h> */

/* #define EVENT_SIZE  ( sizeof (struct inotify_event) ) */
/* #define BUF_LEN     ( 1024 * ( EVENT_SIZE + 16 ) ) */

/* int main( int argc, char **argv ) */ 
/* { */
/*     int length = 0; */
/*     int i = 0; */
/*     int fd; */
/*     int wd[1]; */
/*     char buffer[BUF_LEN]; */

/*     fd = inotify_init(); */

/*     if ( fd < 0 ) { */
/*         perror( "inotify_init" ); */
/*     } */

/*     wd[0] = inotify_add_watch( fd, "/tmp/inotify1", IN_CREATE); */
/*     wd[1] = inotify_add_watch (fd, "/tmp/inotify2", IN_CREATE); */

/*     if ( length < 0 ) { */
/*         perror( "read" ); */
/*     } */  

/*     while (1){ */
/*         length = read( fd, buffer, BUF_LEN ); */  
/*         struct inotify_event *event = ( struct inotify_event * ) &buffer[ i ]; */
/*         if ( event->len ) { */
/*             if (event->wd == wd[0]) printf("%s\n", "In /tmp/inotify1: "); */
/*             else printf("%s\n", "In /tmp/inotify2: "); */
/*             if ( event->mask & IN_CREATE ) { */
/*                 if ( event->mask & IN_ISDIR ) { */
/*                     printf( "The directory %s was created.\n", event->name ); */       
/*                 } */
/*                 else { */
/*                     printf( "The file %s was created.\n", event->name ); */
/*                 } */
/*             } */
/*         } */
/*     } */
/*     ( void ) inotify_rm_watch( fd, wd[0] ); */
/*     ( void ) inotify_rm_watch( fd, wd[1]); */
/*     ( void ) close( fd ); */

/*     exit( 0 ); */
/* } */
/* gcc -Wall -g -o test inotify_example.c */
/*gdb -q test */
#include<stdio.h>
#include<assert.h>
#include<unistd.h>
#include<stdlib.h>
#include<errno.h>
#include<string.h>
#include<sys/types.h>
#include<sys/inotify.h>
#include<limits.h>
#include<fcntl.h>
 
 
#define BUF_LEN 1000
 
void displayInotifyEvent(struct inotify_event *i)
{
	printf("  wd = %2d; ",i->wd);
 
	if(i->cookie > 0)
	{
		printf("cokkie = %4d; ",i->cookie);
	}
 
	printf("mask = ");
 
	if(i->mask & IN_ACCESS)   printf("IN_ACCESS\n");
	if(i->mask & IN_DELETE_SELF)   printf("IN_DELETE_SELF\n");
	if(i->mask & IN_MODIFY)  printf("IN_MODIFY\n");
	if(i->mask & IN_OPEN)   printf("IN_OPEN\n");
 
	
		/* if(len > 0) */
		/* { */
		/* 	printf("name = %s\n",i->name); */
		/* } */
	
 
}
 
int main(int argc,char **argv)
{
	int inotifyFd,wd,j;
	char buf[BUF_LEN];
	ssize_t numRead;
	char *p;
	struct inotify_event *event;
	int flags;
 
 
 
	if(argc < 2 )
	{
		printf("error\n");
	}
 
	inotifyFd = inotify_init();
	if(inotifyFd == -1)
	{
		printf("初始化失败");
	}
 
	wd = inotify_add_watch(inotifyFd,argv[1],IN_ALL_EVENTS);
	if(wd == -1)
	{
		printf("error\n");
	}
 
	printf("Watching %s using wd %d\n",argv[1],wd);
 
	
 
	while(1)
	{
		numRead = read(inotifyFd,buf,BUF_LEN);
		if(numRead == -1)
		{
			printf("read error\n");
		}
 
		printf("Read %ldbytes from inotify fd\n",(long)numRead);
		for(p=buf;p < buf+numRead;)
		{
			event = (struct inotify_event *)p;
			displayInotifyEvent(event);
			p+=sizeof(struct inotify_event) + event->len;
		}
	}
 
	return 0;
 
}
