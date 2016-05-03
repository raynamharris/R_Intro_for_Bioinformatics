01: Introduction to R and RStudio
=================================

RStudio is a free, open source R integrated development environment. It provides a built in editor and provides many advantages such as integration with version control and project management.

## RStudio Basic Layout

When you first open RStudio, you will be greeted by three panels:

  * The interactive R console (entire left)
  * The Environment/History (tabbed in upper right)
  * The Files/Plots/Packages/Help/Viewer (tabbed in lower right)
  
### The Interactive Console
The interactive console is where you will run all of your code, and can be a useful environment to try out ideas before adding them to an R script file. This console in RStudio is the same as the one you would get if you just typed in `R` in your commandline environment. The first thing you will see in the R interactive session is a bunch of information, followed by a ">" and a blinking cursor. 

### The Enviornment/History Panel

### The Files/Plots/Packages/Help/Viewer

Once you open a file, such as an R script, an editor panel will also open in the top left.

## Work flow within RStudio
There are two main ways one can work within RStudio. 

### The Interactive Consol 
You can type and run code using the interactive R console. This works well when you are doing small tests, but its hard to keep track of what you are doing.

### R Scripts: The more reproducible way to work
You can also begin by writing in a .R file, using RStudio's command to execute selected lines in the interactive R console. This is a great way to start because all your code is saved for later, and you can execute an entire workflow with the click of a button.

### Commenting
When writing scripts, anything that follows a `#` is ignored when R executes code. This allows you to add "comments" to your script. Your `#` can come at the beginning or the middle of the line. How many `#`s are used is a style choice.

### Tab Completion
One advantage that RStudio has over R on its own is that it has autocompletion abilities that allow you to more easily look up functions, their arguments, and the values that they
take.


## Using R as a calculator

The simplest thing you could do with R is do arithmetic:

If you type the following at the console:
~~~{.r}
1 + 100
~~~
You will see the following output:
~~~{.output}
[1] 101
~~~

When using R as a calculator, the order of operations is the same as you would have learnt back in school. Use parentheses to group operations in order to force the order of evaluation if it differs from the default, or to make clear what you intend.

From highest to lowest precedence:

 * Parentheses: `(`, `)`
 * Exponents: `^` or `**`
 * Divide: `/`
 * Multiply: `*`
 * Add: `+`
 * Subtract: `-`


~~~{.r}
3 + 5 * 2
~~~
~~~{.output}
[1] 13
~~~

and 

~~~{.r}
(3 + 5) * 2
~~~
~~~{.output}
[1] 16
~~~

When the output is a really small or large number, it will be reported in scientific notation. `10^XX` is shorthand for "multiplied by ", so `2e-4` is shorthand for `2 * 10^(-4)`.

~~~{.r}
2/10000
~~~
~~~{.output}
[1] 2e-04
~~~

You can write numbers in scientific notation too, using `e` in place of `10^`:
~~~{.r}
5e3  
~~~
~~~{.output}
[1] 5000
~~~


## Mathematical functions
R has many built in mathematical functions. To call a function, we simply type its name, followed by  open and closing parentheses. Anything we type inside the parentheses is called **the function's arguments**:

~~~{.r}
sin(1)  # trigonometry functions
~~~
~~~{.output}
[1] 0.841471
~~~

~~~{.r}
log(1)  # natural logarithm
~~~
~~~{.output}
[1] 0
~~~

~~~{.r}
log10(10) # base-10 logarithm
~~~
~~~{.output}
[1] 1
~~~

To figure out the synatx for a mathematical function, you can Google it. If you can remember the start of the function's name, you can use the tab completion in RStudio.


### Getting Help with a Function
Typing a `?` before the name of a command will open the help page for that command. As well as providing a detailed description of the command and how it works, scrolling ot the bottom of the help page will usually show a collection of code examples which illustrate command usage. We'll go through an example later.

## Comparing things
We can also do comparison in R:

~~~{.r}
1 == 1  # equality (note two equals signs, read as "is equal to")
~~~
~~~{.output}
[1] TRUE
~~~

~~~{.r}
1 != 2  # inequality (read as "is not equal to")
~~~
~~~{.output}
[1] TRUE
~~~

~~~{.r}
1 <  2  # less than
~~~
~~~{.output}
[1] TRUE
~~~

~~~{.r}
1 <= 1  # less than or equal to
~~~
~~~{.output}
[1] TRUE
~~~

~~~{.r}
1 > 0  # greater than
~~~
~~~{.output}
[1] TRUE
~~~

~~~{.r}
1 >= -9 # greater than or equal to
~~~
~~~{.output}
[1] TRUE
~~~

## Variables and assignment

We can store values in variables using the assignment operator `<-`. You will notice that assignment does not print a value. Instead, we stored it for later in something called a **variable**. `x` now contains the **value** `0.025`:

