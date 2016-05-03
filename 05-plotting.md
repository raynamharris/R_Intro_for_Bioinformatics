04: Plotting with plot and ggplot2
================================

> ## Learning Objectives 
>
> * To be able to use ggplot2 to generate publication quality graphics
> * To understand the basics of the grammar of graphics:
>   - The aesthetics layer
>   - The geometry layer
>   - Adding statistics
>   - Transforming scales
>   - Coloring or paneling by groups.
>

Plotting our data is one of the best ways to quickly explore it and the various relationships between variables.

There are three main plotting systems in R, the [base plotting system][base], the [lattice][lattice] package, and the [ggplot2][ggplot2] package. Also, our very own Claus Wilke created a fun package called [cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html) that has some additional features, like the ability to put two plots side by side.

[base]: http://www.statmethods.net/graphs/
[lattice]: http://www.statmethods.net/advgraphs/trellis.html
[ggplot2]: http://www.statmethods.net/advgraphs/ggplot2.html

## Plotting with Base R

The `plot()` function in base R can be used to quickly generate plots in R. Let's look at how to use plot

~~~{.r}
?'plot'
~~~

At a minimum, we must tell R what to plot on the x and y. Here are two examples

~~~{.r}
plot(gapminder$lifeExp, gapminder$gdpPercap)
plot(gapminder$continent, gapminder$gdpPercap)
~~~

Since columns used in the first example contained all numbers, the plot default was a scatter plot. However, continent contains factors, so the default plot was a box plot

###  main, xlab, ylab
We can add a title and axis labels like so:

~~~{.r}
plot(gapminder$lifeExp, gapminder$gdpPercap, 
		main = 'Plot of GDP and LifeExp',
		xlab = 'GDP',
		ylab = 'Life Expectancy')
plot(gapminder$continent, gapminder$gdpPercap, 
		main = 'View ofGDP across Continents',
		xlab = 'Continent',
		ylab = 'GDP')
~~~

So, that's nice and straightforward, but let's use ggplot to really explore the intricacies of our data

## ggplot2

ggplot2 is built on the grammar of graphics. Basically, any plot can be expressed from the same set of components: a **data** set, a **coordinate system**, and a set of **geoms**-- or the visual representation of data points. The key to understanding ggplot2 is thinking about a figure in layers, like you might do in an image editing program like Photoshop or Illustrator,

Let's start off with an example:

~~~{.r}
ggplot(data = gapminder, 
	aes(x = lifeExp, y = gdpPercap)) +
	geom_point()
~~~

<img src="figures/08-plot-ggplot2-lifeExp-vs-gdpPercap-scatter-1.png" title="plot of chunk lifeExp-vs-gdpPercap-scatter" alt="plot of chunk lifeExp-vs-gdpPercap-scatter" style="display: block; margin: auto;" />


The first thing we did was call the `ggplot()` function within the ggplot2 package. This function lets R know that we're creating a new plot, and any of the arguments we give the
`ggplot` function are the *global* options for the plot that will be applied to all
layers on the plot.

Then, we passed in two arguments to `ggplot`. 
1. Using `data = gapminder`, we tell ggplot where to find the data 
2. Using the `aes` function, we tell `ggplot` how variables in the data map to *aesthetic* properties of the figure, in this case the x and y locations. In the above example, said plot **lifeExp on the x-axis** and the **gdpPercap on the y-axis**. 

Finally, we told `ggplot` how to visually represent the data by adding adding a **geom** layer. In our example, we used `geom_point`, which tells `ggplot` we want to visually represent the relationship between x and y as a **scatterplot**


> ### Challenge: Plot life expectancy over time
> Modify the example so that the figure visualise how life expectancy has
> changed over time.

Here is one potential solution.

> ### Solution: Plot life expectancy over time
> ~~~{.r}
> ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()
> ~~~


### More aesthetics 
Rather than have all our data points be black, we can color them by a factor, in our case either continent or country. We will use the *aesthetic* property `color = ` to do this

~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_point()
~~~

<img src="figures/05-plotting-ggplot2-year-lifeExp-color.jpeg" title="plot of chunk lifeExp-line" alt="plot of chunk lifeExp-line" style="display: block; margin: auto;" />

Now, we can begin to see patterns in the data and start to better understand how GDP varies as a function of time and country. 

### by= and geom_line()
With two modification, we can examine how GDP changes over time for a speicific country. 

1. First, we add the aesthetic `by=country` to group the data by country. 
2. Then, we replace `geom_point()` with `geom_line()`

~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, color=continent, by=country)) +
  geom_line()
~~~

The `+` means that that we are layering lines onto the plot. We can layer both the points and the lines if you think that is useful.

~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line() + geom_point()
~~~

<img src="figures/08-plot-ggplot2-lifeExp-line-point-1.png" title="plot of chunk lifeExp-line-point" alt="plot of chunk lifeExp-line-point" style="display: block; margin: auto;" />

