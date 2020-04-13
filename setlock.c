#include "lock.h"
#include "open.h"
#include "strerr.h"
#include "exit.h"
#include "sgetopt.h"

#define FATAL "setlock: fatal: "

void usage() {
  strerr_die1x(100,"setlock: usage: setlock [ -nNxX ] file program [ arg ... ]");
}

int flagndelay = 0;
int flagx = 0;

void main(argc,argv)
int argc;
char **argv;
{
  int opt;
  int fd;
  char *file;

  while ((opt = getopt(argc,argv,"nNxX")) != opteof)
    switch(opt) {
      case 'n': flagndelay = 1; break;
      case 'N': flagndelay = 0; break;
      case 'x': flagx = 1; break;
      case 'X': flagx = 0; break;
      default: usage();
    }

  argv += optind;
  if (!*argv) usage();
  file = *argv++;
  if (!*argv) usage();

  fd = open_append(file);
  if (fd == -1) {
    if (flagx) _exit(0);
    strerr_die4sys(111,FATAL,"unable to open ",file,": ");
  }

  if ((flagndelay ? lock_exnb : lock_ex)(fd) == -1) {
    if (flagx) _exit(0);
    strerr_die4sys(111,FATAL,"unable to lock ",file,": ");
  }

  execvp(*argv,argv);
  strerr_die4sys(111,FATAL,"unable to run ",*argv,": ");
}
