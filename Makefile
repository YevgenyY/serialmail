# Don't edit Makefile! Use conf-* for configuration.

SHELL=/bin/sh

default: it

alloc.0: \
alloc.3
	nroff -man alloc.3 > alloc.0

alloc.a: \
makelib alloc.o alloc_re.o
	./makelib alloc.a alloc.o alloc_re.o

alloc.o: \
compile alloc.c alloc.h error.h
	./compile alloc.c

alloc_re.o: \
compile alloc_re.c alloc.h byte.h
	./compile alloc_re.c

auto-str: \
load auto-str.o substdio.a error.a str.a
	./load auto-str substdio.a error.a str.a 

auto-str.o: \
compile auto-str.c substdio.h readwrite.h exit.h
	./compile auto-str.c

auto_home.c: \
auto-str conf-home
	./auto-str auto_home `head -1 conf-home` > auto_home.c

auto_home.o: \
compile auto_home.c
	./compile auto_home.c

auto_qmail.c: \
auto-str conf-qmail
	./auto-str auto_qmail `head -1 conf-qmail` > auto_qmail.c

auto_qmail.o: \
compile auto_qmail.c
	./compile auto_qmail.c

byte_chr.o: \
compile byte_chr.c byte.h
	./compile byte_chr.c

byte_copy.o: \
compile byte_copy.c byte.h
	./compile byte_copy.c

byte_cr.o: \
compile byte_cr.c byte.h
	./compile byte_cr.c

byte_diff.o: \
compile byte_diff.c byte.h
	./compile byte_diff.c

caldate.0: \
caldate.3
	nroff -man caldate.3 > caldate.0

caldate_fmjd.o: \
compile caldate_fmjd.c caldate.h
	./compile caldate_fmjd.c

caldate_mjd.0: \
caldate_mjd.3
	nroff -man caldate_mjd.3 > caldate_mjd.0

caltime.0: \
caltime.3
	nroff -man caltime.3 > caltime.0

caltime_tai.0: \
caltime_tai.3
	nroff -man caltime_tai.3 > caltime_tai.0

caltime_utc.o: \
compile caltime_utc.c tai.h uint64.h leapsecs.h caldate.h caltime.h \
caldate.h
	./compile caltime_utc.c

case.0: \
case.3
	nroff -man case.3 > case.0

case.a: \
makelib case_diffb.o
	./makelib case.a case_diffb.o

case_diffb.o: \
compile case_diffb.c case.h
	./compile case_diffb.c

check: \
it instcheck
	./instcheck

compile: \
warn-auto.sh conf-cc
	( cat warn-auto.sh; \
	echo exec "`head -1 conf-cc`" '-c $${1+"$$@"}' \
	) > compile
	chmod 755 compile

config.0: \
config.3
	nroff -man config.3 > config.0

config.o: \
compile config.c open.h readwrite.h substdio.h error.h getln.h \
stralloc.h gen_alloc.h config.h stralloc.h env.h
	./compile config.c

direntry.0: \
direntry.3
	nroff -man direntry.3 > direntry.0

direntry.h: \
compile trydrent.c direntry.h1 direntry.h2
	( ./compile trydrent.c >/dev/null 2>&1 \
	&& cat direntry.h2 || cat direntry.h1 ) > direntry.h
	rm -f trydrent.o

env.a: \
makelib env.o
	./makelib env.a env.o

env.o: \
compile env.c str.h env.h
	./compile env.c

error.0: \
error.3
	nroff -man error.3 > error.0

error.a: \
makelib error.o error_str.o
	./makelib error.a error.o error_str.o

error.o: \
compile error.c error.h
	./compile error.c

error_str.0: \
error_str.3
	nroff -man error_str.3 > error_str.0

error_str.o: \
compile error_str.c error.h
	./compile error_str.c

fd.a: \
makelib fd_copy.o fd_move.o
	./makelib fd.a fd_copy.o fd_move.o

fd_copy.0: \
fd_copy.3
	nroff -man fd_copy.3 > fd_copy.0

fd_copy.o: \
compile fd_copy.c fd.h
	./compile fd_copy.c

fd_move.0: \
fd_move.3
	nroff -man fd_move.3 > fd_move.0

fd_move.o: \
compile fd_move.c fd.h
	./compile fd_move.c

fmt_ulong.o: \
compile fmt_ulong.c fmt.h
	./compile fmt_ulong.c

fork.h: \
compile load tryvfork.c fork.h1 fork.h2
	( ( ./compile tryvfork.c && ./load tryvfork ) >/dev/null \
	2>&1 \
	&& cat fork.h2 || cat fork.h1 ) > fork.h
	rm -f tryvfork.o tryvfork

