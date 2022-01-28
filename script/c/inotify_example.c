/* command */ 
/* gcc -Wall -g -o test inotify_example.c  && gdb -q -args /tmp/swp ` */
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
#include <time.h>
 
struct ifile {
  int   id;
  char  *name;  /* file name */
  int   count;    /* file create count */
  int   tstamp;     /* timestamp */
  char  *lct;   /* last created time */
};
 
#define BUF_LEN 1000
#define NAME_LEN 1000
#define MAXLINE 500

struct ifile *lalloc(void)
{
    return (struct ifile *)malloc(sizeof(struct ifile));
}

/*make path to correct path for example 
 * %home%chandler%test.swp -> /home/chandler/test*/
void getFPath(char *path1, char *path, int size)
{
  strncpy(path1, path, size);
  for (int j=0;j<size; j++)
  {
    if (path1[j] == 37) /* 37 is % */
    {
      path1[j] = 48; /* 48 is / */
    }
  }
}

/*getCurrentTime*/
void getCurrentTime(char *buffer)
{
  time_t rawtime;
  struct tm *info;
  time( &rawtime );
  info = localtime( &rawtime );
  strftime(buffer, 80, "%Y-%m-%d %H:%M:%S", info);
}

void setifiletime(struct ifile *ifil)
{
  char *localtime = (char *)malloc(20);
  getCurrentTime(localtime);
  ifil->lct = localtime;
  ifil->tstamp = time(NULL);
}

void createifile(struct inotify_event *i_event, struct ifile *ifil)
{
  char *path = i_event->name;
  char *substr = strstr(path,".hideseek");
  int pathlen, path1len;
  pathlen = strlen(path);
  path1len = pathlen -4;
  char path1[path1len+1];
  memset(path1, '\0', sizeof(path1));
  if(!substr)
  {
    printf("I am not hideseek");
    getFPath(path1,path,path1len);
    setifiletime(ifil);
    printf("%s\n",path1);
  }
}

void updateifile(struct ifile *ifil)
{
  int count = ifil->count;
  count += 1;
  ifil->count = count;
  setifiletime(ifil);
}

void clearifile(struct ifile * ifil)
{
}
 
int main(int argc,char **argv)
{
	int inotifyFd,wd;
	char buf[BUF_LEN];
	ssize_t numRead;
	char *p;
	struct inotify_event *event;
  struct ifile *ifil;
  ifil = (struct ifile *)lalloc();
  /* struct ifile *ifiles[MAXLINE]; */
 
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
			createifile(event, ifil);
			p+=sizeof(struct inotify_event) + event->len;
		}
	}
	return 0;
}
