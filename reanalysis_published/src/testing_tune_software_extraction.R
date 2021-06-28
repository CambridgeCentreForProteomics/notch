library(curl)
library(rawDiag)
library(tidyverse)
options(timeout=10000) # allow long downloads

# these three lines can be easily extracted from a query to proteomeXchange
pride_accession <- 'PXD011254' # LOPIT-DC
year <- '2019'
month <- '01'

# This appears to be standard address for all pride data
# e.g "ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2019/01/PXD011254"
url_base = "ftp://ftp.pride.ebi.ac.uk/pride/data/archive"
url <- file.path(url_base, year, month, pride_accession)

# parse the files for the accession
h = new_handle(dirlistonly=TRUE)
h <- new_handle()
con = curl(paste0(url, '/'), "r", h)
tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
close(con)
head(tbl)

# identify the smaller .raw file
top_file <- tbl %>% filter(grepl('.raw$', V9)) %>% arrange(V5) %>% pull(V9) %>% head(1)

# Download the file
x <- file.path(url, top_file)
download.file(x, '.temp.raw')

# Read the metadata
rawfile <- file.path('.temp.raw')
info <- read.raw.info(rawfile)
info$`Software version`

info$PRIDE <- pride_accession

rbind(info, info)
