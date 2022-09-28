#GEO511 case study 2
#"My grandfather says summers are getting hotter"
#
#first time only
#install.packages("tidyverse")
#load libraries every time
library(tidyverse)
#
# define the link to the data - you can try this in your browser too.  
#Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
# the next lines download the data
temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))
# renaming is necessary because they used dashes ("-")
# in the column names and R doesn't like that.
#If the command above gives you an error, open the page in the browser 
#and update the data url link to download the csv.
##
#explore the data
view(temp)
summary(temp)
glimpse(temp)
#now create the graphic
#you'll need to layer the things you're looking for
ggplot(data = temp, mapping = aes(x = YEAR, y = JJA)) +
  geom_line()+
  geom_smooth(color = "red", method = "loess") +
  xlab("Year")+
  ylab ("Mean Summer Temperatures (C)")+
  labs(
    title = "Mean Summer Temperatures in Buffalo, NY",
    subtitle = "Summer includes June, July, and August 
    Data from the Global Historical Climate Network 
    Red line is a LOESS smooth")

#
 #save the plot using ggsave
ggsave("MeanSummerTempGEO511CS2.png")

  


