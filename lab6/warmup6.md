---
output: 
  html_document: 
    keep_md: yes
---
## Lab 6 Warmup

library calls

```r
library(tidyverse)
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

1. load the `bison.csv` data

```r
bison <- readr::read_csv("data/bison.csv")
```

```
## Rows: 8325 Columns: 8
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (3): data_code, animal_code, animal_sex
## dbl (5): rec_year, rec_month, rec_day, animal_weight, animal_yob
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

2. what are the dimesions and structure of the data?

```r
dim(bison)
```

```
## [1] 8325    8
```


```r
glimpse(bison)
```

```
## Rows: 8,325
## Columns: 8
## $ data_code     <chr> "CBH01", "CBH01", "CBH01", "CBH01", "CBH01", "CBH01", "C…
## $ rec_year      <dbl> 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 19…
## $ rec_month     <dbl> 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, …
## $ rec_day       <dbl> 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,…
## $ animal_code   <chr> "813", "834", "B-301", "B-402", "B-403", "B-502", "B-503…
## $ animal_sex    <chr> "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "…
## $ animal_weight <dbl> 890, 1074, 1060, 989, 1062, 978, 1068, 1024, 978, 1188, …
## $ animal_yob    <dbl> 1981, 1983, 1983, 1984, 1984, 1985, 1985, 1985, 1986, 19…
```

3. we are only interested in code, sex, weight, year of birth. restrict the data to these variables and store the dataframe as a new object.

```r
bison_new <- bison %>% 
  select("data_code", "animal_sex", "animal_weight", "animal_yob")
```

4. pull out the animals born between 1980 and 1990

```r
bison_new %>% 
  filter(animal_yob %in% c(1980, 1990))
```

```
## # A tibble: 82 × 4
##    data_code animal_sex animal_weight animal_yob
##    <chr>     <chr>              <dbl>      <dbl>
##  1 CBH01     F                    930       1990
##  2 CBH01     F                    950       1990
##  3 CBH01     F                    917       1990
##  4 CBH01     F                    900       1990
##  5 CBH01     F                    884       1990
##  6 CBH01     M                   1552       1990
##  7 CBH01     M                   1572       1990
##  8 CBH01     M                   1538       1990
##  9 CBH01     F                    952       1990
## 10 CBH01     M                   1422       1990
## # ℹ 72 more rows
```

5. how many male and female bison are represented between 1980 and 1990?

```r
bison_aged <- bison_new %>% 
  filter(animal_yob %in% c(1980, 1990))
table(bison_aged$animal_sex)
```

```
## 
##  F  M 
## 70 12
```

6. between 1980-1990, were males or females larger on average?

```r
bison_aged_f <- filter(bison_aged, animal_sex == "F")
mean(bison_aged_f$animal_weight, na.rm = T)
```

```
## [1] 932.9571
```


```r
bison_aged_m <- filter(bison_aged, animal_sex == "M")
mean(bison_aged_m$animal_weight, na.rm = T)
```

```
## [1] 1469.333
```
Males are larger on average between 1980-1990.
