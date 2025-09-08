
# load packages
library(OmnipathR)
library(dplyr)

# -------------------------------------------------------------------------------

# load the prior knowledge interactions, composed by kinase-target relationships
uniprot_kinases <- OmnipathR::annotations(resources = "UniProt_keyword") %>%
  dplyr::filter(value == "Kinase" & !grepl("COMPLEX", uniprot)) %>%
  distinct() %>%
  pull(genesymbol) %>%
  unique()

# OmnipathR providers have changed the function form "get_signed_ptms" to "signed_ptms"
omnipath_ptm <- OmnipathR::signed_ptms() %>%
  dplyr::filter(modification %in% c("dephosphorylation","phosphorylation")) %>%
  dplyr::filter(!(stringr::str_detect(sources, "ProtMapper") & n_resources == 1)) %>%
  dplyr::mutate(p_site = paste0(substrate_genesymbol, "_", residue_type, residue_offset),
                mor = ifelse(modification == "phosphorylation", 1, -1)) %>%
  dplyr::transmute(p_site, enzyme_genesymbol, mor) %>%
  dplyr::filter(enzyme_genesymbol %in% uniprot_kinases)


omnipath_ptm$likelihood <- 1

# remove ambiguous modes of regulations
omnipath_ptm$id <- paste(omnipath_ptm$p_site,omnipath_ptm$enzyme_genesymbol, sep ="")
omnipath_ptm <- omnipath_ptm[!duplicated(omnipath_ptm$id),]
omnipath_ptm <- omnipath_ptm[,-5]

# -------------------------------------------------------------------------------

# save kinase-sbstrate network as csv
names(omnipath_ptm)[c(1:3)] <- c("target", "source", "weight")
write.csv(omnipath_ptm, 
          "../data/omnipath_ptm.csv", 
          row.names = FALSE)

# -------------------------------------------------------------------------------
