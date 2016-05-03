Seeking Help
=============

## Learning Objectives 

* To be able read R help files for functions and special operators.
* To be able to use CRAN task views to identify packages to solve a problem.
* To be able to seek help from your peers


## Help Pages

Base R and R packages, provide help files for functions. There are multiple ways to search for information about a function from a package loaded into your your interactive R session. Let's use this example from ggplot2.

~~~{.r}
??geom_point 		## this will provide search results if there are multiple hits
?geom_point			## this will open the manual under the help tab
help('geom_point')	## this will also open the manual under the help tab
~~~

These command will load up as a help page in RStudio or as plain text in plain R.

Each help page is broken down into sections. Different functions might have different sections, but these are the main ones you should be aware of.

 - **Description**: An extended description of what the function does.
 - **Usage**: The arguments of the function and their default values.
 - **Arguments**: An explanation of the data each argument is expecting.
 - **Details**: Any important details to be aware of.
 - **Value**: The data the function returns.
 - **See Also**: Any related functions you might find useful.
 - **Examples**: Some examples for how to use the function.


One of the most daunting aspects of R is the large number of functions available. It is very hard to remember the correct usage for every function you use, so the help page is where you go for help remembering or to learn how to use a new function.


## Vignettes

Many packages come with "vignettes" or tutorials and extended example documentation.

- Without any arguments, `vignette()` will list all vignettes for all installed packages
- `vignette(package='package-name')` will list all available vignettes for
`package-name`
- `??'package-name'` will display available vignettes and help pages in a way that allows you to open one in the help tab
- `vignette('vignette-name')` will open the specified vignette


~~~{.r}
vignette(package='dplyr)
??'dplyr'
??'cowplot'
vignette('introduction')

~~~


## Help When You Don't Know the Name
If you don't know what function or package you need to use, [CRAN Task Views](http://cran.at.r-project.org/web/views) is a specially maintained list of packages grouped into fields. This can be a good starting point.

## Stack Overflow

If you are having trouble with a function or package, 9 times out of 10 your problem has been discuss on
[Stack Overflow](http://stackoverflow.com/). You can search using
the `[r]` tag. I like to look for answers with multiple votes, which shows community support of an answer.


## Other Useful Tutorials

* [Quick R](http://www.statmethods.net/)
* [RStudio cheat sheets](http://www.rstudio.com/resources/cheatsheets/)
* [Cookbook for R](http://www.cookbook-r.com/)


> ## Challenge: Getting Help with DESeq
> 1. Find and open the tutorial for DESeq2
> 2. Open the help page for the function 'plotPCA' in the DESeq2 package


> ## Solutions: Getting Help with DESeq
 
> ~~~{.r}
> ??'DESeq2' 			## then click 'DESeq2::DESeq2' to preview the pdf	
> vignette('DESeq2')	## will open a pdf of the vingette
> ?'DESeqDataSet'  		## will open help page
> ~~~
>
