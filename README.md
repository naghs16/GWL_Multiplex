# GWL_Multiplex
This repository contains the source codes to reproduce results from the methodology presented in the recent study by Naghipour et al. (2022). The codes are written in a R evironment by utilizing several packages.

Please contact Naghipour.l@tabrizu.ac.ir, for any question/suggestion.

If you use the codes, please cite the following paper:

Naghipour L., Aalami M.T., Nourani V. and Huang J.J. (2022) Collective dynamics analysis by multiplex network to unravel the backbone of fluctuations in the groundwater level. Under review in computers and geosciences.

# Computer Requirements
Intel® Pentium® CPU G2030 @ 3.00GHz 3GHz with 2 GByte RAM and 128 GByte Hardware (around 4 GByte of the Hardware will be used)

# Setup Instructions
If you already have a R environment, you could ignore this part and continue with explanations of the next part. Otherwise, install R according to your operating system. Microsoft R Open is the enhanced distribution of R from Microsoft Corporation, and this distribution is highly recommended.  

## Prerequisites
In the folowing, all instructions are tested based on R 4.1.0 with Ubuntu desktop operating system (Windows 7 works as well). 

The source codes need several libraries, including rEDM, igraph, brainGraph.

```{r}
# install the libraries
install.packages(c('rEDM','igraph','brainGraph'))
```

Note that there is a regular update for the library rEDM, while the source code CCM.R is implemented based on an older version of this library. Please follow the instruction released by the Sugihara Lab to be sure that an implementation of 'EDM' algorithms is based on the last version. 


