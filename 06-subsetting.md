07: Manipulating Data Frames
================================

> ## Learning Objectives 
>
> * To be able to subset vectors, factors, matrices, lists, and data frames
> * To be able to extract individual and multiple elements
> * To be able to skip and remove elements from various data structures.
>


## Subsetting Data in Base R
Base R has many powerful subset operators. Mastering them will allow you to easily perform complex operations on any kind of dataset. Below is a brief list of ways you can subset data in base R.

1. Accessing elements using their indices
2. Subsetting by name
3. Subsetting through other logical operations

Let's look at a few examples using the gapminder dataset.

### Accessing elements using their indices

To access a given column, you can call it by typing column position or indice in square brackets. For instance `gapminder[3]`. Let's just take a look at the first 6 rows by using `head()`.

~~~{.r}
head(gapminder[3])
~~~

~~~{.output}
Source: local data frame [6 x 1]

       pop
     (dbl)
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
~~~


### Accessing elements using their indices

Likewise, we can subset by name by type the column name inside quotes inside a square bracket

~~~{.r}
head(gapminder[["pop"]])
~~~

~~~{.output}
Source: local data frame [6 x 1]

       pop
     (dbl)
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
~~~

Another way to call the column by name is to use the same `$` nomenclature we used for plotting in base R.

~~~{.r}
head(gapminder$year)
~~~

~~~{.output}
[1]  8425333  9240934 10267083 11537966
[5] 13079460 14880372
~~~

### Accessing elements with multiple arguments

To specify specific rows and columns, we must separate them by a `,`. Also, you can use the `:` to specific multiple rows for columns. Nothing in front of or behind the comma means all rows or all columns, respectively.


~~~{.r}
gapminder[1:3,]
~~~

Returns the first three rows and all columsn.

~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007

~~~

## Subsetting with Dplyr

If that syntax doesn't not work well with your brain, have no fear. Hadley Wickham has come to your rescue!

## Proceed to the Next or Previous lesson
**Next Lesson:** [07 dplyr](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/07-dplyr.md) 
**Previous Lesson** [05 Plotting with plot and ggplot2](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/05-plotting.md) 