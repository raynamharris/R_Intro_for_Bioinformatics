07 Dplyr
========

> ## Learning Objectives 
> * To be able to use the manipulate data frames with verbs and pipes using dplyr

Manipulation of dataframes means many things to many researchers, we often select certain observations (rows) or variables (columns), we often group the data by a certain variable(s), or we even calculate summary statistics. We can do these operations using the normal base R operations:

## The `dplyr` package

Luckily, the [`dplyr`](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) package provides a number of very useful functions for manipulating dataframes in a way that will reduce the above repetition, reduce the probability of making errors, and probably even save you some typing. You might even find the `dplyr` grammar very easy to read and thus incorporate into your research program..

Here we're going to learn the 6 of the most commonly used functions and learn how to use pipes (`%>%`) to combine them. 

1. `select()`
2. `filter()`
3. `group_by()`
4. `summarise()`
5. `mutate()`

If you have have not done so already, please install and load dplyr.

~~~{.r}
install.packages('dplyr')
library('dplyr')
~~~

### Using select()

To use the `select()` function, we must first provide the dataset and then provide the name of the columns we want separated by commas.

In this example, let's at an example.

~~~{.r}
select(gapminder, year, continent, gdpPercap)
~~~

~~~
Source: local data frame [1,704 x 3]

    year continent gdpPercap
   (int)     (chr)     (dbl)
1   1952      Asia  779.4453
2   1957      Asia  820.8530
3   1962      Asia  853.1007
4   1967      Asia  836.1971
5   1972      Asia  739.9811
6   1977      Asia  786.1134
7   1982      Asia  978.0114
8   1987      Asia  852.3959
9   1992      Asia  649.3414
10  1997      Asia  635.3414
..   ...       ...       ...
~~~

How easy was that?  Let's try another. Try subsetting by year and country.

### Using filter()

We just used `select()` to subset columns. Now, let's use `filter()` to subset the rows. 
If we now wanted to move forward with the above, but only with European countries, we can combine `select` and `filter`


~~~{.r}
filter(gapminder, continent=="Europe") 
~~~

~~~
Source: local data frame [360 x 6]

   country  year     pop continent lifeExp gdpPercap
     (chr) (int)   (dbl)     (chr)   (dbl)     (dbl)
1  Albania  1952 1282697    Europe  55.230  1601.056
2  Albania  1957 1476505    Europe  59.280  1942.284
3  Albania  1962 1728137    Europe  64.820  2312.889
4  Albania  1967 1984060    Europe  66.220  2760.197
5  Albania  1972 2263554    Europe  67.690  3313.422
6  Albania  1977 2509048    Europe  68.930  3533.004
7  Albania  1982 2780097    Europe  70.420  3630.881
8  Albania  1987 3075321    Europe  72.000  3738.933
9  Albania  1992 3326498    Europe  71.581  2497.438
10 Albania  1997 3428038    Europe  72.950  3193.055
..     ...   ...     ...       ...     ...       ...
~~~

### Using select() %>% filter()
The really powerful thing is that now we can combine these two together to subset by rows and columns.  To do so, we use the `%>%` or pipe.

After the select, we use `%>%` to pipe the output to `filter()`. Now, we no longer have to tell `filter()` where to find the data because it knows its comining from `select()`

~~~{.r}
select(gapminder, year, continent, gdpPercap) %>%
	filter(continent=="Europe")
~~~

~~~	
    year continent gdpPercap
   (int)     (chr)     (dbl)
1   1952    Europe  1601.056
2   1957    Europe  1942.284
3   1962    Europe  2312.889
4   1967    Europe  2760.197
5   1972    Europe  3313.422
6   1977    Europe  3533.004
7   1982    Europe  3630.881
8   1987    Europe  3738.933
9   1992    Europe  2497.438
10  1997    Europe  3193.055
..   ...       ...       ...
~~~

