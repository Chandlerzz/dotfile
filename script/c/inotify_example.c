/* gcc -Wall -g -o test inotify_example.c */
/*gdb -q test */
/* TODO */
/* transform file format */
/* to create file to store the info */
/* the file store 500 lines */
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
 
struct ifile {
  char  *name;  /* file name */
  int   count;    /* file create count */
  int   line;     /* file position line */
  char  lct[0];   /* last created time */
};
 
#define BUF_LEN 1000
#define NAME_LEN 1000


void displayInotifyEvent(struct inotify_event *i)
{
  struct ifile *ptr;
  ptr = (struct ifile*) malloc(1 * sizeof(struct ifile));
  char name[NAME_LEN];
  char *p = i->name;
  ptr->name = p;
  printf("start");
  strcpy(name,p);
  printf("%s\n",p);
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
 
	wd = inotify_add_watch(inotifyFd,argv[1],IN_CREATE);
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
