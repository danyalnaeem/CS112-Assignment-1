foo <- read.csv("https://tinyurl.com/yb4phxx8") # read in the data
for(i in date.columns)  # this "for loop" only loops through the "date.columns" -- no other columns.
  
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
which.have.NAs <- which(is.na(foo$CirculationDate == TRUE))
new_foo <- foo[-which.have.NAs, ]
x <- (which(new_foo$CirculationDate >= '2008-01-01'))
over_Jan1<- new_foo[x,]
over_Jan1
duration <- over_Jan1$OriginalCompletionDate - over_Jan1$ApprovalDate
mean(duration, na.rm=TRUE)
median(duration, na.rm=TRUE)
