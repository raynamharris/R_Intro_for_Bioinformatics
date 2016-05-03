04: Data Structures & Data Frames
================================

> ## Learning Objectives 
> - To be aware of the different types of data
> - To begin exploring the data.frame
> - To understand how dataframes are related to vectors, factors and lists
> - To be able to ask questions from R about the type, class, and structure of an object
> - To learn how to manipulate a data.frame in memory
> - To understand best practices of exploring and understanding a data.frame 

## Gapminder Data

A data frame is a table, or two-dimensional structure, in which each column contains measurements on one variable, and each row contains one case. 


### read.csv()

One of R's most powerful features is its ability to deal with tabular data. If you've ever opened a file in Excell, then you've worked with tabular data. .csv files are tabular data that can easily be loaded into R.

Let's use the `read.csv` function to read in our data.

~~~{.r}
gapminder <- read.csv(file = "~/Desktop/FilesForRCourse/data/gapminder-FiveYearData.csv")
~~~

There are at least three ways to view our imported data.

~~~{.r}
gapminder			## will print to screen
head(gapminder)		## will print first 5 lines to the screen
View(gapminder)		## will open a tab showing the data in an excel-like way
~~~

~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~


**Pro Tip**: `read.csv` actually has many more arguments that you may find useful when importing your own data in the future. You can learn more about these options in this supplementary [lesson](01-supp-read-write-csv.html).


### str()
This is a pretty big dataset. Let's investigate the gapminder data with `str()`:


~~~{.r}
str(gapminder)
~~~

~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
~~~

> * Expose learners to the different data types in R
> * Learn how to create vectors of different types
> * Be able to check the type of vector
> * Learn about missing data and other special values
> * Getting familiar with the different data structures (lists, matrices, data frames)

## Data Structures and Data Types
To make the best of the R language, you'll need a strong understanding of the basic data types and data structures and how to operate on those. It is very important to understand data types because these are the objects you will manipulate on a day-to-day basis in R. Dealing with object conversions is one of the most common sources of frustration for beginners.

### Basic Data Structures or Objects

- **vector**: an R object that holds elements of different classes as shown below
- **list**: an R-object which can contain many different types of elements inside it like vectors, functions and even another list inside it
- **matrix**: is a two-dimensional rectangular data set where all columns have the same  vector type and are the same length. 
- **array**: arrays are similar to matrices but can have more than two dimensions.
- **data frame**: a two-dimensional data set in which the columns can contain different data types
- **factors**: factors usually look like character data but they represent categorical information

### Vector Types

R has 6 atomic vector types (although we will not discuss the raw class for this workshop). Here they are listed with an example

- **character**: 'a' , 'good' , 'TRUE', '23.4'
- **numeric**: 12.3, 5, 999
- **integer**: 2L, 34L, 0L (Note the: `L` suffix to insist that a number is an integer)
- **logical**: TRUE, FALSE
- **complex**: 3 + 2i


## Examining the Gapminder Data Frame

### dataframe$ColumnName
Earlier we saw that typing `gapminder` could print the file to the screen. To just print a column, we specify the column with `$ColumnName`. For example:

To print one column to the screen we can call the column a variety of ways

~~~{.r}
gapminder$year
gapminder$country
~~~

Likewise, to view the structure of the column year, we type:

~~~{.r}
str(gapminder$year)
str(gapminder$country)
~~~

~~~{.output}
 int [1:1704] 1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
~~~

This tells us that there are 1704 integers in the column year and 142 countries in the country column. 

You will use this notation **all the time** to call specific columns


### dim() nrow() ncol() colnames() rownames()
These are some really useful commands for exploring the data frame.

~~~{.r}
dim(gapminder) 			# prints the dimensions
nrow(gapminder)			# prints the number of rows
ncol(gapminder)			# prints the number of columns
colnames(gapminder)		# print the columns names
rownames(gapminder)		# prints the row names (often the line numbers)
head(gapminder)			# prints the first 6 lines
tail(gapminder)			# prints the last 6 lines
~~~

## Proceed to the Next or Previous lesson
**Next Lesson:** [05 Plotting with plot and ggplot2](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/05-plotting.md) 
**Previous Lesson** [03 Seeking Help](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/03-seeking-help.md)  
