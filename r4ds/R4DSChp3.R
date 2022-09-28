install.packages("tidyverse")
library(tidyverse)
#To learn more about mpg, open its help page by running ?mpg.
?mpg
#To plot mpg, run this code to put displ on the x-axis and hwy on the y-axis:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#To make a graph, replace the bracketed sections in the code below
#with a dataset, a geom function, or a collection of mappings.
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
#Exercises
#Run ggplot(data = mpg). What do you see?
ggplot(data=mpg)
#a blank plot
#How many rows are in mpg? How many columns?
?mpg
#234 rows and 11 variables
#What does the drv variable describe?
#drv describes the type of drive train
#Make a scatterplot of hwy vs cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))
#What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))
#not the most helpful visualization
#You can convey information about your data by mapping the 
#aesthetics in your plot to the variables in your dataset.
#you can map the colors of your points to the class variable
#to reveal the class of each car
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#To map an aesthetic to a variable, associate the name of the 
#aesthetic to the name of the variable inside aes(). 
#map class to the size aesthetic
#the exact size of each point would reveal its class affiliation
#warning here, because mapping an unordered variable (class) to an ordered aesthetic (size) 
#is not a good idea.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#mapped class to the alpha aesthetic, which controls the transparency of the points, 
#or to the shape aesthetic, which controls the shape of the points.
# Left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Right
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#By default, additional groups >6 will go unplotted when you use the shape aesthetic.
#set the aesthetic properties of your geom manually. 
#For example, we can make all of the points in our plot blue:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#To set an aesthetic manually, set the aesthetic by name as an argument of your geom function; 
#i.e. it goes outside of aes()

#exercises
#What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#because blue is inside aes instead of outside?
#Which variables in mpg are categorical? Which variables are continuous?
?mpg
str(mpg)
#a bind of character but are they categorical?
#Map a continuous variable to color, size, and shape. 
#How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = hwy))
#an error "A continuous variable can not be mapped to shape"
#What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class, alpha = class))
#Using alpha for a discrete variable is not advised. 
#What does the stroke aesthetic do?
?geom_point
#Use the stroke aesthetic to modify the width of the
# border
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
# You can create interesting shapes by layering multiple points of
# different sizes
p <- ggplot(mtcars, aes(mpg, wt, shape = factor(cyl)))
p +
  geom_point(aes(colour = factor(cyl)), size = 4) +
  geom_point(colour = "grey90", size = 1.5)
#new plot
p +
  geom_point(colour = "black", size = 4.5) +
  geom_point(colour = "pink", size = 4) +
  geom_point(aes(shape = factor(cyl)))
#What happens if you map an aesthetic to something other than a variable
#name, like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
#every thing <5 is a single color
#facets
#split your plot into facets, subplots that each display one subset of the data.
#To facet your plot by a single variable, use facet_wrap()
#The first argument of facet_wrap() should be a formula, which you create 
#with ~ followed by a variable name (here “formula” is the name of a data structure in R)
#The variable that you pass to facet_wrap() should be discrete
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#To facet your plot on the combination of two variables, add facet_grid() to plot call
#The first argument of facet_grid() is also a formula
#This time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
#If you prefer to not facet in the rows or columns dimension,
#use a . instead of a variable name, e.g. + facet_grid(. ~ cyl).
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
#exercises
#What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = trans)) + 
  facet_wrap(~ hwy, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = fl)) + 
  facet_wrap(~ hwy, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = trans)) + 
  facet_wrap(~ year, nrow = 2)
#not sure, I get a lot of plots?
#What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
#How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
#no data points there?
#What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
#split into 3 longer horizontol row plots
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#split into 4 longer column plots
#Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#What are the advantages to using faceting instead of the colour aesthetic? 
#seeing things by group on their own, easier to see relationships?
#What are the disadvantages?
#could get lots of plots
#How might the balance change if you had a larger dataset?
#depends on what you're splitting the plots up by
#more data might be easier to see in one plot
#Read
?facet_wrap
#What does nrow do?
# #of rows
#What does ncol do?
# # of columns
#What other options control the layout of the individual panels?
# To change the order in which the panels appear, change the levels
# of the underlying factor.
mpg$class2 <- reorder(mpg$class, mpg$displ)
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(vars(class2))
#Why doesn’t facet_grid() have nrow and ncol arguments?
#facet_grid() forms a matrix of panels defined by row and column faceting variables
#you define faceting froups on the rows/column dimension
#When using facet_grid() you should usually put the variable 
#with more unique levels in the columns. Why?
#easier to look at?

#A geom is the geometrical object that a plot uses to represent data.
#To change the geom in your plot, change the geom function that you add to ggplot()
#right
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#left
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
#Every geom function in ggplot2 takes a mapping argument. 
#However, not every aesthetic works with every geom
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
#ggplot2 provides over 40 geoms
#Many geoms, like geom_smooth(), use a single geometric object to 
#display multiple rows of data. For these geoms, you can set the group
#aesthetic to a categorical variable to draw multiple objects
#a separate object for each unique value of the grouping variable
#ggplot2 will automatically group the data for these geoms whenever 
#you map an aesthetic to a discrete variable 
#It is convenient to rely on this feature because the group aesthetic 
#by itself does not add a legend or distinguishing features to the geoms.
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
#no legend for the above plot
#To display multiple geoms in the same plot, add multiple geom functions
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#Imagine if you wanted to change the y-axis to display cty instead of hwy. 
#You’d need to change the variable in two places
#avoid this type of repetition by passing a set of mappings to ggplot()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
#If you place mappings in a geom function, 
#ggplot2 will treat them as local mappings for the layer.
#This makes it possible to display different aesthetics in different layers.
#You can use the same idea to specify different data for each layer.
#Here, our smooth line displays just a subset of the mpg dataset, the subcompact cars
#The local data argument in geom_smooth() overrides the global data 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
#the filter command selects subcompact cars