fs.a: \
makelib fmt_ulong.o scan_ulong.o
	./makelib fs.a fmt_ulong.o scan_ulong.o

getln.0: \
getln.3
	nroff -man getln.3 > getln.0

getln.a: \
makelib getln.o getln2.o
	./makelib getln.a getln.o getln2.o

getln.o: \
compile getln.c substdio.h byte.h stralloc.h gen_alloc.h getln.h
	./compile getln.c

getln2.0: \
getln2.3
	nroff -man getln2.3 > getln2.0

getln2.o: \
compile getln2.c substdio.h stralloc.h gen_alloc.h byte.h getln.h
	./compile getln2.c

getopt.a: \
makelib subgetopt.o sgetopt.o
	./makelib getopt.a subgetopt.o sgetopt.o

hasflock.h: \
tryflock.c compile load
	( ( ./compile tryflock.c && ./load tryflock ) >/dev/null \
	2>&1 \
	&& echo \#define HASFLOCK 1 || exit 0 ) > hasflock.h
	rm -f tryflock.o tryflock

hassgact.h: \
trysgact.c compile load
	( ( ./compile trysgact.c && ./load trysgact ) >/dev/null \
	2>&1 \
	&& echo \#define HASSIGACTION 1 || exit 0 ) > hassgact.h
	rm -f trysgact.o trysgact

haswaitp.h: \
trywaitp.c compile load
	( ( ./compile trywaitp.c && ./load trywaitp ) >/dev/null \
	2>&1 \
	&& echo \#define HASWAITPID 1 || exit 0 ) > haswaitp.h
	rm -f trywaitp.o trywaitp

hier.o: \
compile hier.c auto_home.h
	./compile hier.c

install: \
load install.o hier.o auto_home.o strerr.a substdio.a open.a error.a \
str.a
	./load install hier.o auto_home.o strerr.a substdio.a \
	open.a error.a str.a 

install.o: \
compile install.c substdio.h strerr.h error.h open.h readwrite.h \
exit.h
	./compile install.c

instcheck: \
load instcheck.o hier.o auto_home.o strerr.a substdio.a error.a str.a
	./load instcheck hier.o auto_home.o strerr.a substdio.a \
	error.a str.a 

instcheck.o: \
compile instcheck.c strerr.h error.h readwrite.h exit.h
	./compile instcheck.c

it: \
man prog install instcheck

leapsecs.0: \
leapsecs.3
	nroff -man leapsecs.3 > leapsecs.0

leapsecs_init.o: \
compile leapsecs_init.c leapsecs.h
	./compile leapsecs_init.c

leapsecs_read.o: \
compile leapsecs_read.c tai.h uint64.h leapsecs.h
	./compile leapsecs_read.c

leapsecs_sub.o: \
compile leapsecs_sub.c leapsecs.h tai.h uint64.h
	./compile leapsecs_sub.c

libtai.a: \
makelib tai_now.o tai_unpack.o caldate_fmjd.o leapsecs_read.o \
leapsecs_init.o leapsecs_sub.o caltime_utc.o
	./makelib libtai.a tai_now.o tai_unpack.o caldate_fmjd.o \
	leapsecs_read.o leapsecs_init.o leapsecs_sub.o caltime_utc.o

load: \
warn-auto.sh conf-ld
	( cat warn-auto.sh; \
	echo 'main="$$1"; shift'; \
	echo exec "`head -1 conf-ld`" \
	'-o "$$main" "$$main".o $${1+"$$@"}' \
	) > load
	chmod 755 load

lock.a: \
makelib lock_ex.o lock_exnb.o
	./makelib lock.a lock_ex.o lock_exnb.o

lock_ex.o: \
compile lock_ex.c hasflock.h lock.h
	./compile lock_ex.c

lock_exnb.o: \
compile lock_exnb.c hasflock.h lock.h
	./compile lock_exnb.c

maildir.0: \
maildir.5
	nroff -man maildir.5 > maildir.0

maildir.o: \
compile maildir.c prioq.h datetime.h gen_alloc.h env.h stralloc.h \
gen_alloc.h direntry.h datetime.h now.h datetime.h str.h maildir.h \
strerr.h
	./compile maildir.c

maildirqmtp: \
warn-auto.sh maildirqmtp.sh conf-home
	cat warn-auto.sh maildirqmtp.sh \
	| sed s}HOME}"`head -1 conf-home`"}g \
	> maildirqmtp
	chmod 755 maildirqmtp

