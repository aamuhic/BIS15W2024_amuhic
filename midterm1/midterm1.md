---
title: "Midterm 1 W24"
author: "Amina Muhic"
date: "2024-02-06"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document. You may use your notes, labs, and homework to help you complete this exam. Do not use any other resources- including AI assistance.  

Don't forget to answer any questions that are asked in the prompt!  

Be sure to push your completed midterm to your repository. This exam is worth 30 points.  

## Background
In the data folder, you will find data related to a study on wolf mortality collected by the National Park Service. You should start by reading the `README_NPSwolfdata.pdf` file. This will provide an abstract of the study and an explanation of variables.  

The data are from: Cassidy, Kira et al. (2022). Gray wolf packs and human-caused wolf mortality. [Dryad](https://doi.org/10.5061/dryad.mkkwh713f). 

## Load the libraries

```r
library("tidyverse")
library("janitor")
```

## Load the wolves data
In these data, the authors used `NULL` to represent missing values. I am correcting this for you below and using `janitor` to clean the column names.

```r
wolves <- read.csv("data/NPS_wolfmortalitydata.csv", na = c("NULL")) %>% clean_names()
```

## Questions
Problem 1. (1 point) Let's start with some data exploration. What are the variable (column) names?  


```r
names(wolves)
```

```
##  [1] "park"         "biolyr"       "pack"         "packcode"     "packsize_aug"
##  [6] "mort_yn"      "mort_all"     "mort_lead"    "mort_nonlead" "reprody1"    
## [11] "persisty1"
```

Problem 2. (1 point) Use the function of your choice to summarize the data and get an idea of its structure. 


```r
glimpse(wolves)
```

```
## Rows: 864
## Columns: 11
## $ park         <chr> "DENA", "DENA", "DENA", "DENA", "DENA", "DENA", "DENA", "…
## $ biolyr       <int> 1996, 1991, 2017, 1996, 1992, 1994, 2007, 2007, 1995, 200…
## $ pack         <chr> "McKinley River1", "Birch Creek N", "Eagle Gorge", "East …
## $ packcode     <int> 89, 58, 71, 72, 74, 77, 101, 108, 109, 53, 63, 66, 70, 72…
## $ packsize_aug <dbl> 12, 5, 8, 13, 7, 6, 10, NA, 9, 8, 7, 11, 0, 19, 15, 12, 1…
## $ mort_yn      <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ mort_all     <int> 4, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ mort_lead    <int> 2, 2, 0, 0, 0, 0, 1, 2, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, …
## $ mort_nonlead <int> 2, 0, 2, 2, 2, 2, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, …
## $ reprody1     <int> 0, 0, NA, 1, NA, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1…
## $ persisty1    <int> 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, …
```

Problem 3. (3 points) Which parks/ reserves are represented in the data? Don't just use the abstract, pull this information from the data.  


```r
wolves$park <- as.factor(wolves$park)
levels(wolves$park)
```

```
## [1] "DENA" "GNTP" "VNP"  "YNP"  "YUCH"
```

Problem 4. (4 points) Which park has the largest number of wolf packs?


```r
wolves %>% 
  group_by(park) %>% 
  summarize(n_packs=n_distinct(packcode)) %>% 
  arrange(desc(n_packs))
```

```
## # A tibble: 5 × 2
##   park  n_packs
##   <fct>   <int>
## 1 DENA       69
## 2 YNP        46
## 3 YUCH       36
## 4 VNP        22
## 5 GNTP       12
```

Denali has the largest number of wolf packs.

Problem 5. (4 points) Which park has the highest total number of human-caused mortalities `mort_all`?


```r
wolves %>% 
  group_by(park) %>% 
  summarize(mort_total=sum(mort_all)) %>% 
  arrange(desc(mort_total))
```

```
## # A tibble: 5 × 2
##   park  mort_total
##   <fct>      <int>
## 1 YUCH         136
## 2 YNP           72
## 3 DENA          64
## 4 GNTP          38
## 5 VNP           11
```

Yukon-Charley has the highest total number of human-caused mortalities. 

The wolves in [Yellowstone National Park](https://www.nps.gov/yell/learn/nature/wolf-restoration.htm) are an incredible conservation success story. Let's focus our attention on this park.  

Problem 6. (2 points) Create a new object "ynp" that only includes the data from Yellowstone National Park.


```r
ynp <- wolves %>% 
  filter(park=="YNP")
```


```r
head(ynp)
```

```
##   park biolyr       pack packcode packsize_aug mort_yn mort_all mort_lead
## 1  YNP   2009 cottonwood       23           12       1        4         1
## 2  YNP   2016      8mile       11           20       1        3         0
## 3  YNP   2017     canyon       20            2       1        3         3
## 4  YNP   2012   junction       33           11       1        3         0
## 5  YNP   2016   junction       33           15       1        3         0
## 6  YNP   2011  642Fgroup        5           10       1        2         1
##   mort_nonlead reprody1 persisty1
## 1            3        0         0
## 2            3        1         1
## 3            0        0         0
## 4            3        1         1
## 5            3        1         1
## 6            1        0         0
```

```r
tail(ynp)
```

```
##     park biolyr      pack packcode packsize_aug mort_yn mort_all mort_lead
## 243  YNP   2006 yelldelta       52           15       0        0         0
## 244  YNP   2009 yelldelta       52            4       0        0         0
## 245  YNP   2010 yelldelta       52            9       0        0         0
## 246  YNP   2011 yelldelta       52           13       0        0         0
## 247  YNP   2012 yelldelta       52           11       0        0         0
## 248  YNP   2013 yelldelta       52           17       0        0         0
##     mort_nonlead reprody1 persisty1
## 243            0        1         1
## 244            0        1         1
## 245            0        1         1
## 246            0        0         1
## 247            0        1         1
## 248            0        1         1
```

Problem 7. (3 points) Among the Yellowstone wolf packs, the [Druid Peak Pack](https://www.pbs.org/wnet/nature/in-the-valley-of-the-wolves-the-druid-wolf-pack-story/209/) is one of most famous. What was the average pack size of this pack for the years represented in the data?


```r
ynp %>% 
  filter(pack=="druid") %>% 
  summarize(mean_size=mean(packsize_aug))
```

```
##   mean_size
## 1  13.93333
```

Problem 8. (4 points) Pack dynamics can be hard to predict- even for strong packs like the Druid Peak pack. At which year did the Druid Peak pack have the largest pack size? What do you think happened in 2010?


```r
ynp %>% 
  select(park, pack, biolyr, packsize_aug) %>% 
  filter(pack=="druid") %>% 
  arrange(desc(packsize_aug)) 
```

```
##    park  pack biolyr packsize_aug
## 1   YNP druid   2001           37
## 2   YNP druid   2000           27
## 3   YNP druid   2008           21
## 4   YNP druid   2003           18
## 5   YNP druid   2007           18
## 6   YNP druid   2002           16
## 7   YNP druid   2006           15
## 8   YNP druid   2004           13
## 9   YNP druid   2009           12
## 10  YNP druid   1999            9
## 11  YNP druid   1998            8
## 12  YNP druid   1997            5
## 13  YNP druid   1996            5
## 14  YNP druid   2005            5
## 15  YNP druid   2010            0
```

The Druid Pack was at its largest size in 2001 at 37 wolves, and at its lowest in 2010 at 0 wolves.


```r
ynp %>% 
  select(park, pack, biolyr, packsize_aug, mort_yn) %>% 
  filter(pack=="druid") %>% 
  arrange(desc(biolyr))
```

```
##    park  pack biolyr packsize_aug mort_yn
## 1   YNP druid   2010            0       0
## 2   YNP druid   2009           12       0
## 3   YNP druid   2008           21       0
## 4   YNP druid   2007           18       0
## 5   YNP druid   2006           15       0
## 6   YNP druid   2005            5       0
## 7   YNP druid   2004           13       0
## 8   YNP druid   2003           18       0
## 9   YNP druid   2002           16       0
## 10  YNP druid   2001           37       0
## 11  YNP druid   2000           27       1
## 12  YNP druid   1999            9       0
## 13  YNP druid   1998            8       0
## 14  YNP druid   1997            5       1
## 15  YNP druid   1996            5       0
```

The pack size dropped down to 0 in 2010. Given that there were no human caused moralities (`mortYN`) in 2010 and the years leading up to it (2009-2001), I don't think the drop in pack size is due to human-led hunting or eradication efforts. For one reason or another, the entire Druid pack seemed to have moved out of Yellow Stone in 2010; perhaps in search of better food and shelter, or maybe because they were displaced by another wolf pack.

Problem 9. (5 points) Among the YNP wolf packs, which one has had the highest overall persistence `persisty1` for the years represented in the data? Look this pack up online and tell me what is unique about its behavior- specifically, what prey animals does this pack specialize on?


```r
ynp %>% 
  group_by(pack) %>% 
  summarize(overall_persistence=sum(persisty1)) %>% 
  arrange(desc(overall_persistence))
```

```
## # A tibble: 46 × 2
##    pack        overall_persistence
##    <chr>                     <int>
##  1 mollies                      26
##  2 cougar                       20
##  3 yelldelta                    18
##  4 leopold                      12
##  5 agate                        10
##  6 8mile                         9
##  7 canyon                        9
##  8 gibbon/mary                   9
##  9 junction                      8
## 10 lamar                         8
## # ℹ 36 more rows
```

Mollie's pack specializes in hunting bison, which is unique to them as a wolf pack. This likely contributes to their persistence! 

Problem 10. (3 points) Perform one analysis or exploration of your choice on the `wolves` data. Your answer needs to include at least two lines of code and not be a summary function.

Among the grey wolves in Denali National Park, which pack had the largest pack size in the year 2002?

```r
wolves %>% 
  select(park, biolyr, pack, packsize_aug) %>% 
  filter(park=="DENA") %>% 
  filter(biolyr==2002) %>% 
  arrange(desc(packsize_aug))
```

```
##    park biolyr            pack packsize_aug
## 1  DENA   2002        100 Mile           14
## 2  DENA   2002    Straightaway           12
## 3  DENA   2002          Herron           10
## 4  DENA   2002     Mt Margaret           10
## 5  DENA   2002     Pinto Creek           10
## 6  DENA   2002 McKinley Slough            7
## 7  DENA   2002 Kantishna River            5
## 8  DENA   2002       East Fork            4
## 9  DENA   2002         Brooker            2
## 10 DENA   2002    Death Valley            2
## 11 DENA   2002     Grant Creek            2
## 12 DENA   2002     Muddy River            2
## 13 DENA   2002      Starr Lake            2
```

The 100 Mile Pack had the largest pack size in Denali in 2002.
