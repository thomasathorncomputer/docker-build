docker run -d --name bitwarden -e ROCKET_TLS='{certs="/ssl/bitwarden.crt",key="/ssl/bitwarden.key"}' -v /ssl/:/ssl/ -v /bw-data/:/data/ -p 443:80 bitwardenrs/server:latest
