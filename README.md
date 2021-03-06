# GWL_Multiplex
This repository contains the source codes to reproduce the results from the proposed approach presented in recent study by Naghipour et al. (2022). The codes are written in a R environment by using several libraries.

For any question/suggestion about the codes/approach, please contact naghipour [dot] l [at] tabrizu [dot] ac [dot] ir.

If you use the codes, please cite the following paper:

Naghipour L., Aalami M.T., Nourani V. and Huang J.J. (2022) Collective dynamics analysis by multiplex network to unravel the backbone of fluctuations in the groundwater level. Under review in computers and geosciences.

# Computer Requirements
Intel® Pentium® CPU G2030 @ 3.00GHz 3GHz with 2 GByte RAM and 128 GByte Hardware (the analysis is used around 5 GByte of the Hardware)

# Setup Instructions
If you already have a R environment, you could ignore this part and continue with explanations of the next part. Otherwise, you should install R based on your operating system (i.e. Windows etc). Microsoft R Open is the enhanced distribution of R from Microsoft Corporation, and this distribution is highly recommended by the scientists.  

## Prerequisites
In the folowing, all instructions are tested based on R 4.0.2 with Ubuntu desktop operating system (Windows 7 works as well). 

The source codes need several libraries, including rEDM, igraph, brainGraph.

```{r}
# install the libraries
install.packages(c('rEDM','igraph','brainGraph'))
```

Note that there is a regular update for the library rEDM, while the source code CCM_GWL.R is operated based on an old version of this library. Please follow the instruction released by the Sugihara Lab to be sure that an implementation of 'EDM' algorithms is based on the latest version. 

# Run the Codes
The modeling procedure consists of four steps. At first, the CCM method is used to infer causal relationships for all possible pairs of interactions among the nodes by running Rscript CCM_GWL.R with three arguments, group (I, II, III, IV), layer.name (MON) and layer.types (FOR, INV) as,

```{r}
Rscript CCM_GWL.R I MON FOR
```

Then, the values of z-score are obtained according to the surrogates data-sets for the MON and MUX dynamics by Rscript ZScore_MON.R and ZScore_MUX.R, respectively. 

In ZScore_MON.R, the defined arguments are group (I, II, III, IV), layer.name (MON) and layer.types (FOR) as,

```{r}
Rscript ZScore_MON.R I MON FOR
```

In ZScore_MUX.R, the defined arguments are group (I, II, III, IV), layer.name (MON), layer.types (INV) and z (1, 2, 3, 4, 5) as,

```{r}
Rscript ZScore_MUX.R I MON INV 1
```
In the next step, the networks are constructed from Rscript Graph.R using the adjacency matrices obtained by threshording the z-score between each pair of the nodes.

In Graph.R, the defined arguments are group (I, II, III, IV), layer.name (MON), layer.type (FOR, INV, MUX) and z (1, 2, 3, 4, 5) as,

```{r}
Rscript Graph.R I MON FOR 1
```

Finally, the connections of the networks are characterized in local and global scales by Local-Measures.R and Global-Measures.R, respectively.

In Local-Measures.R and Global-Measures.R, the defined arguments are group (I, II, III, IV), layer.name (MON), layer.type (FOR, INV, MUX) and z (1, 2, 3, 4, 5) as,

```{r}
Rscript Local-Measures.R I MON FOR 1
Rscript Global-Measures.R I MON FOR 1
```
