  #include <stdio.h>
    #include <stdlib.h>
    #include <fcntl.h>
    #include <sys/stat.h>
    #include <sys/ioctl.h>
    #include <string.h>
    #include <unistd.h>
    
    void print_help(char *prog_name) {
            printf("Usage: %s [-n] DEVNAME COMMAND\n", prog_name);
            printf("Usage: '-n' is an optional argument if you want to push a new line at the end of the text\n");
            printf("Usage: Will require 'sudo' to run if the executable is not setuid root\n");
            exit(1);
    }
    
    int main (int argc, char *argv[]) {
        char *cmd, *nl = "\n";
        int i, fd;
        int devno, commandno, newline;
        int mem_len;
        devno = 1; commandno = 2; newline = 0;
        if (argc < 3) {
            print_help(argv[0]);
        }
        if (argc > 3 && argv[1][0] == '-' && argv[1][1] == 'n') {
            devno = 2; commandno = 3; newline=1;
        } else if (argc > 3 && argv[1][0] == '-' && argv[1][1] != 'n') {
            printf("Invalid Option\n");
            print_help(argv[0]);
        }
        fd = open(argv[devno],O_RDWR);
        if(fd == -1) {
            perror("open DEVICE");
            exit(1);
        }
        mem_len = 0;
        for ( i = commandno; i < argc; i++ ) {
            mem_len += strlen(argv[i]) + 2;
            if ( i > commandno ) {
                cmd = (char *)realloc((void *)cmd, mem_len);
            } else { //i == commandno
                cmd = (char *)malloc(mem_len);
            }
    
            strcat(cmd, argv[i]);
            strcat(cmd, " ");
        }
      if (newline == 0)
            usleep(225000);
        for (i = 0; cmd[i]; i++)
            ioctl (fd, TIOCSTI, cmd+i);
        if (newline == 1)
            ioctl (fd, TIOCSTI, nl);
        close(fd);
        free((void *)cmd);
        exit (0);
    }
/* Copy the above code to some C file (For eg. ttyecho.c). Run the following command in the directory you have created the C file in to compile the code. */

/*     make ttyecho */

/* Copy this file to the bin directory under your Home Directory. Create the directory if it doesn’t exist. Its a good practice to keep all custom binaries/executables in this bin directory. */

/* Start another terminal or switch to any other open terminal that you wish to control and execute the command tty. You can see a sample output below. */

/*     @~$ tty */
/*     /dev/pts/5 */

/* Now to execute a command on /dev/pts/5, run the following command in the controlling/original terminal. */

/*     sudo ttyecho -n /dev/pts/5 ls */

/* You will see that the ls command is executed in /dev/pts/5. The -n option makes ttyecho send a newline after the command, so that the command gets executed and not just inserted. This utility can infact be used to send any data to other terminals For eg, you could open vim in `/dev/pts/5` and then run the following command in the controlling terminal to cause vim to exit in `/dev/pts/5`. */

/*     sudo ttyecho -n /dev/pts/5 :q */

/* To avoid using sudo all the time, so that the command is easily scriptable, change the owners/permissions of this executable using the following commands. */

/* == NB:Setting the setuid bit can become a security risk. */

/*     sudo chown root:root ttyecho */
/*     sudo chmod u+s ttyecho */
