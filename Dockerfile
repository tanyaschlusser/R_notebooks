FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Installs Jupyter Notebook and IRkernel kernel from the current branch
# Retrieve recent R binary from CRAN

# Needs zeromq -- couldn't get it even though jessie is supposed to
# have it... use:  http://askubuntu.com/questions/365074/
RUN apt-get install software-properties-common python-software-properties
RUN add-apt-repository ppa:chris-lea/zeromq
RUN apt-get update --q
RUN apt-get install libzmq3 libzmq3-dev libzmq3-dbg
RUN apt-get install -y r-base r-base-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set default CRAN repo
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/lib/R/etc/Rprofile.site

# Install IRkernel
RUN Rscript -e "install.packages(c('igraph', 'rzmq','repr','IRkernel','IRdisplay'), repos = c('http://irkernel.github.io/', getOption('repos')))" -e "IRkernel::installspec(user=FALSE)"

USER main