Its important to remember that what is inside `ggplot()` is applied globallly. If we only want the lines to be colored but not the points, we could modify the placement of aes(color=continent)

~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + geom_point()
~~~

<img src="figures/08-plot-ggplot2-lifeExp-layer-example-1-1.png" title="plot of chunk lifeExp-layer-example-1" alt="plot of chunk lifeExp-layer-example-1" style="display: block; margin: auto;" />

In this example, the *aesthetic* mapping of **color** has been moved from the
global plot options in `ggplot` to the `geom_line` layer so it no longer applies
to the points. Now we can clearly see that the points are drawn on top of the
lines.

### Transformations and Statistics
Sometimes, it makes more sense to plot transformed data. You could create a new column with the log transformed GDP, or we can simply have `ggplot` log transform the data. Let's look at both.

#### Modifying the dataframe 
The command `log10(gapminder$gdpPercap)` will perform a log transformation of the gdp column. The syntax `data$newcolumn <-` tells R to send that output to a new column in a specified data frame.

~~~{.r}
gapminder$logGDP <- log10(gapminder$gdpPercap)
head(gapminder)
~~~

Now, let's plot the untransformed and the transformed data

~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap, color=continent)) +
  geom_point()
ggplot(data = gapminder, aes(x = lifeExp, y = logGDP, color=continent)) +
  geom_point()
~~~

Now, its easier to see the linear relationship between life expectancy and see differences by country.

#### Using scale_y_log10() or scale_x_log10()

Rather than modifying the data frame, we could also change the scale of units on the y axis by layering on the *scale* function. 

~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap, color=continent)) +
  geom_point() + scale_y_log10()
~~~

<img src="figures/08-plot-ggplot2-axis-scale-1.png" title="plot of chunk axis-scale" alt="plot of chunk axis-scale" style="display: block; margin: auto;" />

The `log10` function applied a transformation to the values of the gdpPercap column before rendering them on the plot, so that each multiple of 10 now only corresponds to an increase in 1 on the transformed scale, e.g. a GDP per capita of 1,000 is now 3 on the y axis, a value of 10,000 corresponds to 4 on the y axis and so on. This makes it easier to visualise the spread of data on the y-axis.

### Fitting a Model to the Plot

We can fit a simple relationship to the data by adding `geom_smooth()` to another layer. We must specify a method, and here we will use a linear model or "lm"

~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point() + scale_y_log10() + geom_smooth(method='lm')
~~~

<img src="figures/08-plot-ggplot2-lm-fit-1.png" title="plot of chunk lm-fit" alt="plot of chunk lm-fit" style="display: block; margin: auto;" />

Remember, that everything inside `ggplot()` will be applied to all the layers.  To see the model for each country, add the aesthetic `color=continent` back.

~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap, color=continent)) +
  geom_point() + scale_y_log10() + geom_smooth(method='lm')
~~~


### Multi-panel figures
Earlier we visualised the change in life expectancy over time across all countries in one plot. Alternatively, we can split this out over multiple panels by adding a layer of **facet** panels. The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde (~). This tells R to draw a panel for each unique value in the country column of the gapminder dataset.

~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country)
~~~

<img src="figures/08-plot-ggplot2-facet-1.png" title="plot of chunk facet" alt="plot of chunk facet" style="display: block; margin: auto;" />

The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde (~). This tells R to draw a panel for each unique value in the country column of the gapminder dataset.

We can combine facet wrap with other geoms such as geom_density to create pretty histograms.

~~~{.r}
ggplot(data=gapminder, aes(x=gdpPercap, fill=continent)) +
  geom_density(alpha=0.6) + facet_wrap( ~ year) + scale_x_log10()
~~~

### Modifying Text with themes
To clean this figure up for a publication we need to change some of the text elements. The x-axis is way too cluttered, and the y axis should read "Life expectancy", rather than the column name in the data frame. We can do this by adding a couple of different layers. The **theme** layer controls the axis text, and overall text size, and there are special layers for changing the axis labels. To change the legend title, we need to use the **scales** layer.


~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  xlab("Year") + ylab("Life expectancy") + ggtitle("Figure 1") +
  scale_colour_discrete(name="Continent") +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
~~~

<img src="figures/08-plot-ggplot2-theme-1.png" title="plot of chunk theme" alt="plot of chunk theme" style="display: block; margin: auto;" />

### More on ggplot2
This is just a taste of what you can do with `ggplot2`. RStudio provides a really useful [cheat sheet][cheat] of the different layers available, and more extensive documentation is available on the [ggplot2 website][ggplot-doc]. Finally, if you have no idea how to change something, a quick google search will usually send you to a relevant question and answer on Stack Overflow with reusable code to modify!

[cheat]: http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
[ggplot-doc]: http://docs.ggplot2.org/current/


## Proceed to the Next or Previous lesson
**Next Lesson:** [06 DESeq2]
*Previous Lesson** [04 Data Structures & Data Frames](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/04-data-structures-dataframes.md) 