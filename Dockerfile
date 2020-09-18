FROM alt:sisyphus

MAINTAINER  Aleksey Ovchinnikov
LABEL Description="Container provides a virtual SFTP server with GOST support" 

RUN apt-get --yes update && \
    apt-get --yes install apt-repo openssl && \
    apt-repo add rpm [p9] http://mirror.yandex.ru/altlinux/ p9/branch/x86_64 gostcrypto && \
    apt-get --yes update && \
    apt-get --yes install openssl-gost-engine openssh-gostcrypto \
                    openssh-clients-gostcrypto                    \
                    openssh-server-gostcrypto                      \
                    openssh-server-control-gostcrypto               \
                    openssh-common-gostcrypto                        \ 
                    openssh-askpass-common-gostcrypto                 \
                    passwd tcb-hash-prefix-control &&                  \
    control openssl-gost enabled && \
    echo 'Ciphers magma-ctr@altlinux.org' >> /etc/openssh/sshd_config && \
    echo 'MACs grasshopper-mac@altlinux.org,hmac-streebog-512@altlinux.org' >> /etc/openssh/sshd_config && \
    echo 'PasswordAuthentication no' >> /etc/openssh/sshd_config && \
    echo 'ForceCommand internal-sftp -u 0000' >> /etc/openssh/sshd_config && \
    echo 'ChrootDirectory /var/sftp' >> /etc/openssh/sshd_config && \
    echo 'PermitTunnel no' >> /etc/openssh/sshd_config && \
    echo 'AllowAgentForwarding no' >> /etc/openssh/sshd_config && \
    echo 'AllowTcpForwarding no' >> /etc/openssh/sshd_config && \
    echo 'X11Forwarding no' >> /etc/openssh/sshd_config && \
    echo 'AuthorizedKeysFile /root/.ssh/authorized_keys' >> /etc/openssh/sshd_config && \
    control tcb-hash-prefix gost_yescrypt && \
    control tcb-hash-prefix default && \
    /usr/bin/ssh-keygen -A && \
    mkdir -p /var/sftp/ && \
    chown root:root /var/sftp/ && \
    chmod 755 /var/sftp/ && \
    apt-get --yes clean && \
    rm -rf /var/lib/apt/lists/*

ADD authorized_keys /root/.ssh/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
