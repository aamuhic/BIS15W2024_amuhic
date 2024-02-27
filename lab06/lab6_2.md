---
title: "dplyr Superhero"
date: "2024-01-31"
output:
  html_document: 
    theme: spacelab
    toc: true
    toc_float: true
    keep_md: true
---

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries

```r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
# don't clean up the data until you really understand it!
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    

```r
superhero_info <- clean_names(superhero_info)
superhero_powers <- clean_names(superhero_powers)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

```r
tabyl(superhero_info, publisher) %>% arrange(desc(n))
```

```
##          publisher   n     percent valid_percent
##      Marvel Comics 388 0.528610354   0.539638387
##          DC Comics 215 0.292915531   0.299026426
##       NBC - Heroes  19 0.025885559   0.026425591
##  Dark Horse Comics  18 0.024523161   0.025034771
##               <NA>  15 0.020435967            NA
##       George Lucas  14 0.019073569   0.019471488
##       Image Comics  14 0.019073569   0.019471488
##      HarperCollins   6 0.008174387   0.008344924
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        ABC Studios   4 0.005449591   0.005563282
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##           Shueisha   4 0.005449591   0.005563282
##          Wildstorm   3 0.004087193   0.004172462
##      Sony Pictures   2 0.002724796   0.002781641
##      Hanna-Barbera   1 0.001362398   0.001390821
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##          Microsoft   1 0.001362398   0.001390821
##          Rebellion   1 0.001362398   0.001390821
##         South Park   1 0.001362398   0.001390821
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
```
Marvel has the highest number of superheros

2. Notice that we have some neutral superheros! Who are they? List their names below.  

```r
superhero_info %>%
  filter(alignment == "neutral") %>% 
  select(name, alignment)
```

```
## # A tibble: 24 × 2
##    name         alignment
##    <chr>        <chr>    
##  1 Bizarro      neutral  
##  2 Black Flash  neutral  
##  3 Captain Cold neutral  
##  4 Copycat      neutral  
##  5 Deadpool     neutral  
##  6 Deathstroke  neutral  
##  7 Etrigan      neutral  
##  8 Galactus     neutral  
##  9 Gladiator    neutral  
## 10 Indigo       neutral  
## # ℹ 14 more rows
```

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superhero_info %>% 
  select(name, alignment, race)
```

```
## # A tibble: 734 × 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ℹ 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
superhero_info %>% 
  select(name, alignment, race) %>% 
  filter(race != "Human")
```

```
## # A tibble: 222 × 3
##    name         alignment race             
##    <chr>        <chr>     <chr>            
##  1 Abe Sapien   good      Icthyo Sapien    
##  2 Abin Sur     good      Ungaran          
##  3 Abomination  bad       Human / Radiation
##  4 Abraxas      bad       Cosmic Entity    
##  5 Ajax         bad       Cyborg           
##  6 Alien        bad       Xenomorph XX121  
##  7 Amazo        bad       Android          
##  8 Angel        good      Vampire          
##  9 Angel Dust   good      Mutant           
## 10 Anti-Monitor bad       God / Eternal    
## # ℹ 212 more rows
```
note that "not human" includes human hybrids (i.e., "Human / Cosmic").

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good_guys <- superhero_info %>% 
  filter(alignment == "good")
```


```r
bad_guys <- superhero_info %>% 
  filter(alignment == "bad")
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
tabyl(good_guys, race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Vampires?

```r
good_guys %>% 
  filter(race == "Vampire") %>% 
  select(name, race)
```

```
## # A tibble: 2 × 2
##   name  race   
##   <chr> <chr>  
## 1 Angel Vampire
## 2 Blade Vampire
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad_guys %>% 
  filter(gender == "Male" & race == "Human" & height >= 200) %>% 
  select(name, gender, race, height)
```

```
## # A tibble: 5 × 4
##   name        gender race  height
##   <chr>       <chr>  <chr>  <dbl>
## 1 Bane        Male   Human    203
## 2 Doctor Doom Male   Human    201
## 3 Kingpin     Male   Human    201
## 4 Lizard      Male   Human    203
## 5 Scorpion    Male   Human    211
```

9. Are there more good guys or bad guys with green hair?  

```r
good_guys %>% 
  filter(hair_color == "Green") %>% 
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1     7
```


```r
bad_guys %>% 
  filter(hair_color == "Green") %>% 
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1     1
```
There are more good guys with green hair.

10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  

```r
superhero_info %>% 
  select(name, weight) %>% 
  filter(weight < 50) %>% 
  arrange(weight)
