FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Installs Jupyter Notebook and IRkernel kernel from the current branch
# Retrieve recent R binary from CRAN
RUN apt-get update -qq 
RUN apt-get install -y --force-yes --no-install-recommends \
        libzmq4-dev r-base r-base-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*


# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site

# Install IRkernel
RUN Rscript -e "install.packages(c('igraph', 'rzmq','repr','IRkernel','IRdisplay'), repos = c('http://irkernel.github.io/', getOption('repos')))" -e "IRkernel::installspec(user=FALSE)"

USER main
