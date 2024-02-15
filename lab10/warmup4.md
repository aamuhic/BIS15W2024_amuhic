---
output: 
  html_document: 
    keep_md: yes
---

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
library(dplyr)
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



```r
malaria <- readr::read_csv("data/malaria.csv") %>% clean_names()
```

```
## Rows: 3038 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (3): location_name, Province, District
## dbl  (5): malaria_rdt_0-4, malaria_rdt_5-14, malaria_rdt_15, malaria_tot, newid
## date (2): data_date, submitted_date
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
names(malaria)
```

```
##  [1] "location_name"    "data_date"        "submitted_date"   "province"        
##  [5] "district"         "malaria_rdt_0_4"  "malaria_rdt_5_14" "malaria_rdt_15"  
##  [9] "malaria_tot"      "newid"
```


```r
malaria_tidy <- malaria %>% 
  pivot_longer(col = starts_with("malaria_rdt"),
               names_to = "age_group",
               values_to = "rdt")
malaria_tidy
```

```
## # A tibble: 9,114 × 9
##    location_name data_date  submitted_date province district malaria_tot newid
##    <chr>         <date>     <date>         <chr>    <chr>          <dbl> <dbl>
##  1 Facility 1    2020-08-11 2020-08-12     North    Spring            46     1
##  2 Facility 1    2020-08-11 2020-08-12     North    Spring            46     1
##  3 Facility 1    2020-08-11 2020-08-12     North    Spring            46     1
##  4 Facility 2    2020-08-11 2020-08-12     North    Bolo              26     2
##  5 Facility 2    2020-08-11 2020-08-12     North    Bolo              26     2
##  6 Facility 2    2020-08-11 2020-08-12     North    Bolo              26     2
##  7 Facility 3    2020-08-11 2020-08-12     North    Dingo             18     3
##  8 Facility 3    2020-08-11 2020-08-12     North    Dingo             18     3
##  9 Facility 3    2020-08-11 2020-08-12     North    Dingo             18     3
## 10 Facility 4    2020-08-11 2020-08-12     North    Bolo              49     4
## # ℹ 9,104 more rows
## # ℹ 2 more variables: age_group <chr>, rdt <dbl>
```


```r
malaria_tidy %>% 
  filter(data_date=="2020-7-30") %>% 
  group_by(district) %>% 
  summarize(n_case=sum(malaria_tot, na.rm = TRUE)) %>% 
  arrange(desc(n_case))
```

```
## # A tibble: 4 × 2
##   district n_case
##   <chr>     <dbl>
## 1 Bolo       1041
## 2 Dingo       654
## 3 Spring      420
## 4 Barnard     231
```
_Bolo had the highest number of cases on July 30, 2020._
