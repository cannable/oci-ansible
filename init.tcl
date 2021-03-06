#! /usr/bin/env tclsh

# ------------------------------------------------------------------------------
# Ansible Container - Tcl Init Script
# ------------------------------------------------------------------------------
# This is a simple wrapper to set up an ansible environment in the container,
# then execute commands. It exists because bash has a tendency to collapse a
# layer of quoting when dealing with command lines. Ansible arguments can tend
# to get complex, especially if you're passing json. After trying a few things,
# it was just easier to add ~ 8 MB to the container image and do this in Tcl
# (which is the perfect amount of picky when it comes to how exec works ;-).


# Create unprivileged ansible user
exec -- /usr/sbin/adduser -s /bin/bash -h $env(CONTAINER_HOME) -u $env(CONTAINER_UID) -g $env(CONTAINER_GID) -D $env(CONTAINER_USER) <@stdin >@stdout 2>@stderr

# Start the command line. If you want to add further wrapping, put it here
set cmdline [list su $env(CONTAINER_USER) -c $argv]

# Append what was passed as arguments to the command line
#lappend cmdline {*}$argv

# Run the command line
catch {exec -- {*}$cmdline <@stdin >@stdout 2>@stderr}