```

```
## # A tibble: 19 × 2
##    name              weight
##    <chr>              <dbl>
##  1 Iron Monger            2
##  2 Groot                  4
##  3 Jack-Jack             14
##  4 Galactus              16
##  5 Yoda                  17
##  6 Fin Fang Foom         18
##  7 Howard the Duck       18
##  8 Krypto                18
##  9 Rocket Raccoon        25
## 10 Dash                  27
## 11 Longshot              36
## 12 Robin V               38
## 13 Wiz Kid               39
## 14 Violet Parr           41
## 15 Franklin Richards     45
## 16 Swarm                 47
## 17 Hope Summers          48
## 18 Jolt                  49
## 19 Snowbird              49
```


11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    

```r
superhero_info %>% 
  mutate(height_weight_ratio = height / weight) %>% 
  select(name, height, weight, height_weight_ratio)
```

```
## # A tibble: 734 × 4
##    name          height weight height_weight_ratio
##    <chr>          <dbl>  <dbl>               <dbl>
##  1 A-Bomb           203    441               0.460
##  2 Abe Sapien       191     65               2.94 
##  3 Abin Sur         185     90               2.06 
##  4 Abomination      203    441               0.460
##  5 Abraxas           NA     NA              NA    
##  6 Absorbing Man    193    122               1.58 
##  7 Adam Monroe       NA     NA              NA    
##  8 Adam Strange     185     88               2.10 
##  9 Agent 13         173     61               2.84 
## 10 Agent Bob        178     81               2.20 
## # ℹ 724 more rows
```

12. Who has the highest height to weight ratio?  

```r
superhero_info %>% 
  mutate(height_weight_ratio = height / weight) %>% 
  select(name, height, weight, height_weight_ratio) %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 4
##    name            height weight height_weight_ratio
##    <chr>            <dbl>  <dbl>               <dbl>
##  1 Groot              701      4              175.  
##  2 Galactus           876     16               54.8 
##  3 Fin Fang Foom      975     18               54.2 
##  4 Longshot           188     36                5.22
##  5 Jack-Jack           71     14                5.07
##  6 Rocket Raccoon     122     25                4.88
##  7 Dash               122     27                4.52
##  8 Howard the Duck     79     18                4.39
##  9 Swarm              196     47                4.17
## 10 Yoda                66     17                3.88
## # ℹ 724 more rows
```
Groot has the largest height/weight ratio.

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

13. How many superheros have a combination of agility, stealth, super_strength, stamina?

```r
superhero_powers %>% 
  filter(agility & stealth & super_strength & stamina) %>% 
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1    40
```

## Your Favorite
14. Pick your favorite superhero and let's see their powers!

```r
superhero_powers %>% 
  filter(hero_names == "Spider-Man") %>% 
  select_if(all)
```

```
## Warning in .p(column, ...): coercing argument of type 'character' to logical
```

```
## # A tibble: 1 × 20
##   agility accelerated_healing durability stealth danger_sense marksmanship
##   <lgl>   <lgl>               <lgl>      <lgl>   <lgl>        <lgl>       
## 1 TRUE    TRUE                TRUE       TRUE    TRUE         TRUE        
## # ℹ 14 more variables: animal_attributes <lgl>, super_strength <lgl>,
## #   stamina <lgl>, super_speed <lgl>, animal_oriented_powers <lgl>,
## #   enhanced_senses <lgl>, jump <lgl>, reflexes <lgl>,
## #   substance_secretion <lgl>, natural_weapons <lgl>,
## #   toxin_and_disease_resistance <lgl>, wallcrawling <lgl>, vision_night <lgl>,
## #   web_creation <lgl>
```

15. Can you find your hero in the superhero_info data? Show their info!  

```r
superhero_info %>% 
  filter(name == "Spider-Man")
```

```
## # A tibble: 3 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Spide… Male   hazel     Human Brown         178 Marvel C… <NA>       good     
## 2 Spide… <NA>   red       Human Brown         178 Marvel C… <NA>       good     
## 3 Spide… Male   brown     Human Black         157 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```
There are a few Spider-Men in the data!

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  