~~~{.r}
x <- 1/40
x
~~~
~~~{.output}
[1] 0.025
~~~

More precisely, the stored value is a *decimal approximation* of this fraction called a [floating point number](http://en.wikipedia.org/wiki/Floating_point).

Look for the `Environment` tab in one of the panes of RStudio, and you will see that `x` and its value have appeared. Our variable `x` can be used in place of a number in any calculation that expects a number:

~~~{.r}
log(x)
~~~
~~~{.output}
[1] -3.688879
~~~

Variables can be reassigned. We can easily reassign the value of `x` from 0.25 to 100 with the command.

~~~{.r}
x <- 100
x
~~~
~~~{.output}
[1] 100
~~~

Assignment values can contain the variable being assigned to. The right hand side of the assignment can be any valid R expression. The right hand side is *fully evaluated* before the assignment occurs.

~~~{.r}
x <- x + 1 #notice how RStudio updates its description of x on the top right tab
~~~

~~~{.r}
x <- x=+1
x
~~~
~~~{.output}
[1] 101
~~~

It is also possible to use the `=` operator for assignment; however, there are occasionally places where it is less confusing to use `<-` than `=`. We recommending using the more commonly used `<-`, but the most important thing is to **be consistent** with the operator you use.  

~~~{.r}
x = 1/40
~~~


> ### Challenge: What will be the value of each  variable  after each statement in the following program?
> 
> ~~~{.r}
> mass <- 47.5
> age <- 122
> mass <- mass * 2.3
> age <- age - 20
> ~~~

> ### Challenge: Is mass larger than age 
>
> Run the code from the previous challenge, and write a command to compare mass and age. Is mass larger than age?
>


### Naming variables

Variable names **can** contain letters, numbers, underscores and periods. 
Variable names **cannot** start with a number nor contain spaces at all. 

Different people use different conventions for long variable names. What you use is up to you, but **being consistent** will help make your research more reproducible. Some example conventions include:

  * periods.between.words
  * underscores\_between_words
  * CamelCaseToSeparateWords

> ### Challenge: Which of the following are valid R variable names?
> 
> ~~~{.r}
> min_height
> max.height
> _age
> .mass
> MaxLength
> min-length
> 2widths
> celsius2kelvin
> celsius kelvin
> ~~~


## Vectorization

Another thing to be aware of is that R is *vectorized*, meaning that variables and functions can have vectors as values. For example

~~~{.r}
1:5
~~~
~~~{.output}
[1] 1 2 3 4 5
~~~

~~~{.r}
2^(1:5)
~~~
~~~{.output}
[1]  2  4  8 16 32
~~~

~~~{.r}
x <- 1:5
2^x
~~~

~~~{.output}
[1]  2  4  8 16 32
~~~

This is incredibly powerful concept will discussed this further in an upcoming lesson.


## Managing your environment
There are a few useful commands you can use to interact with the R session.

### ls
`ls` will **list** all of the variables and functions stored in the global environment ( or your working R session):

~~~{.r}
ls()
~~~
~~~{.output}
[1] "x"         
~~~

If you want to see hidden variables (they begin with a `.`) type"

~~~{.r}
ls(all.names=TRUE)
~~~
~~~{.output}
[1] "x" ".mass"        
~~~

If we type `ls` by itself, R will print out the source code for that function!

~~~{.r}
ls
~~~

## rm
You can use `rm` to delete objects you no longer need:

~~~{.r}
rm(x)
~~~

> ## Challenge: Clean your enviornment {.challenge}
>
> Clean up your working environment by deleting the mass and age
> variables.
>



## Tip: Warnings vs. Errors 
Pay attention when R does something unexpected! Errors are thrown when R cannot proceed with a calculation. Warnings on the other hand usually mean that the function has run, but it probably hasn't worked as expected. In both cases, the message that R prints out usually give you clues how to fix a problem.


## R Packages
It is possible to add functions to R by writing a package, or by obtaining a package written by someone else. As of this writing, there are over 8,300 packages available on CRAN (the comprehensive R archive
network). R and RStudio have functionality for managing packages:

* To see what packages are installed, `installed.packages()`
* To install a package, type  `install.packages("packagename")`, where `packagename` is the package name, in quotes.
* To make a package available for use, type `library(packagename)`
* To update an already-installed packages, type `update.packages()`
* To remove a package, type `remove.packages("packagename")`



> ## Challenge 5: Install and load the following packages.
> 
> Install and load the following packages: `ggplot2`, `plyr`, `gapminder`
> 


## Proceed to the Next or Previous lesson
**Next Lesson:** [02 Best Practices](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/02-project-intro.md)  
**Previous Lesson** [00 The Motivating Datasets](https://github.com/raynamharris/R_Intro_for_Bioinformatics/blob/master/00-motivating-datasets.md)