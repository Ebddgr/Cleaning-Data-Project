library(tidyverse)
#Create Data frame from test folder
test_files <- list.files("UCI HAR Dataset/test",recursive = T,full.names = T)
test_data <- lapply(test_files,read_tsv) %>% bind_cols()

##change the column names
names(test_data) <- str_remove_all(test_files,".*[/]|.txt")

