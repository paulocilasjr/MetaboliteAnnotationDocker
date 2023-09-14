#to run the interactive docker
#docker run -it -v ./:/media/ 21098a29e034 bash

FROM ubuntu:23.04

COPY . /media/

# Install Miniconda
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && apt-get install -y curl
RUN apt install -y build-essential
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.5.2-0-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
# add miniconda to environmental calls
ENV PATH="/root/miniconda/bin:${PATH}"

# install R
RUN conda install -y r-base=4.2.0

#download and install stringi
RUN apt-get install unzip
RUN wget https://github.com/gagolews/stringi/archive/master.zip -O stringi.zip
RUN unzip stringi.zip
RUN sed -i '/\/icu..\/data/d' stringi-master/.Rbuildignore
RUN R CMD build stringi-master
RUN Rscript media/resources/install_stringi.R

# install needed packages
RUN Rscript -e "install.packages('remotes', repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages('BiocManager', repos = getCRANmirrors()[1,'URL'])"
RUN Rscript -e "install.packages('Rcpp', repos = getCRANmirrors()[1,'URL'])"

RUN R CMD INSTALL media/resources/Rdisop_1.58.0.tar.gz
RUN R CMD INSTALL media/resources/ProtGenerics_1.30.0.tar.gz
RUN R CMD INSTALL media/resources/BiocGenerics_0.44.0.tar.gz
RUN R CMD INSTALL media/resources/S4Vectors_0.36.2.tar.gz 

RUN Rscript -e "install.packages(c('futile.logger', 'snow', 'codetools', 'BH', 'cpp11'), repos = getCRANmirrors()[1,'URL'])"
RUN R CMD INSTALL media/resources/BiocParallel_1.32.6.tar.gz

RUN Rscript -e "install.packages(c('bookdown', 'knitr', 'rmarkdown', 'yaml'), repos = getCRANmirrors()[1,'URL'])"
RUN R CMD INSTALL media/resources/BiocStyle_2.26.0.tar.gz 

RUN Rscript -e "install.packages(c('circlize', 'GetoptLong', 'colorspace', 'clue', 'RColorBrewer', 'GlobalOptions', 'png', 'digest', 'matrixStats', 'foreach', 'doParallel'), repos = getCRANmirrors()[1,'URL'])"
RUN R CMD INSTALL media/resources/IRanges_2.32.0.tar.gz
RUN R CMD INSTALL media/resources/ComplexHeatmap_2.14.0.tar.gz

RUN Rscript -e "install.packages(c('Matrix', 'plyr', 'lattice', 'ggplot2', 'scales', 'MASS', 'RCurl', 'httr', 'plotly'), repos = getCRANmirrors()[1,'URL'])"

RUN conda install -c r -y r-xml

RUN R CMD INSTALL media/resources/Biobase_2.58.0.tar.gz
RUN R CMD INSTALL media/resources/MatrixGenerics_1.10.0.tar.gz
RUN R CMD INSTALL media/resources/MsCoreUtils_1.10.0.tar.gz
RUN R CMD INSTALL media/resources/zlibbioc_1.44.0.tar.gz
RUN R CMD INSTALL media/resources/XVector_0.38.0.tar.gz
RUN R CMD INSTALL media/resources/GenomeInfoDbData_1.2.10.tar.gz
RUN R CMD INSTALL media/resources/GenomeInfoDb_1.34.9.tar.gz
RUN R CMD INSTALL media/resources/GenomicRanges_1.50.2.tar.gz
RUN R CMD INSTALL media/resources/DelayedArray_0.24.0.tar.gz
RUN R CMD INSTALL media/resources/SummarizedExperiment_1.28.0.tar.gz
RUN R CMD INSTALL media/resources/pcaMethods_1.90.0.tar.gz
RUN R CMD INSTALL media/resources/impute_1.72.3.tar.gz
RUN R CMD INSTALL media/resources/preprocessCore_1.60.2.tar.gz
RUN R CMD INSTALL media/resources/affyio_1.68.0.tar.gz
RUN R CMD INSTALL media/resources/affy_1.76.0.tar.gz
RUN R CMD INSTALL media/resources/limma_3.54.2.tar.gz
RUN R CMD INSTALL media/resources/vsn_3.66.0.tar.gz
RUN R CMD INSTALL media/resources/mzID_1.36.0.tar.gz

RUN conda install -c conda-forge -y netcdf4
RUN Rscript -e "install.packages(c('MALDIquant'), repos = getCRANmirrors()[1,'URL'])"
RUN R CMD INSTALL media/resources/ncdf4_1.13.tar.gz
RUN R CMD INSTALL media/resources/Rhdf5lib_1.20.0.tar.gz
RUN R CMD INSTALL media/resources/mzR_2.32.0.tar.gz
RUN R CMD INSTALL media/resources/MSnbase_2.24.2.tar.gz

RUN Rscript -e "remotes::install_gitlab('jaspershen/masstools')"


#the next one takes a loooong time
RUN Rscript media/resources/install_metid.R


