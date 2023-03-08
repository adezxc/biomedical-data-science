
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")


dat <- readRDS("data.rds") #Patients
tm  <- readRDS("tm.rds") #Symptom matrix

allergy_indices <- grep("allerg", colnames(tm)) #Which columns are related to allergies
test <- tm[,allergy_indices, drop = FALSE] #Load symptom matrix, where columns are related to allergies, into 'test'

temp <- rowSums(test) > 0 #Does a patient have allergies as at least one of their symptoms
patients <- dat[temp,] #Load patients, that have allergies as at least one of their symptoms, into 'patients'
allergies <- test[temp, , drop = FALSE] #Load allergy matrix, where a patient has allergies as at least one of their symptoms, into 'allergies'
rm(dat)
rm(tm)

patients[,'product'] #All products that caused symptoms for patients with allergic reactions

product_counts <- table(patients$product) #Frequency of products
unique_products <- data.frame(Product = names(product_counts), Frequency = as.vector(product_counts)) #Add frequency of products to the data frame
unique_products <- unique_products[order(-unique_products$Frequency),] #Order the products (descending) by their frequency
top_10_products <- head(unique_products, 10) #Get top 10 most frequent products
top_10_products 

library(openNLP)

all_words <- unlist(strsplit(patients[,'product'], "\\s+")) #Split each sentence in 'product' column into individual words
tagged_words <- pos_tag(all_words) #Assigning a type to each word
nouns <- all_words[tagged_words$pos == "NN"] #Selecting only nouns

word_counts <- table(nouns) #Count the frequency of each word
unique_words <- data.frame(Word = names(word_counts), Frequency = as.vector(word_counts)) #Create a data frame with the word and its frequency
unique_words <- unique_words[order(-unique_words$Frequency),] #Order the words (descending) by their frequency
top_20_words <- head(unique_words, 20) #Get top 10 most frequent words
top_20_words 


industry_counts <- table(patients$industry) #Frequency of industries
unique_industries <- data.frame(industry = names(industry_counts), Frequency = as.vector(industry_counts)) #Add frequency of industries to the data frame
unique_industries <- unique_industries[order(-unique_industries$Frequency),] #Order the industries (descending) by their frequency
top_10_industries <- head(unique_industries, 10) #Get top 10 most frequent industries
top_10_industries 


test[1,0]
rownames(allergies)
