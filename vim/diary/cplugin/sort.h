typedef struct line{
    int     id;
    char    *content;
    char    *msg;
} LINE;
extern char* substring(char* ch,int pos,int length); 
extern LINE *lalloc(void);
extern void insertSort(LINE * lines[], int count);
