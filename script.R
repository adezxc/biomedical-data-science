
Sys.setlocale("LC_ALL", "C")

dat <- readRDS("data.rds")
tm  <- readRDS("tm.rds")

allergy_indices <- grep("allerg", colnames(tm))
test <- tm[,allergy_indices]

temp <- rowSums(test) > 0
patients <- dat[temp,]
allergies <- test[temp,]
rm(dat)
rm(tm)
