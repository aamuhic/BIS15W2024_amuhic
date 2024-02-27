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

1. load the data

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## Rows: 4033 Columns: 6
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (2): lakeid, annnumber
## dbl (4): fish_id, length, radii_length_mm, scalelength
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```
2. transform `fish` data to only include 2 variables: lakeid and length

```r
fishlength <- select(fish, "lakeid", "length")
fishlength
```

```
## # A tibble: 4,033 × 2
##    lakeid length
##    <chr>   <dbl>
##  1 AL        167
##  2 AL        167
##  3 AL        167
##  4 AL        175
##  5 AL        175
##  6 AL        175
##  7 AL        175
##  8 AL        194
##  9 AL        194
## 10 AL        194
## # ℹ 4,023 more rows
```
* only use `data.frame` if you're working with raw data - don't need to here since `fish` is already a data frame..

3. filter `fish` for fish from lake BO

```r
bo_fish <- filter(fish, lakeid == "BO")
bo_fish
```

```
## # A tibble: 197 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 BO         389 EDGE         104           1.50         1.50
##  2 BO         389 1            104           0.736        1.50
##  3 BO         390 EDGE         105           1.59         1.59
##  4 BO         390 1            105           0.698        1.59
##  5 BO         391 EDGE         107           1.43         1.43
##  6 BO         391 1            107           0.695        1.43
##  7 BO         392 EDGE         124           2.11         2.11
##  8 BO         392 2            124           1.36         2.11
##  9 BO         392 1            124           0.792        2.11
## 10 BO         393 EDGE         141           2.16         2.16
## # ℹ 187 more rows
```
* might be better to categorize as factor: `fish$lakeid <- as.factor(fish$lakeid)` before you filter

4. what is the mean length of fish from lake BO?

```r
mean(bo_fish$length)
```

```
## [1] 285.8173
```

