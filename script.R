require(rJava)
require(NLP)
require(openNLP)
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")


dat <- readRDS("data.rds") #Patients
tm  <- readRDS("tm.rds") #Symptom matrix

allergy_indices <- grep("allerg", colnames(tm)) #Which columns are related to allergies
test <- tm[,allergy_indices, drop = FALSE] #Load symptom matrix, where columns are related to allergies, into 'test'

temp <- rowSums(test) > 0 #Does a patient have allergies as at least one of their symptoms
patients <- dat[temp,] #Load patients, that have allergies as at least one of their symptoms, into 'patients'
allergies <- test[temp, , drop = FALSE] #Load allergy matrix, where a patient has allergies as at least one of their symptoms, into 'allergies'
rm(dat)

patients[,'product'] #All products that caused symptoms for patients with allergic reactions

product_counts <- table(patients$product) #Frequency of products
unique_products <- data.frame(Product = names(product_counts), Frequency = as.vector(product_counts)) #Add frequency of products to the data frame
unique_products <- unique_products[order(-unique_products$Frequency),] #Order the products (descending) by their frequency
top_10_products <- head(unique_products, 10) #Get top 10 most frequent products
top_10_products 

library(openNLP)
require(rJava)
require(NLP)
require(openNLP)

#all_words <- unlist(strsplit(patients[,'product'], "\\s+")) #Split each sentence in 'product' column into individual words
all_words <- unlist(strsplit(patients[,'product'], ","))
all_words
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
a2 <- annotate(all_words, list(sent_token_annotator, word_token_annotator)) 
pos_tag_annotator <- Maxent_POS_Tag_Annotator()
tagged_words <- annotate(all_words, pos_tag_annotator, a2)
nouns <- " "
for(i in 13:length(tagged_words)){
  if(as.String(tagged_words$features[[i]]) == "NN")
    nouns[i] <- all_words[i]
}
nouns<-na.omit(nouns)
word_counts <- table(nouns) #Count the frequency of each word
unique_words <- data.frame(Word = names(word_counts), Frequency = as.vector(word_counts)) #Create a data frame with the word and its frequency
unique_words <- unique_words[order(-unique_words$Frequency),] #Order the words (descending) by their frequency
top_20_words <- head(unique_words, 20) #Get top 10 most frequent words
top_20_words



matching_rows <- word_counts[word_counts == 'exemption 4']
word_counts
# Extract the ages for those rows
matching_ages <- patients[matching_rows, "age"]
matching_ages
# Calculate the average age
average_age <- mean(matching_ages)



industry_counts <- table(patients$industry) #Frequency of industries
unique_industries <- data.frame(industry = names(industry_counts), Frequency = as.vector(industry_counts)) #Add frequency of industries to the data frame
unique_industries <- unique_industries[order(-unique_industries$Frequency),] #Order the industries (descending) by their frequency
top_10_industries <- head(unique_industries, 10) #Get top 10 most frequent industries
top_10_industries 


max_age <- max(patients$age, na.rm = TRUE) #Get highest age in patients data frame (excluding NA)
age_groups <- cut(patients$age, breaks = seq(0, max_age, by = 10), right = FALSE) #Group ages into ranges by 10 from 0 to max_age
age_counts <- table(age_groups) #Count number of allergic symptons for each age group
age_counts <- sort(age_counts, decreasing = TRUE) 
head(age_counts, 3) #Print the three most common age groups for allergic reactions



# Get row names from patients
exclude_rows <- rownames(patients)

# Subset tm to exclude rows in exclude_rows
tm_subset <- tm[!rownames(tm) %in% exclude_rows, ]

# Get column names with highest colsum values
colsums <- colSums(tm_subset)
top_cols <- names(sort(colsums, decreasing = TRUE)[1:5])
top_cols



tm2 <- tm[ , ]
length(tm2)
head(tm2)
head(rownames(patients))
colsum <- colSums(tm2, na.rm = TRUE)  #calculation of colsums
colsum_ordered <- sort(colsum, decreasing = TRUE)  #Order column sums (descending order)
head(colsum_ordered)





test[1,0]
rownames(allergies)
