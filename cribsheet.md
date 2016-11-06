# R Cheatsheet

### Object assignment
Assign to an object with `<-` or `=`. For example, `x <- 5`.

View an object by typing its name into the console.

### Common classes and conversion
Use the function `class(object)` to check the class of an object.

|Class|Example|Conversion|
|----|----|----|
|`numeric`|`3`,`3.6`|`as.numeric()`|
|`character`|`"yahoo"`,`"attgcttnnntta"`|`as.character()`|
|`factor`|`"year1"`/`1`,`"year2"`/`2`|`as.factor()`|

### Types of data containers
|Container|Type of element|Dimensionality|Constructor function|Indexing|
|----|----|----|----|----|
|Vector|all one type|one dimension|`c()`|`x[number]`, `x["name"]`|
|Matrix|all one type|two-dimensional|`matrix(values, nrow, ncol)`|`x[row number, col number]`, `x["row name", "col name"]`|
|Array|all one type|multi-dimensional|`array(values, dim)`|as for matrices|
|Data frame|variable|two-dimensional|`data.frame()`|`x[row number, col number]`,`x[["name"]]`|
|List|variable|variable|`list()`|`x[[element number]]`, `x[["element name"]]`|

### Summarizing data containers
|Function|Purpose|
|----|----|
|`head()`|shows first few elements|
|`summary()`|summarizes elements of container|
|`str()`|shows structure of container|
|`nrow()`,`ncol()`,`dim()`,`length()`|dimensionality of container|

### Logical evaluation
|Operator|Meaning|Example|
|----|----|----|
|`==`|Equal to|`x==1`|
|`!=`|Not equal to|`x!="Sally"|
|`>`,`<`|Greater than, less than|`x > 5`|
|`>=`,`<=`|Greater/less than or equal to|`x >= 5`|
|`|`|Or|`x > 5 | x < 100`|
|`&`|And|`x > 5 & y=="Year 1"`|
|`is.na()`|Is missing value|`is.na(x)`|
|`!`|Negation|`!is.na(NA)`|
|`all(container operator condition)`|All elements of container meet condition|`all(x>5)`|
|`any(container operator condition)`|Any elements of container meet condition|`any(x==5)`|
|`which(container operator condition)`|Which elements of container meet condition|`which(x==5)`|

### Loops and flow control
Loop syntax:
```r
for( interator in vector ) { 
  ## commands go here
}
```

If/else syntax:
```r
if( condition ) {
  # do something
} else if ( another condition ) {
  # do something else
} else {
  # do another thing
}
```

While syntax:
```r
while ( condition ) {
  # keep on doing stuff
}
```

### Function construction
Syntax for running a function and saving the result as an object:
```
function_result <- function_name(function_argument_one, function_argument_two, etc.)
```

Syntax for constructing a function:
```
myFunction <- function(argument1, argument2, etc.){
  # do stuff with arguments here
}
```

To view the source code of a function just type its name and press enter.

### Help
|Command|Purpose|Example|
|----|----|----|
|`?function_name`|shows help page for function (the package must be loaded)|`?lm`|
|`??function_name`|searches for function across installed packages|`??glm.nb`|
|`apropros("string")`|lists names of functions which contain string|`apropros("plot")`|
|`findFn("keywords")`|in package `sos`, search CRAN for functions associated with keywords|`findFn("beta regression")`|
|`RSiteSearch("keywords")`|searches R listserv and help pages for keywords|`RSiteSearch("mixed effects model")`|

### Packages
* Install packages with `install.packages("package_name")`, ie. `install.packages("lme4")`
* Load packages with `library(package_name)`, ie. `library(lme4)`
* Detach packages with `detach("package:package_name")`, ie. `detach("package:lme4")`