To filter by multiple continents, we must put the continents inside a list with  ` %in% c()`.

~~~{.r}
select(gapminder, year, continent, gdpPercap) %>%
	filter(continent %in% c("Africa", "Europe"))
~~~



If we wanted to save this new table, we could write the output to a new dataframe.

~~~{.r}
year_country_gdp_euro_afro <- 
	select(gapminder, year, continent, gdpPercap) %>%
		filter(continent %in% c("Africa", "Europe"))
~~~	

> ### Challenge 1 
>
> Write a single command using pipes that will produce a dataframe called "year_country_lifeExp_Africa" that has the African values for `lifeExp`, `country` and `year`, but not for other Continents. How many rows does your dataframe have and why?
>

One potential solution.
> ### Solution to Challenge 1 
>
>~~~{.r}
>year_country_lifeExp_Africa <- 
>	filter(gapminder, continent=="Africa") %>%
>   select(year,country,lifeExp)
>~~~

As with last time, first we pass the gapminder dataframe to the `filter()` function, then we pass the filtered version of the gapminder dataframe to the `select()` function. 

**Note:** The order of operations is very important in this case. If we used 'select' first, filter would not be able to find the variable continent since we would have removed it in the previous step.

### Using group_by() and summarize()
Using the `group_by()` function, we split our original dataframe into multiple pieces, allowing us to perform statistical analyses (e.g. `mean()` or `sd()`) within `summarize()`.

The summarize() will create a new column of data with the result. You can chose whatever name to assign to this new column. Descriptive names are best.

I'll use a subtully different synatax now, passing the whole gapminder dataframe into group_by, then piping that into summarize.

~~~{.r}
gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
~~~
~~~
Source: local data frame [5 x 2]

  continent mean_gdpPercap
      (chr)          (dbl)
1    Africa       2193.755
2  Americas       7136.110
3      Asia       7902.150
4    Europe      14469.476
5   Oceania      18621.609
~~~

> ## Challenge 2 
>
> Calculate the average life expectancy per continent. Which had the longest life expectancy and which had the shortest life expectancy?
>

One solution.
> ## Solution to Challenge 2 {.challenge}
>~~~{.r}
>gapminder %>%
>    group_by(continent) %>%
>    summarize(mean_lifeExp=mean(lifeExp))
>~~~


The function `group_by()` allows us to group by multiple variables. Let's group by `year` and `continent`.

~~~{.r}
gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
~~~

That is already quite powerful, but it gets even better! You're not limited to defining 1 new variable in `summarize()`.


~~~{.r}
gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop))
~~~

Now let's do some ggplot2! We can pipe this into ggplot2

~~~{.r}
gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
            sd_gdpPercap=sd(gdpPercap),
            mean_pop=mean(pop),
        	sd_pop=sd(pop))  %>%        
	ggplot(aes(x = year, y = mean_pop, color=continent)) +
  			geom_line()   
~~~

>## Challenge: Flights
>
>Now that you have learned all sorts of tools for analyzing and plotting data, let's see if you can apply it to another data frame!
>
>1. Read in flights.csv
>2. Select, just the month, origin, and distance traveled
>3. Group by month
>4. Filter the data to limit it to flights leaving your three favorite destination airports
>5. Plot month on the x axis, distance traveled on the y, and color by destination airport. Which airport is the closest to NYC? 

Of the three airports, which had the the longest distances traveled on average?


>## Challenge: Solution
>flights2 %>%
>  select(month, dest, distance) %>%
>  group_by(month) %>%
>  filter(dest %in% c('IAH', 'LAX', 'SFO')) %>%
>  ggplot(aes(x=month, y=distance, color = dest)) + geom_point()


## Other great resources
[Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
[Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)


## Proceed to the Next or Previous lesson
**Next Lesson:** [08 DESeq2](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/lessons/08-DESeq2.R)
*Previous Lesson** [06 Subsetting](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/lessons/06-subsetting.md) 