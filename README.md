# GOST SFTP Server

Container provides a virtual SFTP server with GOST( russian cryptographic algorithm) support

## Introduction

SSH File Transfer Protocol, not to be confused with Simple File Transfer Protocol) use a protocol that allows for the transfer of files over a secure SSH connection.
Current SFTP server has a GOST cryptografy support on .
The server use magma-ctr Cipher and grasshopper-mac,hmac-streebog-512 MAC's (Message Authentication Code) for encrypting the data transfers.

A Public Key Authentication work with cryptographic algorithms keys: RSA DSA ECDSA ED25519 

Password Authentication is disabled.

## How to build

Run the following command to build your image:

```sh
docker build -t company/gost .
```

## How to run

You can start the sftp server with following command:

```sh
docker run -d --name gost -p 0.0.0.0:10022:22 -v /yourhostfilder/:/var/sftp/data company/gost
```

## How to connect

For example:

```sh
sftp -oCiphers=magma-ctr@altlinux.org -oMACs=grasshopper-mac@altlinux.org,hmac-streebog-512@altlinux.org -i ./id_rsa  root@server
```

have fun!
