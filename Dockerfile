# Base image of the IPython/Jupyter notebook, with conda
# Intended to be used in a tmpnb installation
# Customized from:
#  https://github.com/binder-project/example-dockerfile/blob/master/Dockerfile
FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Installs Jupyter Notebook and IRkernel kernel from the current branch

# Retrieve recent R binary from CRAN
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/">>/etc/apt/sources.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --force-yes --no-install-recommends \
        r-base r-base-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site

# Install IRkernel
RUN Rscript -e "install.packages(c('igraph', 'rzmq','repr','IRkernel','IRdisplay'), repos = c('http://irkernel.github.io/', getOption('repos')))" -e "IRkernel::installspec()"

USER main
