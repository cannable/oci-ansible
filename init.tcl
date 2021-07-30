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
catch {
    exec -- {
        adduser
        -h /ansible
        -s /bin/bash
        -u $env(ANSIBLE_UID)
        -g $env(ANSIBLE_GID)
        -D $env(ANSIBLE_USER)
    } <@stdin >@stdout 2>@stderr
}

# Start the command line. If you want to add further wrapping, put it here
set cmdline [list]

# Append what was passed as arguments to the command line
lappend cmdline {*}$argv

# Run the command line
catch {exec -- {*}$cmdline <@stdin >@stdout 2>@stderr}
