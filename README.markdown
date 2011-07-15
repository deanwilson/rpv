RPV - Remote Process Verifier
=============

Check that everything you expect, and nothing else, is running

Quick Start Guide
-------------

 * Clone the git repo
 * Show unmatched processes

From the checkout run -

    ruby -I lib rpv --confdir=. --format nagios_processes

this will show you all the processes that are not currently "known" by RPV.
To see the details run -

    ruby -I lib rpv --confdir=. --format nagios_processes --verbose

In order to acknowledge some of those processes we need to define which
roles this machine has. While you can create this list from a hosts
/var/lib/puppet/classes.txt (and probably the equivalent in chef) we're
going to hand add a class to keep the example short.

    echo "linux" >> classes
    
Now that we've declared the machine as having the linux roll let's add a
couple of processes that we're expecting to see.

    $ ruby -I lib rpv --confdir=. --format nagios_processes --verbose | grep syslog
    pid => 2898, ppid => 1, uname => root, command => syslogd -m 0

Now we've got an example process we'll normalise it and add it to the
expected process files.

    echo "ppid => 1, uname => root, command => syslogd" >> allowed/linux

Now if we re-run 

    ruby -I lib rpv --confdir=. --format nagios_processes --verbose | grep syslog

You'll see it's no longer listed. While this can be quite a bit of upfront
work it becomes easier as you classify your hosts into groups and even
easier if you use something like puppet to build them for you based on
existing resources.

RPV as a bulk nagios check
-------------

RPV also allows you to list all of the filters that have not matched. Using
the nagios output mode you can use this as a cheap, bulk, process checker.

Add a fake filter line:

    $ echo "ppid => 1, uname => root, command => testy" >> allowed/syslog::client
    CRITICAL: 1 of 158 filters are unmatched
    Filter {"command"=>"testy", "uname"=>"root", "ppid"=>1}

And now nagios will tell you about processes that have stopped.

Known filters and examples
-------------

The filters currently know about 4 fields and require all of them to match
to class a process as known.

  * pid
  * ppid
  * uname
  * command

Examples:
  uname => root, command => /usr/libexec/postfix/master, ppid => 1
  uname => postfix, command => qmgr -l -t fifo -u
  uname => postfix, command => pickup -l -t fifo -u
  uname => postfix, command => showq -t unix -u
  uname => root, command => /usr/sbin/saslauthd

