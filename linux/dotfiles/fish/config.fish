if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
    exec uwsm start default
end
