--- 
title: "Reproducible GIS analysis with R"
author: "[Phil Hurvitz](mailto:phurvitz@uw.edu)"
date: '2022-03-02 22:58'
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
description: "Manual for CSDE Workshop 'Reproducible GIS analysis with R'"
---




# Introduction
<!--The materials available here were created to guide students through the [CSDE](https://csde.washington.edu/) [workshop]() course on the use of geographic information systems (GIS) functionality in [R](https://cran.r-project.org/), primarily with the use of the [`sf` (Simple Features for R)](https://r-spatial.github.io/sf/articles/sf1.html) and [`raster`](https://cran.r-project.org/web/packages/raster/index.html) packages. The focus of the course is reproducible GIS analytic work flows.-->

The materials available here were created to guide students through the [CSDE](https://csde.washington.edu/) [workshop](https://csde.washington.edu/workshop/reproducible-gis-analysis-with-r/) course on the use of geographic information systems (GIS) functionality in [R](https://cran.r-project.org/), primarily with the use of the [`sf` (Simple Features for R)](https://r-spatial.github.io/sf/articles/sf1.html) package. The focus of the course is reproducible GIS analytic work flows.

Please see the [PowerPoint presentation introducing the workshop](images/reproducible_gis_csde_20220204.pptm).

**Rationale**

GIS provides a powerful environment for the analysis of spatially-referenced data. The most widely used GIS applications in research are "desktop" software products with graphical user interfaces designed for interactive use. These applications (e.g., ArcMap, QGIS) are wonderful tools for exploratory data analysis and map production. However, in research they introduce the problem that much of the results of even fairly simple analytic work flows are not reproducible because the software is generally not designed to record all of the tasks the user performed. This is particularly salient during development of analytic methods, during which a substantial amount of trial-and-error occurs. Another problem with ArcGIS in particular is that geoprocessing generally requires the user to specify the output file system location and file name for any analytic results. This introduces several  issues: (1) when an analyst is in the "zone," taking the time do decide where to put a data set and what to call it can break the flow of creativity; (2) accepting the default location and names of geoprocessing operations can result in a jumble of data with meaningless file names; (3) given an existing data set, how would the analyst know what work flow created this as a result? 

Approaching GIS analysis within an R framework addresses many of these problems:

1. Geoprocessing operations that are performed with programmatic code are reproducible. While ArcGIS and QGIS include Python for programmatic approaches, many researchers are already working with R, so only some new commands need to be learned, rather than an entire new language.
1. R is a language that is relatively easy to read and write, lowering the bar for entry.
1. R results are generally stored as `data frames` which can then be used by the many analytic functions in base R or in added packages.
1. Geoprocessing operations produce results that are stored in memory. This will be a problem for very large data sets and/or limited RAM. On the other hand, it does not force the analyst to decide the file system location and name of a data set at run time; code can be altered to store file system outputs after work flows are determined to have created correct results.
1. Files created using programmatic code can be traced back to the code that generated them (i.e., `find / -name "*.R" | xargs grep "myawesomedataset.gpkg"`).
1. Incorporating GIS analyses in R Markdown allows the analyst to create reports that include both the analytic code used to create results as well as to show results and even maps.

**What this course is**

This course will introduce students to the use of basic GIS functionalities within the R framework. By the end of the course, students will be able to import and export GIS data sets, perform coordinate transformations, perform some rudimentary GIS analyses, and produce simple interactive maps.

**What this course is <i>not</i>**

This course is not intended to teach fundamentals of GIS. We assume that students have at least a beginning to intermediate level of skill in the use of a desktop GIS software application such as ArcGIS Desktop or QGIS. This is also not an R course--it is expected that students will have a fundamental grasp of the use of R.

**Overview**

Each of the topics shown below will be covered during the course.

1. Getting started
1. Representation of spatial features
1. Data import/export
1. Projections and coordinate systems
1. Overlay analysis
    1. Point-in-polygon
    1. Polygon-on-polygon
<!--1. Raster functionality-->
1. Simple interactive maps with `Leaflet` and `mapview`


## Source code
File is at H:/gis_in_r_bak/index.Rmd.

### R code used in this document

```r
pacman::p_load(
    tidyverse,
    sf,
    leaflet,
    mapview,
    captioner,
    knitr
)

table_nums <- captioner(prefix = "Table")
figure_nums <- captioner(prefix = "Figure")

# path to this file name
if (!interactive()) {
    fnamepath <- current_input(dir = TRUE)
} else {
    fnamepath <- ""
}
cat(readLines(fnamepath), sep = '\n')
```

### Complete Rmd code

```r
cat(readLines(fnamepath), sep = '\n')
```

````
--- 
title: "Reproducible GIS analysis with R"
author: "[Phil Hurvitz](mailto:phurvitz@uw.edu)"
date: '`r format(Sys.time(), "%Y-%m-%d %H:%M")`'
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
description: "Manual for CSDE Workshop 'Reproducible GIS analysis with R'"
---

```{r, echo=FALSE, warning=FALSE, message=FALSE}
pacman::p_load(
    tidyverse,
    sf,
    leaflet,
    mapview,
    captioner,
    knitr
)

table_nums <- captioner(prefix = "Table")
figure_nums <- captioner(prefix = "Figure")

# path to this file name
if (!interactive()) {
    fnamepath <- current_input(dir = TRUE)
} else {
    fnamepath <- ""
}
```


# Introduction
<!--The materials available here were created to guide students through the [CSDE](https://csde.washington.edu/) [workshop]() course on the use of geographic information systems (GIS) functionality in [R](https://cran.r-project.org/), primarily with the use of the [`sf` (Simple Features for R)](https://r-spatial.github.io/sf/articles/sf1.html) and [`raster`](https://cran.r-project.org/web/packages/raster/index.html) packages. The focus of the course is reproducible GIS analytic work flows.-->

The materials available here were created to guide students through the [CSDE](https://csde.washington.edu/) [workshop](https://csde.washington.edu/workshop/reproducible-gis-analysis-with-r/) course on the use of geographic information systems (GIS) functionality in [R](https://cran.r-project.org/), primarily with the use of the [`sf` (Simple Features for R)](https://r-spatial.github.io/sf/articles/sf1.html) package. The focus of the course is reproducible GIS analytic work flows.

Please see the [PowerPoint presentation introducing the workshop](images/reproducible_gis_csde_20220204.pptm).

**Rationale**

GIS provides a powerful environment for the analysis of spatially-referenced data. The most widely used GIS applications in research are "desktop" software products with graphical user interfaces designed for interactive use. These applications (e.g., ArcMap, QGIS) are wonderful tools for exploratory data analysis and map production. However, in research they introduce the problem that much of the results of even fairly simple analytic work flows are not reproducible because the software is generally not designed to record all of the tasks the user performed. This is particularly salient during development of analytic methods, during which a substantial amount of trial-and-error occurs. Another problem with ArcGIS in particular is that geoprocessing generally requires the user to specify the output file system location and file name for any analytic results. This introduces several  issues: (1) when an analyst is in the "zone," taking the time do decide where to put a data set and what to call it can break the flow of creativity; (2) accepting the default location and names of geoprocessing operations can result in a jumble of data with meaningless file names; (3) given an existing data set, how would the analyst know what work flow created this as a result? 

Approaching GIS analysis within an R framework addresses many of these problems:

1. Geoprocessing operations that are performed with programmatic code are reproducible. While ArcGIS and QGIS include Python for programmatic approaches, many researchers are already working with R, so only some new commands need to be learned, rather than an entire new language.
1. R is a language that is relatively easy to read and write, lowering the bar for entry.
1. R results are generally stored as `data frames` which can then be used by the many analytic functions in base R or in added packages.
1. Geoprocessing operations produce results that are stored in memory. This will be a problem for very large data sets and/or limited RAM. On the other hand, it does not force the analyst to decide the file system location and name of a data set at run time; code can be altered to store file system outputs after work flows are determined to have created correct results.
1. Files created using programmatic code can be traced back to the code that generated them (i.e., `find / -name "*.R" | xargs grep "myawesomedataset.gpkg"`).
1. Incorporating GIS analyses in R Markdown allows the analyst to create reports that include both the analytic code used to create results as well as to show results and even maps.

**What this course is**

This course will introduce students to the use of basic GIS functionalities within the R framework. By the end of the course, students will be able to import and export GIS data sets, perform coordinate transformations, perform some rudimentary GIS analyses, and produce simple interactive maps.

**What this course is <i>not</i>**

This course is not intended to teach fundamentals of GIS. We assume that students have at least a beginning to intermediate level of skill in the use of a desktop GIS software application such as ArcGIS Desktop or QGIS. This is also not an R course--it is expected that students will have a fundamental grasp of the use of R.

**Overview**

Each of the topics shown below will be covered during the course.

1. Getting started
1. Representation of spatial features
1. Data import/export
1. Projections and coordinate systems
1. GEoprocessing
    1. BUffering
    1. Point-in-polygon
    1. Polygon-on-polygon
<!--1. Raster functionality-->
1. Simple interactive maps with `leaflet` and `mapview`


## Source code
File is at `r fnamepath`.

### R code used in this document
```{r ref.label=knitr::all_labels(), echo=TRUE, eval=FALSE}
```

### Complete Rmd code
```{r comment=''}
cat(readLines(fnamepath), sep = '\n')
```
````
