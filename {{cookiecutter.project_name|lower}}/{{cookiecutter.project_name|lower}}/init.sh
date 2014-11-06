#! /bin/sh
### BEGIN INIT INFO
# Provides:          {{cookiecutter.project_name|lower}}
# Required-Start:    $remote_fs
# Required-Stop:     $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: TODO
# Description:       TODO
### END INIT INFO

# Author: {{cookiecutter.full_name}} <{{cookiecutter.email}}>
#
# Please remove the "Author" lines above and replace them
# with your own name if you copy and modify this script.

# Do NOT "set -e"

# NAME={{cookiecutter.project_name|lower}}

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="TODO"
SCRIPTNAME=/etc/init.d/$NAME

# Read configuration variable file if it is present
# [ -r /etc/default/$NAME ] && . /etc/default/$NAME
[ -r /opt/{{cookiecutter.project_name|lower}}/shared/default ] &&
    . /opt/{{cookiecutter.project_name|lower}}/shared/default

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

is_running()
{
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $JAVA --user $USER --test > /dev/null \
		|| return 1
    return 0
}

#
# Function that starts the daemon/service
#
do_start()
{
	# Return
	#   0 if daemon has been started
	#   1 if daemon was already running
	#   2 if daemon could not be started
    is_running || return 1

	start-stop-daemon --start --quiet \
               --pidfile $PIDFILE \
               --make-pidfile \
               --chuid $USER:$GROUP \
               --background \
               --exec $JAVA -- \
                 $JAVA_OPTS \
                 -jar /opt/${NAME}/current/${NAME}.jar \
                 >/opt/${NAME}/shared/log/${NAME}.out \
                 2>/opt/${NAME}/shared/log/${NAME}.err \
		|| return 2
}

#
# Function that stops the daemon/service
#
do_stop()
{
	# Return
	#   0 if daemon has been stopped
	#   1 if daemon was already stopped
	#   2 if daemon could not be stopped
	#   other if a failure occurred
	is_running && return 1

	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE
	RETVAL="$?"
	[ "$RETVAL" = 2 ] && return 2
	# Many daemons don't delete their pidfiles when they exit.
	[ "$RETVAL" = 0 ] && rm -f $PIDFILE
	return "$RETVAL"
}

case "$1" in
  start)
	[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
	do_start
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  stop)
	[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
	do_stop
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  status)
       status_of_proc -p $PIDFILE "$NAME" "$NAME" && exit 0 || exit $?
       ;;
  restart|force-reload)
	#
	# If the "reload" option is implemented then remove the
	# 'force-reload' alias
	#
	log_daemon_msg "Restarting $DESC" "$NAME"
	do_stop
	case "$?" in
	  0|1)
		do_start
		case "$?" in
			0) log_end_msg 0 ;;
			1) log_end_msg 1 ;; # Old process is still running
			*) log_end_msg 1 ;; # Failed to start
		esac
		;;
	  *)
	  	# Failed to stop
		log_end_msg 1
		;;
	esac
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

:
