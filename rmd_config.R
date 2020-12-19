library(tidyverse)
library(here)

# get name of file during knitting and strip file extension
rmd_filename <- str_remove(knitr::current_input(), "\\.Rmd")

# Figure path on disk = base.dir + fig.path
# Figure URL online = base.url + fig.path
knitr::opts_knit$set(base.dir = str_c(here::here(),'/'), base.url= '/') # project root folder
knitr::opts_chunk$set(fig.path = str_c("rmd_images/", rmd_filename, '/'),echo=TRUE)
