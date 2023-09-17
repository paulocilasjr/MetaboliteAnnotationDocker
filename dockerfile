#to run the interactive docker
#docker run -it -v ./:/media/ 21098a29e034 bash

# Docker inheritance
FROM rocker/r-base:4.2.0

# Install Miniconda
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && apt-get install -y curl
RUN apt install -y build-essential
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.5.2-0-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
# add miniconda to environmental calls
ENV PATH="/root/miniconda/bin:${PATH}"

# install needed packages
RUN Rscript -e "install.packages('remotes', repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages('BiocManager', repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages('Rcpp', repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages(c('futile.logger', 'snow', 'codetools', 'BH', 'cpp11'), repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages(c('bookdown', 'knitr', 'rmarkdown', 'yaml'), repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages(c('circlize', 'GetoptLong', 'colorspace', 'clue', 'RColorBrewer', 'GlobalOptions', 'png', 'digest', 'matrixStats', 'foreach', 'doParallel'), repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages(c('stringi','Matrix', 'plyr', 'lattice', 'ggplot2', 'scales', 'MASS', 'RCurl', 'httr', 'plotly'), repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages(c('MALDIquant'), repos = getCRANmirrors()[1,'URL'])"

RUN apt-get update
    RUN R -e 'BiocManager::install(ask = F)' && R -e 'BiocManager::install(c("Rdisop", \
    "ProtGenerics", "BiocGenerics", "S4Vectors", "BiocParallel", "BiocStyle", \
    "IRanges", "ComplexHeatmap", "Biobase", "MatrixGenerics", "MsCoreUtils", \
    "zlibbioc", "XVector", "GenomeInfoDbData", "GenomeInfoDb", \
    "GenomicRanges", "DelayedArray", "SummarizedExperiment", "pcaMethods", "impute", \
    "preprocessCore", "affyio", "affy", "limma", "vsn", "mzID", "ncdf4", "Rhdf5lib", \
    "mzR", "MSnbase",  ask = F))'

RUN Rscript -e "remotes::install_gitlab('jaspershen/masstools')"
RUN Rscript -e "remotes::install_gitlab('tidymass/metid')"