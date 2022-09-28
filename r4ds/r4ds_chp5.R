#r4ds chapter 5
#data transformation
library(nycflights13)
library(tidyverse)
# conflicts with base package
# If you want to use the base version of these functions after loading dplyr, 
# you’ll need to use their full names: stats::filter() and stats::lag().
flights
#filter rows with filter
#select all flights on January 1st with
filter(flights, month == 1, day == 1)
#if you want to save the result, you’ll need to use the assignment operator, <-:
jan1 <- filter(flights, month == 1, day == 1)
#R either prints out the results, or saves them to a variable. 
#If you want to do both, you can wrap the assignment in parentheses:
(dec25 <- filter(flights, month == 12, day == 25))
#the easiest mistake to make is to use = instead of == when testing for equality.
#There’s another common problem you might encounter when using ==: floating point numbers.
#Instead of relying on ==, use near()
near(1 / 49 * 49, 1)
#boolean operators
#& is and,| is or, and ! is not
#The following code finds all flights that departed in November or December:
filter(flights, month == 11 | month == 12)
#The order of operations doesn’t work like English
#A useful short-hand for this problem is x %in% y
#This will select every row where x is one of the values in y
nov_dec <- filter(flights, month %in% c(11, 12))
#simplify complicated subsetting by remembering De Morgan’s law:
# !(x & y) is the same as !x | !y
# !(x | y) is the same as !x & !y
#if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours, 
#you could use either of the following two filters
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
#One important feature of R that can make comparison tricky are missing values,
#or NAs (“not availables”
#NA represents an unknown value so missing values are “contagious”: 
#almost any operation involving an unknown value will also be unknown.
#If you want to determine if a value is missing, use is.na():
#filter() only includes rows where the condition is TRUE; it excludes both FALSE and NA values
#If you want to preserve missing values, ask for them explicitly
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)
#
#
#Exercises
#Find all flights that...
#Had an arrival delay of two or more hours
arr_delay <- filter(flights, arr_delay >= 120)
view(flights)
#Flew to houston
Houston <- filter(flights, dest == "IAH" | dest == "HOU")
airlines
#Were operated by United, American, or Delta
(filter(flights, carrier %in% c("UA", "AA", "DL")))
#Departed in summer (July, August, and September)
filter(flights, month %in% 7:9)
#Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay > 120 & dep_delay <= 0)
#Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & dep_delay - arr_delay > 30)
#Departed between midnight and 6am (inclusive)
summary(flights$dep_time)
filter(flights, dep_time <= 600 | dep_time == 2400)
#dplyr filtering helper is between(). What does it do?
#This is a shortcut for x >= left & x <= right
#Can you use it to simplify the code needed to answer the previous challenges? yes
#How many flights have a missing dep_time? 
filter(flights, is.na(dep_time))
#What other variables are missing? What might these rows represent?
#These are all also missing arrival time and any delay info
#these might be missing flights, cancelled flights
#Why is NA ^ 0 not missing? 
NA ^ 0
#anything raised to 0 is 1
#Why is NA | TRUE not missing?
NA | TRUE
#it's saying anything or true, which is all inclusive
#Why is FALSE & NA not missing?
FALSE & NA
#it's saying anything and false, which is also all inclusive
#but in the other direction
#Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
#???
#
#
#Arrange rows with arrange()
#instead of selecting rows, it changes their order
arrange(flights, year, month, day)
#Use desc() to re-order by a column in descending order:
arrange(flights, desc(dep_delay))
#Missing values are always sorted at the end
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))
#exercises
#How could you use arrange() to sort all missing values to the start?
#(Hint: use is.na())
arrange(flights, desc(is.na(dep_time)), dep_time)        
#to put NA values first, we can add an indicator of whether the column has a missing value
#Then we sort by the missing indicator column and the column of interest. 
#Sort flights to find the most delayed flights. 
arrange(flights, desc(dep_delay))
#Find the flights that left earliest
arrange(flights, dep_delay)
#Sort flights to find the fastest (highest speed) flights
#shortest air time?
arrange(flights, air_time)
#Which flights travelled the farthest?
arrange(flights, desc(distance))
#Which travelled the shortest?
arrange(flights, distance)
#
#
#Select columns with select()
#select() allows you to rapidly zoom in on a useful subset
# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
#helper functions you can use within select()
#starts_with("abc"): matches names that begin with “abc”.
#ends_with("xyz"): matches names that end with “xyz”.
#contains("ijk"): matches names that contain “ijk”.
#matches("(.)\\1"): selects variables that match a regular expression
#This one matches any variables that contain repeated characters.
#num_range("x", 1:3): matches x1, x2 and x3
#See ?select for more details
#select() can be used to rename variables, but it’s rarely useful
#because it drops all of the variables not explicitly mentioned
#Instead, use rename(), which is a variant of select() that keeps all
#the variables that aren’t explicitly mentioned
rename(flights, tail_num = tailnum)
#use select() in conjunction with the everything() helper
#useful if you have a handful of variables you’d like to move to the start of the data frame
select(flights, time_hour, air_time, everything())
#
#exercises
#Brainstorm as many ways as possible to select
#dep_time, dep_delay, arr_time, and arr_delay from flights
#just select the columns with the variable names
select(flights, dep_time, dep_delay, arr_time, arr_delay)
#select using strings
select(flights, "dep_time", "dep_delay", "arr_time", "arr_delay")
#specify column numbers
select(flights, 4, 6, 7, 9)
#Specify the names of the variables with character vector and any_of() or all_of()
select(flights, all_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))
select(flights, any_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))
#Selecting the variables by matching the start of their names using starts_with()
select(flights, starts_with("dep_"), starts_with("arr_"))
#Selecting the variables using regular expressions with matches()
select(flights, matches("^(dep|arr)_(time|delay)$"))
#Specify the names of the variables with a character vector 
#and use the bang-bang operator (!!).
variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
select(flights, !!variables)
#others included onlinebut not taught in r4ds, skipped including here
#What happens if you include the name of a variable multiple times in a select() call?
select(flights, dep_time, dep_time)
#doesn't seem to do anything
#What does the any_of() function do? 
#Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
#any_of() doesn't check for missing variables. It is especially useful with negative selections,
#when you would like to make sure a variable is removed.
#not sure how it owuld be helpful with the vector
#Does the result of running the following code surprise you? 
select(flights, contains("TIME"))
#How do the select helpers deal with case by default? How can you change that default?
#it ignores case, not typical for R
#you can change this
select(flights, contains("TIME", ignore.case = FALSE))
#
#
#Add new variables with mutate()
#add new columns that are functions of existing columns
#mutate() always adds new columns at the end of your dataset 
#make a more narrow dataset
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)
#Note that you can refer to columns that you’ve just created
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)
#If you only want to keep the new variables, use transmute()
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)
#many functions for creating new variables that you can use with mutate()
#the function must be vectorised
#it must take a vector of values as input, 
#return a vector with the same number of values as output
#here are some
#Arithmetic operators: +, -, *, /, ^
#If one parameter is shorter than the other,
#it will be automatically extended to be the same length
#Modular arithmetic: %/% (integer division) and %% (remainder), 
#where x == y * (x %/% y) + (x %% y)
#it allows you to break integers up into pieces
#example
#in the flights dataset, you can compute hour and minute from dep_time with
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)
#Logs: log(), log2(), log10()
#Offsets: lead() and lag()
#They are most useful in conjunction with group_by()
#Cumulative and rolling aggregates
#unning sums, products, mins and maxes: cumsum(), cumprod(), cummin(), cummax(); 
#and dplyr provides cummean() for cumulative means
#If you need rolling aggregates (i.e. a sum computed over a rolling window), 
#try the RcppRoll package
#Logical comparisons, <, <=, >, >=, !=, and ==
#Ranking: there are a number of ranking functions, but you should start with min_rank()
#The default gives smallest values the small ranks; 
#use desc(x) to give the largest values the smallest ranks.
#look at the variants row_number(), dense_rank(), percent_rank(), cume_dist(), ntile()
#
#exercises
#Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with 
#because they’re not really continuous numbers
#Convert them to a more convenient representation of number of minutes since midnight
#jut copying from an online source, this is way too involved
flights_times <- mutate(flights,
                        dep_time_mins = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
                        sched_dep_time_mins = (sched_dep_time %/% 100 * 60 +
                                                 sched_dep_time %% 100) %% 1440
)
# view only relevant columns
select(
  flights_times, dep_time, dep_time_mins, sched_dep_time,
  sched_dep_time_mins
)
#stopping exercises here...
