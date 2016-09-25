#0. Load the Data in RStudio
#Save the data set as a CSV file called refine_original.csv and load it in RStudio into a data frame.

refine_original <- read.csv("C:/Users/CSI User 1201/Desktop/SpringboardData Science Project Course/refine_original.csv")
View(refine_original)
data.frame(refine_original)
summary(refine_original)

#1. Clean up brand names
#Company column
refine_original$company

#Standardize miss spelling brand names within the 'Company' column
#this function gets a company name (s) and retuns the correct company name, one of these: philips, akzo, van houten and unilever

clean_company <- function(s){
  s <- tolower(s)
  n <- nchar(s)
  first_2 <- substr(s,1,2)
  last_2 <- substr(s,n-1,n)
  
  if(last_2 == 'ps'){
    return('phillips')
    
  }else if(first_2 == 'ak'){
    return('akzo')
    
  }else if(first_2 == 'va'){
    return('van houten')
  }else{
    return('unilever')
  }
}
#test
clean_company(refine_original$company[1])
clean_company(refine_original$company[25])
clean_company(refine_original$company[9])
clean_company(refine_original$company[22])
clean_company(refine_original$company[21])

#2. Separate product code and number
#Separate the product code and product number into separate columns i.e. add two new columns 
#called product_code and product_number, containing the product code and number respectively
refine_original$Product.code...number <- as.character(refine_original$Product.code...number)
product_code_number_split <- strsplit(refine_original$Product.code...number, split = "-")
select_el <- function(x, index) {x[index]}
product_code <- lapply(product_code_number_split, select_el, index = 1) 
product_number <- lapply(product_code_number_split, select_el, index = 2) 
refine_original$product_code <- as.character(product_code)
refine_original$product_number <- as.numeric(product_number)
refine_original$Product.code...number <- NULL

#3. Add product categories
#Observe the following product categories: 
#p = Smartphone v = TV x = Laptop q = Tablet In order to make the data more readable, 
#add a column with the product category for each record.
y <- refine_original$product_code
x <- c("Smartphone", "TV", "Laptop", "Tablet")
refine_original$product_category <- ifelse(y == "p", x[1], ifelse(y == "v", x[2], ifelse(y == "x", x[3], ifelse(y == "q", x[4], NA))))
#test
names(refine_original)
tail(refine_original)


#4. Add full address for geocoding
# Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.
full_address <- c(refine_original$address, refine_original$city, refine_original$country)

#5. Create dummy variables for company and product category
company_philips <- as.numeric(refine_original$company == "philips")
company_akzo <- as.numeric(refine_original$company == "akzo")
company_van_houten <- as.numeric(refine_original$company == "van houten")
company_unilever <- as.numeric(refine_original$company == "unilever")
product_smartphone <- as.numeric(refine_original$product_category == "Smartphone")
product_tv <- as.numeric(refine_original$product_category == "TV")
product_laptop <- as.numeric(refine_original$product_category == "Laptop")
product_tablet <- as.numeric(refine_original$product_category == "Tablet")

#test
names(refine_original)

#6. Submit the project on Github
# Include your code, the original data as a CSV file refine_original.csv, and the cleaned up data as a CSV file called refine_clean.
refine_clean <- refine_original
print(refine_clean)
write.csv(refine_clean, "refine_clean.csv")
