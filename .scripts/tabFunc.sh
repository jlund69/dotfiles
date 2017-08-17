function tab () {
    local cmd=""
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm2"
            tell current session of current window
                set newPane to (split horizontally with default profile)
                tell newPane
                    write text "cd \"$cdto\"$cmd"
                end tell
            end tell
        end tell
EOF
}

function tabprod () {
    local cmd=""
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        cmd="; $args"
    fi

#    osascript &>/dev/null <<EOF
#        tell application "iTerm2"
#            tell current session of current window
#               set newPane to (split horizontally with profile "prod")
#                tell newPane
#                    write text "cd \"$cdto\"$cmd"
#                end tell
#            end tell
#        end tell

    osascript &>/dev/null <<EOF
        tell application "iTerm2"
                 activate
             tell the current window to set tb to create tab with profile "prod"
                 tell current session of current window to write text "cd \"$cdto\"$cmd"
        end tell
EOF
}
