FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Installs Jupyter Notebook and IRkernel kernel from the current branch

# Retrieve recent R binary from CRAN
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
#RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu jessie/">>/etc/apt/sources.list && \
#    apt-get update -qq && \
#    DEBIAN_FRONTEND=noninteractive apt-get install -yq --force-yes --no-install-recommends \
#        r-base r-base-dev && \
#        apt-get clean && \
#        rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install -y r-base r-base-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

USER main

# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site

# Install IRkernel
RUN R -e "install.packages(c('igraph', 'rzmq','repr','IRkernel','IRdisplay'), repos = c('http://irkernel.github.io/', getOption('repos')))" -e "IRkernel::installspec()"
