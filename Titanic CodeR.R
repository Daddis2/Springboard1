#Save the data set as a CSV file called titanic_original.csv and load it in RStudio into a data frame.

#0. Load the data in RStudio

data.frame(titanic_original)

#1. Port of embarkation

# The embarked column has some missing value. Find the missing values and replace them with S.

summary(titanic_original)
titanic_original$embarked[titanic_original$embarked == ""] <- "S"

#Test
summary(titanic_original$embarked)

#2. Age

# Values in the Age column are missing. Use the the mean or median to calculate the mean of the Age column and use that value
# to populate the missing values

mean(titanic_original$age, na.rm = TRUE)
median(titanic_original$age, na.rm = TRUE)

#Test
str(titanic_original$age)

#Other ways to populate the missing values in the age column.

sum(is.na(titanic_original$age))
is.na(titanic_original$age)

#I prefer the sum(is.na(titanic_original$age)) because it shortens the view
#and just gives you the total number of missing values of NA's.

#3. Lifeboat
# There are distribution of passengers in different lifeboats.
# However, there are a lot of missing values in the "boat" column.
# Fill or replace these empty slots with a dummy value e.g. a string 'None" or 'NA'

titanic_original$boat[titanic_original$boat == ""] <- NA
is.na(titanic_original$boat)
any(is.na(titanic_original$boat))

#print

titanic_original$boat
sum(is.na(titanic_original$boat))

# 4. Cabin

# What does a missing value here mean?

# Missing value could means: People didn’t have a specific cabin as tickets were cheap and many people stayed in a big lobby and
# possibly it didn’t have a speicifc number or the data is simply missing.


# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

mapper <- function(x) { 
  if(is.null(x)) return(1)
  return(0)
}

titanic_original$has_cabin_number <- sapply(titanic_original$cabin, mapper)

str(titanic_original)

write.csv(titanic_original, "c:\\Users\\CSI User 1201\\Desktop\\titanic_original.csv, row.names = FALSE")