maildirqmtp.0: \
maildirqmtp.1
	nroff -man maildirqmtp.1 > maildirqmtp.0

maildirserial: \
load maildirserial.o auto_qmail.o qmail.o maildir.o config.o quote.o \
prioq.o now.o env.a getopt.a mess822.a libtai.a getln.a strerr.a \
substdio.a stralloc.a alloc.a error.a str.a open.a wait.a sig.a fd.a \
fs.a
	./load maildirserial auto_qmail.o qmail.o maildir.o \
	config.o quote.o prioq.o now.o env.a getopt.a mess822.a \
	libtai.a getln.a strerr.a substdio.a stralloc.a alloc.a \
	error.a str.a open.a wait.a sig.a fd.a fs.a 

maildirserial.0: \
maildirserial.1
	nroff -man maildirserial.1 > maildirserial.0

maildirserial.o: \
compile maildirserial.c sgetopt.h subgetopt.h scan.h stralloc.h \
gen_alloc.h fd.h open.h getln.h subfd.h substdio.h strerr.h \
substdio.h readwrite.h maildir.h strerr.h prioq.h datetime.h \
gen_alloc.h wait.h fork.h sig.h str.h fmt.h tai.h uint64.h mess822.h \
stralloc.h caltime.h caldate.h now.h datetime.h config.h stralloc.h \
qmail.h substdio.h auto_qmail.h
	./compile maildirserial.c

maildirsmtp: \
warn-auto.sh maildirsmtp.sh conf-home
	cat warn-auto.sh maildirsmtp.sh \
	| sed s}HOME}"`head -1 conf-home`"}g \
	> maildirsmtp
	chmod 755 maildirsmtp

maildirsmtp.0: \
maildirsmtp.1
	nroff -man maildirsmtp.1 > maildirsmtp.0

makelib: \
warn-auto.sh systype
	( cat warn-auto.sh; \
	echo 'main="$$1"; shift'; \
	echo 'rm -f "$$main"'; \
	echo 'ar cr "$$main" $${1+"$$@"}'; \
	case "`cat systype`" in \
	sunos-5.*) ;; \
	unix_sv*) ;; \
	irix64-*) ;; \
	irix-*) ;; \
	dgux-*) ;; \
	hp-ux-*) ;; \
	sco*) ;; \
	*) echo 'ranlib "$$main"' ;; \
	esac \
	) > makelib
	chmod 755 makelib

man: \
maildirserial.0 setlock.0 serialsmtp.0 serialqmtp.0 maildirsmtp.0 \
maildirqmtp.0 alloc.0 caldate.0 caldate_mjd.0 caltime.0 caltime_tai.0 \
case.0 config.0 direntry.0 error.0 error_str.0 fd_copy.0 fd_move.0 \
getln2.0 getln.0 leapsecs.0 maildir.0 mess822_date.0 now.0 sgetopt.0 \
stralloc.0 subgetopt.0 tai.0 tai_now.0 tai_pack.0 wait.0

mess822.a: \
makelib mess822_date.o
	./makelib mess822.a mess822_date.o

mess822_date.0: \
mess822_date.3
	nroff -man mess822_date.3 > mess822_date.0

mess822_date.o: \
compile mess822_date.c mess822.h stralloc.h gen_alloc.h caltime.h \
caldate.h stralloc.h
	./compile mess822_date.c

now.0: \
now.3
	nroff -man now.3 > now.0

now.o: \
compile now.c datetime.h now.h datetime.h
	./compile now.c

open.a: \
makelib open_read.o open_trunc.o open_append.o
	./makelib open.a open_read.o open_trunc.o open_append.o

open_append.o: \
compile open_append.c open.h
	./compile open_append.c

open_read.o: \
compile open_read.c open.h
	./compile open_read.c

open_trunc.o: \
compile open_trunc.c open.h
	./compile open_trunc.c

prioq.o: \
compile prioq.c alloc.h gen_allocdefs.h prioq.h datetime.h \
gen_alloc.h
	./compile prioq.c

prog: \
maildirserial setlock serialsmtp serialqmtp maildirsmtp maildirqmtp \
rts

qmail.o: \
compile qmail.c substdio.h readwrite.h wait.h exit.h fork.h fd.h \
qmail.h substdio.h auto_qmail.h
	./compile qmail.c

quote.o: \
compile quote.c stralloc.h gen_alloc.h str.h quote.h
	./compile quote.c

rts: \
warn-auto.sh rts.sh conf-home
	cat warn-auto.sh rts.sh \
	| sed s}HOME}"`head -1 conf-home`"}g \
	> rts
	chmod 755 rts

