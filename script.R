
Sys.setlocale("LC_ALL", "C")

dat <- readRDS("data.rds") #Patients
tm  <- readRDS("tm.rds") #Symptom matrix

allergy_indices <- grep("allerg", colnames(tm)) #Which columns are related to allergies
test <- tm[,allergy_indices, drop = FALSE] #Load symptom matrix, where columns are related to allergies, into 'test'

temp <- rowSums(test) > 0 #Does a patient have allergies as at least one of their symptoms
patients <- dat[temp,] #Load patients, that have allergies as at least one of their symptoms, into 'patients'
allergies <- test[temp, , drop = FALSE] #Load allergy matrix, where a patient has allergies as at least one of their symptoms, into 'allergies'
rm(dat)
rm(tm)
allergies["528",]

test[1,0]
rownames(allergies)
