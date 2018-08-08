Checking the availble space for work library on unix and windows

github
https://tinyurl.com/ydaq6e8u
https://github.com/rogerjdeangelis/utl_checking_the_availble_space_for_work_library_on_unix_and_windows

see
https://tinyurl.com/y98vxzw9
https://communities.sas.com/t5/Administration-and-Deployment/Crashed-Temp-space-on-SAS-9-4-BI-server/m-p/485047

I have seen prices for a terabyte of disk space as low as $25.
Tell the IT guy you are willing to help him with resouces
by providing a free disk for your work library.
This should have the IT guy jumping by joy.

Here is how you can check your available space for your work library.

UNIX
====

OUTPUT
======

Filesystem                              1K-blocks     Used Available Use% Mounted on
/dev/xx/dsk/sas_work_xx/xxxxxxxxwork04 1073741824 66141896 999926424   7% /app/u07/sas/work04

PROCESS
=======

%unx(df -k %sysfunc(pathname(work))); * also useful to see how much space you have left;


%macro unx(unxcmd);
  filename xeq pipe "&unxcmd";
  data _null_;
    infile xeq;
    input;
    putlog _infile_;
  run;quit;
%mend unx;


WINDOWS
========

OUTPUT
======

DISKS total obs=6

 NAME        SIZE          FREESPACE

  C:     1596719063041     549291622401
  D:     6401325752323    2183642357762

  E:     4779965112324    4582833889285   * SASWORK i here

  F:     2400546938885    1235440762887
  G:     4778119618566    4777014722563
  H:      310032424967     304718848002


PROCESS
=======

%PUT %sysfunc(pathname(work)));

e:\saswork\wrk\_TDXXXXX)

* WINDOWS;

data disks ;
  infile 'wmic logicaldisk get name,size,freespace' pipe firstobs=2 truncover ;
  length name $2 size freespace 8 ;
  input name $2. @1 @ ;
  if name = ' ' then input name ;
  else input freespace name size ;
  if name ne ' ';
  format size freespace comma32. ;
run;

