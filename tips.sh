#!/bin/bash
# office.guohead.com
# alias guohedev='ssh sysop@10.5.1.10' 
# 123456
# log: XForward
# syslog, udp 514 <- nginx log
# hhvm + nginx : php
# apache2.2 worker 
# ubuntu上syslog的替代版本是rsyslogd
#####################################Packages installation######################################
# 1) Using sudo or as root user (First may have to run sudo apt-get upadte)
# 2) Install Dev Packages
sudo apt-get install git-core cmake g++ libmysqlclient-dev \
  libxml2-dev libmcrypt-dev libicu-dev openssl build-essential binutils-dev \
  libcap-dev libgd2-xpm-dev zlib1g-dev libtbb-dev libonig-dev libpcre3-dev \
  autoconf automake libtool libcurl4-openssl-dev \
  wget memcached libreadline-dev libncurses-dev libmemcached-dev libbz2-dev \
  libc-client2007e-dev php5-mcrypt php5-imagick libgoogle-perftools-dev \
  libcloog-ppl0 libelf-dev libdwarf-dev subversion python-software-properties \
  libmagickwand-dev libxslt1-dev ocaml-native-compilers libevent-dev

#####################################Upgrading gcc to 4.7######################################

# HHVM requires gcc >= 4.7.0,but Ubuntu 12.04 only ships with 4.6. To get a more recent version, follow these steps:
# add-apt-repository 是由 python-software-properties 这个工具包提供的
# 所以要先安装python-software-properties 才能使用 add-apt-repository
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-4.7 g++-4.7

#Then make gcc-4.7 the default compiler by updating the alternates db:
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 60 \
                         --slave /usr/bin/g++ g++ /usr/bin/g++-4.7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 40 \
                         --slave /usr/bin/g++ g++ /usr/bin/g++-4.6
sudo update-alternatives --set gcc /usr/bin/gcc-4.7


#####################################Installing Boost 1.49######################################
# Similarly, HHVM requires Boost 1.49, but Ubuntu 12.04 only ships with 1.48. To get a more recent version
sudo add-apt-repository ppa:mapnik/boost
sudo apt-get update
sudo apt-get install libboost1.49-dev libboost-regex1.49-dev \
  libboost-system1.49-dev libboost-program-options1.49-dev \
  libboost-filesystem1.49-dev libboost-thread1.49-dev


#####################################Getting HipHop  source-code######################################
mkdir dev
cd dev
git clone git://github.com/facebook/hhvm.git
cd hhvm
git submodule update --init --recursive
export CMAKE_PREFIX_PATH=`pwd`/..
cd ..


#####################################Building third-party libraries ######################################

#libCurl
#Make sure that your system time is correct, otherwise ./configure will fail.
t clone git://github.com/bagder/curl.git
cd curl
./buildconf
./configure --prefix=$CMAKE_PREFIX_PATH
make
make install
cd ..

#Note: If you're building a version of cURL older than 7.28.0 (for whatever reason), you'll need to apply the patch in third-party to update it prior to the make step.
cat ../hhvm/third-party/libcurl-7.22.1.fb-changes.diff | patch -p1

#Google glog
svn checkout http://google-glog.googlecode.com/svn/trunk/ google-glog
cd google-glog
./configure --prefix=$CMAKE_PREFIX_PATH
make
make install
cd ..

#Note: If you're not authenticated as the root user, use sudo make install instead of make install, or you will get problems on the cmake.


#JEMalloc 3.x

wget http://www.canonware.com/download/jemalloc/jemalloc-3.5.1.tar.bz2
tar xjvf jemalloc-3.5.1.tar.bz2
cd jemalloc-3.5.1
./configure --prefix=$CMAKE_PREFIX_PATH
make
make install
cd ..


#Building HipHop
#Please ensure that your machine has more than 1GB of RAM
cd hhvm
cmake .
make

#Running programs
#The hhvm binary can be found in hphp/hhvm/hhvm

#The Hack language
#See https://github.com/facebook/hhvm/wiki/Building-the-Hack-Typechecker.

#Errors
#If any errors occur, it may be required to remove the CMakeCache.txt file in the checkout.

#If your failure was on the make command, try to correct the error and run make again, it should restart from the point it stops.


#ICU

#If CMake is complaining about libicu/ICU then you may need to build ICU manually before cmake will run:

wget http://download.icu-project.org/files/icu4c/52.1/icu4c-52_1-src.tgz
tar -xzvf icu4c-52_1-src.tgz
cd icu/source
./configure --prefix=$CMAKE_PREFIX_PATH
make
sudo make install

#Then delete the CMakeCache.txt file in the hhvm directory if it exists to get a clean CMake run.
