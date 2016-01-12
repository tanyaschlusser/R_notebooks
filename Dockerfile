FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Jupyter notebook dependencies
RUN apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
        libcurl4-openssl-dev \
        libffi-dev \
        libsqlite3-dev \
        libzmq3-dev \
        pandoc \
        sqlite3 \
        texlive-fonts-recommended \
        texlive-latex-base \
        texlive-latex-extra \
        zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Retrieve recent R binary from CRAN
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    echo "deb http://cran.rstudio.com/bin/linux/ubuntu wily/">>/etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install -yq --force-yes --no-install-recommends \
        libjpeg8 \
        r-base \
        r-base-core \
        r-base-dev \
        r-recommended && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Set default CRAN repo and install IRkernel
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site && \
    Rscript -e "install.packages(c( \
          'IRkernel', \
          'IRdisplay', \
          'igraph', \
          'repr', \
          'rpart.plot', \
          'rzmq', \
          'vcd' \
        ), \
        repos=c('http://irkernel.github.io/', getOption('repos')))" \
      -e "IRkernel::installspec(user=FALSE)"

USER main
