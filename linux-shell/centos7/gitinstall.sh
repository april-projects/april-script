gitInstall() {
    yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc xmlto perl-devel perl-CPAN autoconf* libtool
    yum remove -y git

    if [ ! -f "./git-v${GIT_VERSION}.tar.gz" ]; then
      echo -e "\033[41;37m git 正在下载。 \033[0m"

      wget -O git-v${GIT_VERSION}.tar.gz https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
    fi

    if [ $? -ne 0 ]; then
        echo -e "========================================================"
        echo -e "\033[41;37m 下载git ${GIT_VERSION} 失败。 \033[0m"
        echo -e "========================================================"

        exit 1;
    fi

    tar zxvf git-v${GIT_VERSION}.tar.gz
    cd git-${GIT_VERSION}
    make configure
    ./configure --prefix=/usr/local --with-iconv=/usr/local/libiconv
    make install
    echo "export PATH=\$PATH:/usr/local/bin" > /etc/profile.d/git.sh
    source /etc/profile

    # 检查git安装是否成功
    git version

    if [ $? -ne 0 ]; then
        echo -e "========================================================"
        echo -e "\033[41;37m 下载git ${GIT_VERSION} 失败。 \033[0m"
        echo -e "========================================================"

        exit 1;
    else
        echo -e "========================================================"
        echo -e "\033[42;37m 安装 git ${GIT_VERSION} 成功。 \033[0m"
        echo -e "========================================================"
    fi

    cd -
}