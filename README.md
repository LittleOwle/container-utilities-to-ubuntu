# container-utilities-to-ubuntu
build utilities and installation of updated version for containers on ubuntu
                     
created for internal use by Jamil Services

~~~bash
$ cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.4 LTS"
~~~

go: https://github.com/golang/go             
go-md2man: https://github.com/cpuguy83/go-md2man                 
conmon: https://github.com/containers/conmon           
umoci: https://github.com/opencontainers/umoci              
runC: https://github.com/opencontainers/runc                

install:
~~~bash
sudo apt install libseccomp2 libseccomp-dev
curl https://raw.githubusercontent.com/LittleOwle/container-utilities-to-ubuntu/main/scripts/build.sh -sSf | sudo bash
sudo rm -rf /opt/owle-externals/source
~~~


remove:
~~~bash
curl https://raw.githubusercontent.com/LittleOwle/container-utilities-to-ubuntu/main/scripts/remove.sh -sSf | sudo bash
~~~


export:
~~~bash
export PATH=/opt/owle-externals/build/runc/sbin:/opt/owle-externals/build/umoci/bin:/opt/owle-externals/build/conmon/bin:/opt/owle-externals/build/go-md2man/bin:/opt/owle-externals/build/go/bin:$PATH
~~~

versions:
 - go: v1.22.0
 - go-md2man: v2.0.4
 - conmon: v2.1.12
 - umoci: v0.4.7
 - runC: v1.1.13
