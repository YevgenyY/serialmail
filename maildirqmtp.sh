
exec \
HOME/bin/maildirserial -b -t 1209600 -- "$1" "$2" \
tcpclient -RHl0 -- "$3" 209 \
HOME/bin/serialqmtp "$2"
