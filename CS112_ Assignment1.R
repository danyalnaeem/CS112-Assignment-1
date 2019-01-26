foo <- read.csv("https://tinyurl.com/yb4phxx8") # read in the data
for(i in date.columns)  # this "for loop" loops through the "date.columns".
  
{
  
  # identify which values are missing in the "i"th column of the foo data set
which_values_are_missing <- which(as.character(foo[, i]) == "")
  
  # those values that are missing (blank) in the "i"th column are replaced by <NA>
  # because R knows how to handle "NA" -- NA means something special in R--blanks are handled 
  # more unpredictably (which is bad).
foo[which_values_are_missing, i] <- NA
  
  # last step--replace each of these columns (which is structured as a column of "factor" values)
  # as a column of dates--i.e., convert them to an object of "class" = Date. They are dates, after all.
  # And if you convert them to the Date class, R will know they are dates and you can manipulate 
  # dates in a simple, straightforward way. Otherwise, you won't be able to easily manipulate them
  # arithmetically.  E.g., for simple Date operations, see lines 48-58 below...
  # **By the way, if you don't understand what a "factor" is in R, you should Google it.** 
foo[, i] <- as.Date(as.character(foo[, i]))
  
}
which.have.NAs <- which(is.na(foo$CirculationDate == TRUE)) #this identifies which rows in CirculationDate are NA
new_foo <- foo[-which.have.NAs, ] #Eliminates the rows with NA in CirculationDate
x <- (which(new_foo$CirculationDate >= '2008-01-01')) #identifies which rows in CirculationDate are greater than equal to 2008-01-01
over_Jan1<- new_foo[x,] #Includes circulation date greater or equal to Jan 1,2008 only

#Question 1a
duration <- over_Jan1$OriginalCompletionDate - over_Jan1$ApprovalDate #calculates the purpoted duration 
mean(duration, na.rm=TRUE) #calculates mean for purpoted duration and sets NA = TRUE so that it is not included in calculation 
median(duration, na.rm=TRUE)#calculates median for purpoted duration and sets NA = TRUE so that it is not included in the calculation
Q1<- quantile(duration, 0.25, na.rm=TRUE) #calculates 25th percentile for purpoted duration and sets NA = TRUE so that it is not included  
Q3<- quantile(duration, 0.75, na.rm= TRUE)#calculates 75th percentile for purpoted duration and sets NA = TRUE so that it is not included
IQR<- Q3-Q1 #calculates interquartile range by subtracting 25th percentile from 75th
IQR
hist(as.numeric(((duration)/365)*12), xlab = "Purpoted Duration (in months)") #generates a histogram for the duration

#Question 1b
#Lines 36 to 42 do the same thing as in lines 28 to 34 except that this mean, median and IQR is for the actual duration
actual_duration <- over_Jan1$RevisedCompletionDate - over_Jan1$ApprovalDate
mean(actual_duration)
median(actual_duration)
Q1<- quantile(actual_duration, 0.25, na.rm=TRUE)
Q3<- quantile(actu1al_duration,0.75,na.rm = TRUE)
IQR_actual <-Q3-Q1
IQR_actual
hist(as.numeric(((actual_duration)/365)*12), xlab = "Actual Duration (in months)") #generates a histogram for the duration

#Question 2
which.have.NAs <- which(is.na(over_Jan1$Rating == TRUE)) #this identifies rows that have NA in the rating column
new_ratings <- over_Jan1[-which.have.NAs, ] #eliminates rows with NA in Rating column
rating0<- new_ratings[ which(new_ratings$Rating=='0'),] #identifies the rows with rating = 0
rating1<- new_ratings[ which(new_ratings$Rating=='1'),] #identifies the rows with rating = 1
rating2<- new_ratings[ which(new_ratings$Rating=='2'),] #identifies the rows with rating = 2
rating3<- new_ratings[ which(new_ratings$Rating=='3'),] #identifies the rows with rating = 3
#Lines 51 to 54 calulate the percentage of each of the ratings 
ratingzero<- nrow(rating0)/nrow(new_ratings) *100
ratingone<- nrow(rating1)/nrow(new_ratings) *100
ratingtwo<- nrow(rating2)/nrow(new_ratings) *100
ratingthree<- nrow(rating3)/nrow(new_ratings) *100
print(ratingzero) 
print(ratingone)
print(ratingtwo)
print(ratingthree)

#Question 3
which.have.PPTAs <- which(over_Jan1$Type== "PPTA")#this identifies which projects have the type = PPTA
no_PPTA <- over_Jan1[-which.have.PPTAs, ] #Eliminates projects with type = PPTA
rating0<- no_PPTA[ which(no_PPTA$Rating=='0'),] #identifies the rows with rating = 0
rating1<- no_PPTA[ which(no_PPTA$Rating=='1'),] #identifies the rows with rating = 1
rating2<- no_PPTA[ which(no_PPTA$Rating=='2'),]#identifies the rows with rating = 2
rating3<- no_PPTA[ which(no_PPTA$Rating=='3'),]#identifies the rows with rating = 3
#Lines 67 to 70 calulate the percentage of each of the ratings 
ratingzero<- nrow(rating0)/nrow(no_PPTA) *100
ratingone<- nrow(rating1)/nrow(no_PPTA) *100
ratingtwo<- nrow(rating2)/nrow(no_PPTA) *100
ratingthree<- nrow(rating3)/nrow(no_PPTA) *100
print(ratingzero) 
print(ratingone)
print(ratingtwo)
print(ratingthree)

#Question4
sorted <- over_Jan1[order(over_Jan1$RevisedAmount),] #Sorts the data in ascending order based on the RevisedAmount
bottom25_<-sorted[1:(0.25*nrow(sorted)),] #Filters out the least 25 amount of budgets 
top25_ <- sorted[(nrow(sorted)-(0.75*nrow(sorted))):(nrow(sorted)),] #Filters out the top 25 amount of budgets
mean(bottom25_$Rating, na.rm=TRUE)
mean(top25_$Rating, na.rm= TRUE)