scan_ulong.o: \
compile scan_ulong.c scan.h
	./compile scan_ulong.c

select.h: \
compile trysysel.c select.h1 select.h2
	( ./compile trysysel.c >/dev/null 2>&1 \
	&& cat select.h2 || cat select.h1 ) > select.h
	rm -f trysysel.o trysysel

serialqmtp: \
load serialqmtp.o timeoutread.o timeoutwrite.o env.a sig.a getln.a \
stralloc.a strerr.a substdio.a alloc.a error.a str.a wait.a open.a \
fd.a fs.a
	./load serialqmtp timeoutread.o timeoutwrite.o env.a sig.a \
	getln.a stralloc.a strerr.a substdio.a alloc.a error.a \
	str.a wait.a open.a fd.a fs.a 

serialqmtp.0: \
serialqmtp.1
	nroff -man serialqmtp.1 > serialqmtp.0

serialqmtp.o: \
compile serialqmtp.c strerr.h getln.h substdio.h stralloc.h \
gen_alloc.h subfd.h substdio.h readwrite.h sig.h timeoutread.h \
timeoutwrite.h fd.h fork.h exit.h open.h wait.h str.h fmt.h env.h
	./compile serialqmtp.c

serialsmtp: \
load serialsmtp.o timeoutread.o timeoutwrite.o quote.o case.a env.a \
sig.a getln.a stralloc.a strerr.a substdio.a alloc.a error.a str.a \
wait.a open.a fd.a fs.a
	./load serialsmtp timeoutread.o timeoutwrite.o quote.o \
	case.a env.a sig.a getln.a stralloc.a strerr.a substdio.a \
	alloc.a error.a str.a wait.a open.a fd.a fs.a 

serialsmtp.0: \
serialsmtp.1
	nroff -man serialsmtp.1 > serialsmtp.0

serialsmtp.o: \
compile serialsmtp.c strerr.h getln.h subfd.h substdio.h substdio.h \
readwrite.h open.h timeoutread.h timeoutwrite.h exit.h stralloc.h \
gen_alloc.h sig.h str.h case.h quote.h scan.h env.h
	./compile serialsmtp.c

setlock: \
load setlock.o getopt.a strerr.a substdio.a error.a str.a lock.a \
open.a
	./load setlock getopt.a strerr.a substdio.a error.a str.a \
	lock.a open.a 

setlock.0: \
setlock.1
	nroff -man setlock.1 > setlock.0

setlock.o: \
compile setlock.c lock.h open.h strerr.h exit.h sgetopt.h subgetopt.h
	./compile setlock.c

setup: \
it install
	./install

sgetopt.0: \
sgetopt.3
	nroff -man sgetopt.3 > sgetopt.0

sgetopt.o: \
compile sgetopt.c substdio.h subfd.h substdio.h sgetopt.h subgetopt.h \
subgetopt.h
	./compile sgetopt.c

sig.a: \
makelib sig_catch.o sig_pipe.o
	./makelib sig.a sig_catch.o sig_pipe.o

sig_catch.o: \
compile sig_catch.c sig.h hassgact.h
	./compile sig_catch.c

sig_pipe.o: \
compile sig_pipe.c sig.h
	./compile sig_pipe.c

str.a: \
makelib str_len.o str_diff.o str_rchr.o str_start.o byte_chr.o \
byte_diff.o byte_copy.o byte_cr.o
	./makelib str.a str_len.o str_diff.o str_rchr.o \
	str_start.o byte_chr.o byte_diff.o byte_copy.o byte_cr.o

str_diff.o: \
compile str_diff.c str.h
	./compile str_diff.c

str_len.o: \
compile str_len.c str.h
	./compile str_len.c

str_rchr.o: \
compile str_rchr.c str.h
	./compile str_rchr.c

str_start.o: \
compile str_start.c str.h
	./compile str_start.c

stralloc.0: \
stralloc.3
	nroff -man stralloc.3 > stralloc.0

stralloc.a: \
makelib stralloc_eady.o stralloc_pend.o stralloc_copy.o \
stralloc_opys.o stralloc_opyb.o stralloc_cat.o stralloc_cats.o \
stralloc_catb.o stralloc_arts.o stralloc_num.o
	./makelib stralloc.a stralloc_eady.o stralloc_pend.o \
	stralloc_copy.o stralloc_opys.o stralloc_opyb.o \
	stralloc_cat.o stralloc_cats.o stralloc_catb.o \
	stralloc_arts.o stralloc_num.o

stralloc_arts.o: \
compile stralloc_arts.c byte.h str.h stralloc.h gen_alloc.h
	./compile stralloc_arts.c

