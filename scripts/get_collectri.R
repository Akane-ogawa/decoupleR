
# load packages
library(OmnipathR)
library(dplyr)
library(decoupleR)

# -------------------------------------------------------------------------------

# decoupleR
net <- decoupleR::get_collectri(organism = 'human', 
                                split_complexes = FALSE)

# -------------------------------------------------------------------------------

# save TF-gene network as csv
names(net)[c(1:3)] <- c("source", "target", "weight")
write.csv(net, 
          "../data/collectri.csv",
          row.names = FALSE)

# -------------------------------------------------------------------------------
