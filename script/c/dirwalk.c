#include <dirent.h> 
#include <sys/types.h> 
#include <sys/param.h> 
#include <sys/stat.h> 
#include <unistd.h> 
#include <stdio.h> 
#include <string.h> 

int dirwalk(char *path)
{
	DIR           *d;
	struct dirent *dir;
	struct stat sb;
	char fullpath[MAXPATHLEN];
		
	int total = 0;

	if ((d = opendir(path)) == NULL) {
		return 0;
	}
	while ((dir = readdir(d))) {
		if (strcmp(dir->d_name, ".") == 0 || strcmp(dir->d_name, "..") == 0) {
			continue;
		}
		sprintf(fullpath, "%s/%s", path, dir->d_name);
		if (stat(fullpath,&sb) == -1) {
			continue;
		}
		if ((sb.st_mode & S_IFMT) == S_IFDIR) {
			total += dirwalk(fullpath);
		} 
		else {
			//printf("%s\n", fullpath);
			total++;
		}
	}
	closedir(d);
	return total;
}

int main(int argc, char *argv[]) 
{
	int total = 0;
	printf("C Traversing: %s\n", argv[1]);
	total = dirwalk(argv[1]);
	printf("C Total Files: %d\n", total);
}
/* https://github.com/jhuboo/Computing-Fundamentals/tree/master/C_book/exercisecs */
/* https://github.com/quchunguang/test */
/* https://github.com/yuchao919/Odyssey/tree/master/C */
