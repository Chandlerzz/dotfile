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
#include<limits.h>
#include <time.h>
#include <sys/wait.h>
#include <signal.h>
#include <mqueue.h>
#include <fcntl.h>              /* For definition of O_NONBLOCK */
#include <sys/mman.h>
#include<sys/types.h>
#include<sys/inotify.h>
#include "tlpi_hdr.h"

struct ifile {
  char *path;  /* file path */
  char *lct;   /* last created time */
};
 
#define BUF_LEN  1000
#define NAME_LEN 1000
#define MAXLINE  500
#define NOTIFY_SIG SIGUSR1
#define SIZE     500
#define NAME     "/shmtest"

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
void readshm(long shm);
void writeshm(int line);


void writeshm(int line){
  char shm[SIZE];
  memset(shm, '\0', SIZE);
  int shm_fd;
  char *addr;
  shm_fd=shm_open(NAME,O_CREAT|O_EXCL|O_RDWR,0666);
  if (shm_fd == -1)
  {
    if (errno == EEXIST)
    {
      shm_fd=shm_open(NAME, O_RDWR, 0666);
    }else{
      exit(EXIT_FAILURE);
    }
  }
  ftruncate(shm_fd,SIZE);
  if (ftruncate(shm_fd, SIZE) == -1)           /* Resize object to hold string */
      errExit("ftruncate");
  printf("Resized to %ld bytes\n", (long) SIZE);
  addr = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
  if (addr == MAP_FAILED)
      errExit("mmap");

  if (close(shm_fd) == -1)                    /* 'fd' is no longer needed */
      errExit("close");

  printf("copying %ld bytes\n", (long) SIZE);
  shm[line] = 100;
  memcpy(addr, shm, SIZE);             /* Copy string to shared memory */
}

void readshm(long shm)
{
  int shm_fd;
  char *addr;
  shm_fd=shm_open(NAME,O_CREAT|O_EXCL|O_RDWR,0666);
  if (shm_fd == -1)
  {
    if (errno == EEXIST)
    {
      shm_fd=shm_open(NAME, O_RDWR, 0666);
    }else{
      exit(EXIT_FAILURE);
    }
  }
  ftruncate(shm_fd,SIZE);
  if (ftruncate(shm_fd, SIZE) == -1)           /* Resize object to hold string */
      errExit("ftruncate");
  printf("Resized to %ld bytes\n", (long) SIZE);
  addr = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
  if (addr == MAP_FAILED)
      errExit("mmap");

  if (close(shm_fd) == -1)                    /* 'fd' is no longer needed */
      errExit("close");

  
  printf("copying %ld bytes\n", (long) SIZE);
  memcpy( shm, addr, SIZE);             /* Copy string to shared memory */
}
static void handler(int sig)
{
    /* Just interrupt sigsuspend() */
}

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
  long shm[SIZE]={0};
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
    struct sigevent sev;
    mqd_t mqd;
    struct mq_attr attr;
    void *buffer;
    sigset_t blockMask, emptyMask;
    struct sigaction sa;


	if(argc < 2 )
	{
		printf("error\n");
	}


  switch (fork()) {
  case -1:
    errExit("fork");

  case 0:     /* Child: change file offset and status flags */
      printf("%s args[2]",argv[2]);
      mqd = mq_open(argv[2], O_RDONLY | O_NONBLOCK);
      if (mqd == (mqd_t) -1)
          errExit("mq_open");

    /* Determine mq_msgsize for message queue, and allocate an input buffer
       of that size */

    if (mq_getattr(mqd, &attr) == -1)
        errExit("mq_getattr");

    buffer = malloc(attr.mq_msgsize);
    if (buffer == NULL)
        errExit("malloc");

    /* Block the notification signal and establish a handler for it */

    sigemptyset(&blockMask);
    sigaddset(&blockMask, NOTIFY_SIG);
    if (sigprocmask(SIG_BLOCK, &blockMask, NULL) == -1)
        errExit("sigprocmask");

    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    sa.sa_handler = handler;
    if (sigaction(NOTIFY_SIG, &sa, NULL) == -1)
        errExit("sigaction");

    /* Register for message notification via a signal */

    sev.sigev_notify = SIGEV_SIGNAL;
    sev.sigev_signo = NOTIFY_SIG;
    if (mq_notify(mqd, &sev) == -1)
        errExit("mq_notify");

    sigemptyset(&emptyMask);

    for (;;) {
        sigsuspend(&emptyMask);         /* Wait for notification signal */

        /* Reregister for message notification */

        if (mq_notify(mqd, &sev) == -1)
            errExit("mq_notify");

        while ((numRead = mq_receive(mqd, buffer, attr.mq_msgsize, NULL)) >= 0)
        {
          /* printf("Read %ld bytes\n", (long) numRead); */
          int line = atoi(buffer);
          printf("line %d\n",line);
          writeshm(line);
          /*FIXME: above: should use %zd here, and remove (long) cast */
        }

        if (errno != EAGAIN)            /* Unexpected error */
            errExit("mq_receive");
    }


  default:    /* Parent: can see file changes made by child */
    /* TODO  here need read shm*/
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
        readshm(shm);
        for (int i = 0; i < SIZE; ++i) {
         printf("%ld\n",shm[i]);
        }
        shm_unlink(NAME);
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
   
}
