toggleproxy() {
  proxy=http://PITC-Zscaler-AmericasZ.proxy.corporate.ge.com:80;
  if [ -z $http_proxy ] ; then
    export proxy_host=$proxy
    export proxy_port=80;
    export http_proxy=$proxy
    export ftp_proxy=$proxy
    export socks_proxy=$proxy
    export https_proxy=$proxy
    export HTTP_PROXY=$proxy
    export HTTPS_PROXY=$proxy
    export no_proxy=localhost,127.0.0.1,192.168.*,gitlab.cloud.corporate.ge.com,.cloud.corporate.ge.com,*.corporate.ge.com,*.ge.com,10.0.2.2,github.build.ge.com,registry.gear.ge.com,192.168.40.10,192.168.40.12
    #atom package manager
    #apm config set https-proxy $proxy
    echo "Proxy is set to $proxy !"
  else
    unset proxy_host
    unset proxy_port
    unset http_proxy
    unset ftp_proxy
    unset socks_proxy
    unset https_proxy
    unset HTTPS_PROXY
    unset HTTP_PROXY
    #atom package manager
    #apm config delete https-proxy
    echo "No proxy for you!"
  fi
}
