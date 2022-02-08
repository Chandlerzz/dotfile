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
#include <sys/wait.h>
#include "tlpi_hdr.h"
 
struct ifile {
  char *path;  /* file path */
  char *lct;   /* last created time */
};
 
#define BUF_LEN  1000
#define NAME_LEN 1000
#define MAXLINE  500

#define MOVEBACK(i, count) \
do{\
  for(int i = count; i > 0; --i) { \
       ifiles[i] = ifiles[i-1]; \
   }\
}while(0)
          

int sortifiles(struct ifile *ifiles[],int count);
char* substring(char* ch,int pos,int length); 
struct ifile *lalloc(void);
char * getFPath(char *path);
void getCurrentTime(char *buffer);
void setifiletime(struct ifile *ifil);
int getcount(struct ifile *ifiles[], int count);
int isInIfiles(char *path, struct ifile *ifiles[],int count);
void readsourcefile(struct ifile *ifiles[], char *filepath);
struct ifile *createifile(char *path);

char* substring(char* ch,int pos,int length)  
{  
    //定义字符指针 指向传递进来的ch地址
    char* pch=ch;  
    //通过calloc来分配一个length长度的字符数组，返回的是字符指针。
    char* subch=(char*)calloc(sizeof(char),length+1);  
    int i;  
 //只有在C99下for循环中才可以声明变量，这里写在外面，提高兼容性。  
    pch=pch+pos;  
//是pch指针指向pos位置。  
    for(i=0;i<length;i++)  
    {  
        subch[i]=*(pch++);  
//循环遍历赋值数组。  
    }  
    subch[length]='\0';//加上字符串结束符。  
    return subch;       //返回分配的字符数组地址。  
} 

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
  MOVEBACK(i, count);
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
  FILE *fp;
	char *p;
  char *path;
  char *fullpath;
  char *hideseek;
  char *swp;
	struct inotify_event *event;
  struct ifile *ifiles[MAXLINE]={NULL};
  readsourcefile(ifiles,filepath);

  /* for child process */
  /* pid_t childPid; */
  /* int status; */


	if(argc < 2 )
	{
		printf("error\n");
	}


  /* childPid = fork(); */
  /* if (childPid == -1) */
  /*     errExit("fork"); */

  /* if (childPid == 0)              /1* Child calls func() and *1/ */
  /*   printf("I am child"); */
  /*     exit(1);            /1* uses return value as exit status *1/ */

  /* Parent waits for child to terminate. It can determine the
     result of func() by inspecting 'status' */

  /* if (wait(&status) == -1) */
  /*     errExit("wait"); */
 
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
      swp = substring(path,strlen(path)-3,3);
      if(0==strcmp(substring(path,strlen(path)-3,3),"swp"))
      {
        fullpath = getFPath(path);
        flag = isInIfiles(fullpath,ifiles,count);
        /* get the end 8 character of fullpath. if it is "hideseek" ignore it*/ 
        hideseek = substring(fullpath,strlen(fullpath)-8,8);
        if(0==strcmp(hideseek,"hideseek"))
        {
          p+=sizeof(struct inotify_event) + event->len;
          continue;
        }
        if(strstr(fullpath,"NERD_tree"))
        {
          p+=sizeof(struct inotify_event) + event->len;
          continue;
        }
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
          MOVEBACK(i,count);
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
        free(hideseek); hideseek=NULL;
        free(fullpath); fullpath=NULL;
        free(swp);      swp=NULL;
      p+=sizeof(struct inotify_event) + event->len;
		}

    if ((fp = fopen (filepath, "w+")) == NULL)
    {
       perror ("File open error!\n");
       exit (1);
    }
    for (int i = 0; i < MAXLINE; ++i) {
      char destination[200]={""};
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