#exercises
#What geom would you use to draw a line chart? 
#depends on what kind of line, geom_smooth is what we have used
#A boxplot? 
#geom_boxplot
#A histogram? 
#we used hist for something else
#An area chart?
#what is that?
#what will this plot look like
#a point of plots with a line, no C.I.
#split up by drv
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#What does show.legend = FALSE do? 
#hides the legend
#What happens if you remove it?
#default is na, which includes any mapped aesthetics
#Why do you think I used it earlier in the chapter?
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv))
#simplify what we were looking at?
#What does the se argument to geom_smooth() do?
#include confidence intervals
#Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#no, because the local and global mapping match
#Recreate the R code necessary to generate the following graphs.
#fist plot, global mapping
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy),
              se = FALSE)
#second plot, split up by drv
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#now we want a different color for each drv    
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#now change the line so that there is only one
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(data= mpg, mapping = aes(x = displ, y = hwy), se = FALSE)
#now we want different line types for drv
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(data= mpg, mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE)
#now, no line but put white borders around the dots
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(shape = 21, color = "red", fill = "white", size = 2, stroke = 1)
#close, moving on for now
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
#You can generally use geoms and stats interchangeably. 
#For example, you can recreate the previous plot using stat_count() instead of geom_bar():
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))    
#This works because every geom has a default stat; and every stat has a default geom.
#You might want to override the default stat. 
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
#You might want to override the default mapping from transformed variables to aesthetics.
#For example, you might want to display a bar chart of proportion, rather than count:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
#might use stat_summary(), which summarises the y values for each unique x value, 
#to draw attention to the summary that you’re computing:
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
#What is the default geom associated with stat_summary()?
?stat_summary
#something called "pointrange"?
?stat_count
#How could you rewrite the previous plot to 
#use that geom function instead of the stat function?
# not sure about this, skipped
#What does geom_col() do?
?geom_col
#so it is another bar chart, but it uses the heights of the bars
#to represent values in the data
#How is it different to geom_bar()?
#geom_bar() makes the height of the bar proportional to the number of cases in each group
#geom_bar() uses stat_count() by default: 
#Most geoms and stats come in pairs that are almost always used in concert.
#Read through the documentation and make a list of all the pairs.
#geom bar and stat count
#geom boxplot and stat boxplot
#geom contour and stat contour
#geom count and stat sum
#geom point and stat identity
#I'm ot going to list all of these
#What variables does stat_smooth() compute?
#y or x, predicted value
#ymin or xmin and ymax or xmax
#lower/upper pointwise CI
#se
#standard error
#What parameters control its behaviour?
#not sure, x and y?
#In our proportion bar chart, we need to set group = 1. 
#Why? In other words what is the problem with these two graphs?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))
#What do they have in common?
# all the same size bar...

######
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
#the one above has the outline a color
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
#this one changes the color of the whole bar
#Note what happens if you map the fill aesthetic to another variable, like clarity: 
#the bars are automatically stacked. Each colored rectangle represents a combination of cut and clarity.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
#The stacking is performed automatically by the position adjustment specified by the position argument.
#don’t want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill"
#position = "identity" will place each object exactly where it falls in the context of the graph.
#This is not very useful for bars, because it overlaps them. 
#we either need to make the bars slightly transparent by setting alpha to a small value, 
#or completely transparent by setting fill = NA
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#position = "fill" works like stacking, but makes each set of stacked bars the same height. 
#This makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
#position = "dodge" places overlapping objects directly beside one another.
#This makes it easier to compare individual values
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
#talking about a previous graph
#The values of hwy and displ are rounded so the points appear on a grid and many points overlap each other.
#This problem is known as overplotting.
#You can avoid this gridding by setting the position adjustment to “jitter”. 
#position = "jitter" adds a small amount of random noise to each point.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#Because this is such a useful operation, ggplot2 comes with a shorthand
#for geom_point(position = "jitter"): geom_jitter()
######
#exercises
#What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
#add jitter?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
#What parameters to geom_jitter() control the amount of jittering?
#factor numeric
#Compare and contrast geom_jitter() with geom_count().
?geom_jitter
?geom_count
#This is a variant geom_point() that counts the number of observations
#at each location, then maps the count to point area. 
#It useful when you have discrete data and overplotting.
#What’s the default position adjustment for geom_boxplot()?
#dodge2
#Create a visualisation of the mpg dataset that demonstrates it.
ggplot(data = mpg, mapping = aes(x= cty, y = hwy) group = model)+
  geom_boxplot()
#???

#coordinate systems
#default is cartesian
#coord_flip() switches the x and y axes
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
#coord_quickmap() sets the aspect ratio correctly for maps
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
#coord_polar() uses polar coordinates. 
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#urn a stacked bar chart into a pie chart using coord_polar().
#isn't that what we just did? skipped
#What does labs() do?
?labs
#modify axis, legend, plot labels
#What’s the difference between coord_quickmap() and coord_map()?
#projects a portion of the earth, which is approximately spherical, onto a flat 2D plane 
#does not preserve straght lines
#coord_quickmap() is a quick approximation that does preserve straight lines. 
#What does the plot below tell you about the relationship between city and highway mpg? 
#Why is coord_fixed() important? What does geom_abline() do?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
#they have a positive relationship
#coord_fixed used a fixed aspect ratio
#abline adds a reference line
#####
#new template
#ggplot(data = <DATA>) + 
#<GEOM_FUNCTION>(
#  mapping = aes(<MAPPINGS>),
#  stat = <STAT>, 
#  position = <POSITION>
#) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>