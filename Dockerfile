FROM centos:centos6

RUN yum install -y gcc curl perl tar bzip2 patch

ENV APPROOT /src
ENV PERL_VERSION 5.20.1

# Perl
RUN curl -s https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build > /usr/bin/perl-build
RUN perl -pi -e 's%^#!/usr/bin/env perl%#!/usr/bin/perl%g' /usr/bin/perl-build
RUN chmod +x /usr/bin/perl-build
RUN perl-build $PERL_VERSION /opt/perl-$PERL_VERSION

# cpanm, Carton
RUN curl -s -L http://cpanmin.us/ | /opt/perl-$PERL_VERSION/bin/perl - --notest App::cpanminus Carton

ENV PATH /opt/perl-$PERL_VERSION/bin:$PATH
ENV CPAN_INSTALL_PATH /cpan

RUN yum install -y expat-devel openssl-devel mysql-devel

RUN install -d -m 755 $APPROOT /config /cpan
COPY cpanfile $APPROOT/cpanfile
COPY cpanfile.snapshot $APPROOT/cpanfile.snapshot

WORKDIR $APPROOT
RUN carton install --deployment
COPY ./ $APPROOT

EXPOSE 80

CMD ["./dockerup.sh"]
