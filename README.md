
<!-- README.md is generated from README.Rmd. Please edit that file -->

# highlighter

<!-- badges: start -->

<!-- badges: end -->

The goal of highlighter is to make reading free text easier. Often
times, you are only interested in finding specific keywords in a giant
free text field. The highlighter app lets you upload a dataset and start
highlighting keywords using the
[`marker`](https://github.com/JohnCoene/marker) package.

A demonstration of the app can be found
[here](https://tylerlittlefield.com/shiny/tyler/highlighter/).

## Installation

You can run the following in your terminal:

``` zsh
git clone https://github.com/r4fun/highlighter.git
cd highlighter/
R -e 'renv::restore(confirm = FALSE); shiny::runApp()'
```
