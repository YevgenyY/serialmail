
exec \
HOME/bin/maildirserial -b -t 1209600 -- "$1" "$2" \
tcpclient -RHl0 -- "$3" 25 \
HOME/bin/serialsmtp "$2" "$4"
