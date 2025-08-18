if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -z "$SSH_TTY" -a -z "$DISPLAY"
        if not test -e /tmp/.uwsm_started
            uwsm start default
            touch /tmp/.uwsm_started
        end
    end

end