stralloc_cat.o: \
compile stralloc_cat.c byte.h stralloc.h gen_alloc.h
	./compile stralloc_cat.c

stralloc_catb.o: \
compile stralloc_catb.c stralloc.h gen_alloc.h byte.h
	./compile stralloc_catb.c

stralloc_cats.o: \
compile stralloc_cats.c byte.h str.h stralloc.h gen_alloc.h
	./compile stralloc_cats.c

stralloc_copy.o: \
compile stralloc_copy.c byte.h stralloc.h gen_alloc.h
	./compile stralloc_copy.c

stralloc_eady.o: \
compile stralloc_eady.c alloc.h stralloc.h gen_alloc.h \
gen_allocdefs.h
	./compile stralloc_eady.c

stralloc_num.o: \
compile stralloc_num.c stralloc.h gen_alloc.h
	./compile stralloc_num.c

stralloc_opyb.o: \
compile stralloc_opyb.c stralloc.h gen_alloc.h byte.h
	./compile stralloc_opyb.c

stralloc_opys.o: \
compile stralloc_opys.c byte.h str.h stralloc.h gen_alloc.h
	./compile stralloc_opys.c

stralloc_pend.o: \
compile stralloc_pend.c alloc.h stralloc.h gen_alloc.h \
gen_allocdefs.h
	./compile stralloc_pend.c

strerr.a: \
makelib strerr_sys.o strerr_die.o
	./makelib strerr.a strerr_sys.o strerr_die.o

strerr_die.o: \
compile strerr_die.c substdio.h subfd.h substdio.h exit.h strerr.h
	./compile strerr_die.c

strerr_sys.o: \
compile strerr_sys.c error.h strerr.h
	./compile strerr_sys.c

subfderr.o: \
compile subfderr.c readwrite.h substdio.h subfd.h substdio.h
	./compile subfderr.c

subfdins.o: \
compile subfdins.c readwrite.h substdio.h subfd.h substdio.h
	./compile subfdins.c

subfdouts.o: \
compile subfdouts.c readwrite.h substdio.h subfd.h substdio.h
	./compile subfdouts.c

subgetopt.0: \
subgetopt.3
	nroff -man subgetopt.3 > subgetopt.0

subgetopt.o: \
compile subgetopt.c subgetopt.h
	./compile subgetopt.c

substdi.o: \
compile substdi.c substdio.h byte.h error.h
	./compile substdi.c

substdio.a: \
makelib substdio.o substdi.o substdo.o subfderr.o subfdouts.o \
subfdins.o substdio_copy.o
	./makelib substdio.a substdio.o substdi.o substdo.o \
	subfderr.o subfdouts.o subfdins.o substdio_copy.o

substdio.o: \
compile substdio.c substdio.h
	./compile substdio.c

substdio_copy.o: \
compile substdio_copy.c substdio.h
	./compile substdio_copy.c

substdo.o: \
compile substdo.c substdio.h str.h byte.h error.h
	./compile substdo.c

systype: \
find-systype.sh conf-cc conf-ld trycpp.c
	( cat warn-auto.sh; \
	echo CC=\'`head -1 conf-cc`\'; \
	echo LD=\'`head -1 conf-ld`\'; \
	cat find-systype.sh; \
	) | sh > systype

tai.0: \
tai.3
	nroff -man tai.3 > tai.0

tai_now.0: \
tai_now.3
	nroff -man tai_now.3 > tai_now.0

tai_now.o: \
compile tai_now.c tai.h uint64.h
	./compile tai_now.c

tai_pack.0: \
tai_pack.3
	nroff -man tai_pack.3 > tai_pack.0

tai_unpack.o: \
compile tai_unpack.c tai.h uint64.h
	./compile tai_unpack.c

timeoutread.o: \
compile timeoutread.c timeoutread.h select.h error.h readwrite.h
	./compile timeoutread.c

timeoutwrite.o: \
compile timeoutwrite.c timeoutwrite.h select.h error.h readwrite.h
	./compile timeoutwrite.c

uint64.h: \
tryulong64.c compile load uint64.h1 uint64.h2
	( ( ./compile tryulong64.c && ./load tryulong64 && \
	./tryulong64 ) >/dev/null 2>&1 \
	&& cat uint64.h1 || cat uint64.h2 ) > uint64.h
	rm -f tryulong64.o tryulong64

wait.0: \
wait.3
	nroff -man wait.3 > wait.0

wait.a: \
makelib wait_pid.o
	./makelib wait.a wait_pid.o

wait_pid.o: \
compile wait_pid.c error.h haswaitp.h
	./compile wait_pid.c
