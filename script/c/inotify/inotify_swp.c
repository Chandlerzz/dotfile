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
  char  *path;  /* file path */
  char  *lct;   /* last created time */
};
 
#define BUF_LEN 1000
#define NAME_LEN 1000
#define MAXLINE 500
int sortifiles(struct ifile *ifiles[],int count);

struct ifile *lalloc(void)
{
    return (struct ifile *)malloc(sizeof(struct ifile));
}

/*make path to correct path for example 
 * %home%chandler%test.swp -> /home/chandler/test*/
char * getFPath(char *path)
{
  int pathlen = strlen(path)-4;
  char *path1 = malloc(pathlen+1);
  memset(path1, '\0', pathlen+1);
  strncpy(path1, path, pathlen);
  for (int j=0;j<pathlen; j++)
  {
    if (path1[j] == 37) /* 37 is % */
    {
      path1[j] = 47; /* 48 is / */
    }
  }
  return path1;
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
}

int getcount(struct ifile *ifiles[], int count)
{
  for (int i=0;i<count;i++)
  {

    if(!ifiles[i])
    {
      return i;
    }
  }
  return -1;
}

struct ifile *createifile(char *path)
{
  struct ifile *ifil;
  ifil = (struct ifile *)lalloc();
  setifiletime(ifil);
  int pathlen = strlen(path);
  char *path1 = (char *)malloc(pathlen+1); 
  ifil->path = strcpy(path1,path);
  return ifil;
}
int isInIfiles(char *path, struct ifile *ifiles[],int count)
{
  int flag = 0;
  for (int i = 0; i < count; ++i) 
  {
    if(!strcmp(ifiles[i]->path,path))
    {
     flag = 1;
     break;
    } 
  }
  return flag;
}

int sortifiles(struct ifile *ifiles[],int count)
{
  count = count - 1;
  for (int i = count; i > 0; --i) {
    ifiles[i] = ifiles[i-1];
  }
  return 0;
}
void readsourcefile(struct ifile *ifiles[], char *filepath)
{
	char *p;
  FILE *fp;
  const char * split = "%";
  char arr[MAXLINE+1];
  memset(arr, '\0', MAXLINE+1);
  int count = 0;
  if ((fp = fopen (filepath, "r")) == NULL)
  {
     perror ("File open error!\n");
     exit (1);
  }

  while ((fgets (arr, MAXLINE, fp)) != NULL)
  {
      ifiles[count] = lalloc();
      p = strtok(arr,split);
      char *tmp1=malloc(strlen(p));
      ifiles[count]->path = strncpy(tmp1,p,strlen(p));
      p = strtok(NULL,split);
      char *tmp=malloc(strlen(p)-1);
      ifiles[count]->lct = strncpy(tmp,p,strlen(p)-1);
      count += 1;
  }
  fclose(fp);
  fp = NULL;
}

int main(int argc,char **argv)
{
  int count, flag = 0;
  char *filepath=malloc(strlen(getenv("HOME"))+strlen("/.lrc")+1);
  strcat(filepath,getenv("HOME"));
  strcat(filepath,"/.lrc");
	int inotifyFd,wd;
	char buf[BUF_LEN];
	ssize_t numRead;
	char *p;
  FILE *fp;
  char *path;
  char *fullpath;
  char *hideseek;
	struct inotify_event *event;
  struct ifile *ifiles[MAXLINE]={NULL};
  readsourcefile(ifiles,filepath);


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
      count = getcount(ifiles, MAXLINE);
			event = (struct inotify_event *)p;
      path = event->name;
      fullpath = getFPath(path);
      flag = isInIfiles(fullpath,ifiles,count);
      hideseek=strstr(fullpath,"hideseek");
      if(!hideseek)
      {
        if(!flag)
        {
          struct ifile *ifil =  createifile(fullpath);
          if (count == MAXLINE)
          {
            count =count-1;
            free(ifiles[count]);
          }else{
            count = count;
          }
          for (int i = count; i > 0; --i) {
           ifiles[i] = ifiles[i-1]; 
          }
          ifiles[0] = ifil;
        }else{
          for (int i = 0; i < count; ++i) 
          {
            if(!strcmp(ifiles[i]->path,fullpath))
            {
            struct ifile *tmp = ifiles[i]; 
            for (int j = i;  j > 0; --j) {
             ifiles[j] = ifiles[j-1]; 
            }
            ifiles[0] = tmp;
             break;
            } 
          }
        }
      }
      free(fullpath);  fullpath=NULL;
      p+=sizeof(struct inotify_event) + event->len;
		}

    if ((fp = fopen (filepath, "w+")) == NULL)
    {
       perror ("File open error!\n");
       exit (1);
    }
    for (int i = 0; i < MAXLINE; ++i) {
      char destination[100]={""};
      if(ifiles[i])
      {
        strcat(destination,ifiles[i]->path);
        strcat(destination,"%");
        strcat(destination,ifiles[i]->lct);
        strcat(destination,"\n");
        fputs(destination,fp);
        printf("comming %s %s \n",ifiles[i]->path,ifiles[i]->lct);
      }
    }
    fclose(fp);
    fp = NULL;
	}
	return 0;
}
