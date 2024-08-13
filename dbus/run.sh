if ! pgrep -x "dbus-daemon" > /dev/null
then
    # export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address | cut -d, -f1)

    # or:
    dbus-daemon --config-file=/usr/share/dbus-1/system.conf
    # and put in Dockerfile:
    # ENV DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/dbus/system_bus_socket"
else
    echo "dbus-daemon already running"
fi

if ! pgrep -x "/usr/lib/upower/upowerd" > /dev/null
then
    /usr/lib/upower/upowerd &
else
    echo "upowerd already running"
fi