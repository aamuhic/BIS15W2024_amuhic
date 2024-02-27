---
title: "Midterm 2 W24"
author: "Amina Muhic"
date: "2024-02-27"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document. You may use your notes, labs, and homework to help you complete this exam. Do not use any other resources- including AI assistance.  

Don't forget to answer any questions that are asked in the prompt. Some questions will require a plot, but others do not- make sure to read each question carefully.  

For the questions that require a plot, make sure to have clearly labeled axes and a title. Keep your plots clean and professional-looking, but you are free to add color and other aesthetics.  

Be sure to follow the directions and upload your exam on Gradescope.    

## Background
In the `data` folder, you will find data about shark incidents in California between 1950-2022. The [data](https://catalog.data.gov/dataset/shark-incident-database-california-56167) are from: State of California- Shark Incident Database.   

## Load the libraries

```r
library("tidyverse")
library("janitor")
library("naniar")
```


```r
library(RColorBrewer)
```

## Load the data
Run the following code chunk to import the data.

```r
sharks <- read_csv("data/SharkIncidents_1950_2022_220302.csv") %>% clean_names()
```

## Questions
1. (1 point) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?  


```r
glimpse(sharks)
```

```
## Rows: 211
## Columns: 16
## $ incident_num     <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1…
## $ month            <dbl> 10, 5, 12, 2, 8, 4, 10, 5, 6, 7, 10, 11, 4, 5, 5, 8, …
## $ day              <dbl> 8, 27, 7, 6, 14, 28, 12, 7, 14, 28, 4, 10, 24, 19, 21…
## $ year             <dbl> 1950, 1952, 1952, 1955, 1956, 1957, 1958, 1959, 1959,…
## $ time             <chr> "12:00", "14:00", "14:00", "12:00", "16:30", "13:30",…
## $ county           <chr> "San Diego", "San Diego", "Monterey", "Monterey", "Sa…
## $ location         <chr> "Imperial Beach", "Imperial Beach", "Lovers Point", "…
## $ mode             <chr> "Swimming", "Swimming", "Swimming", "Freediving", "Sw…
## $ injury           <chr> "major", "minor", "fatal", "minor", "major", "fatal",…
## $ depth            <chr> "surface", "surface", "surface", "surface", "surface"…
## $ species          <chr> "White", "White", "White", "White", "White", "White",…
## $ comment          <chr> "Body Surfing, bit multiple times on leg, thigh and b…
## $ longitude        <chr> "-117.1466667", "-117.2466667", "-122.05", "-122.15",…
## $ latitude         <dbl> 32.58833, 32.58833, 36.62667, 36.62667, 35.13833, 35.…
## $ confirmed_source <chr> "Miller/Collier, Coronado Paper, Oceanside Paper", "G…
## $ wfl_case_number  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
```

```r
summary(sharks)
```

```
##  incident_num           month             day             year     
##  Length:211         Min.   : 1.000   Min.   : 1.00   Min.   :1950  
##  Class :character   1st Qu.: 6.000   1st Qu.: 7.50   1st Qu.:1985  
##  Mode  :character   Median : 8.000   Median :18.00   Median :2004  
##                     Mean   : 7.858   Mean   :16.54   Mean   :1998  
##                     3rd Qu.:10.000   3rd Qu.:25.00   3rd Qu.:2014  
##                     Max.   :12.000   Max.   :31.00   Max.   :2022  
##                                                                    
##      time              county            location             mode          
##  Length:211         Length:211         Length:211         Length:211        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     injury             depth             species            comment         
##  Length:211         Length:211         Length:211         Length:211        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##   longitude            latitude     confirmed_source   wfl_case_number   
##  Length:211         Min.   :32.59   Length:211         Length:211        
##  Class :character   1st Qu.:34.04   Class :character   Class :character  
##  Mode  :character   Median :36.70   Mode  :character   Mode  :character  
##                     Mean   :36.36                                        
##                     3rd Qu.:38.18                                        
##                     Max.   :41.56                                        
##                     NA's   :6
```

```r
miss_var_summary(sharks)
```

```
## # A tibble: 16 × 3
##    variable         n_miss pct_miss
##    <chr>             <int>    <dbl>
##  1 wfl_case_number     202   95.7  
##  2 time                  7    3.32 
##  3 latitude              6    2.84 
##  4 longitude             5    2.37 
##  5 confirmed_source      1    0.474
##  6 incident_num          0    0    
##  7 month                 0    0    
##  8 day                   0    0    
##  9 year                  0    0    
## 10 county                0    0    
## 11 location              0    0    
## 12 mode                  0    0    
## 13 injury                0    0    
## 14 depth                 0    0    
## 15 species               0    0    
## 16 comment               0    0
```

_NAs are represented with "NA"; "NOT COUNTED" represents a type of incident we don't want to consider, I assume._

2. (1 point) Notice that there are some incidents identified as "NOT COUNTED". These should be removed from the data because they were either not sharks, unverified, or were provoked. It's OK to replace the `sharks` object.


```r
sharks <- sharks %>% 
  filter(incident_num != "NOT COUNTED")
```


```r
head(sharks)
```

```
## # A tibble: 6 × 16
##   incident_num month   day  year time  county        location mode  injury depth
##   <chr>        <dbl> <dbl> <dbl> <chr> <chr>         <chr>    <chr> <chr>  <chr>
## 1 1               10     8  1950 12:00 San Diego     Imperia… Swim… major  surf…
## 2 2                5    27  1952 14:00 San Diego     Imperia… Swim… minor  surf…
## 3 3               12     7  1952 14:00 Monterey      Lovers … Swim… fatal  surf…
## 4 4                2     6  1955 12:00 Monterey      Pacific… Free… minor  surf…
## 5 5                8    14  1956 16:30 San Luis Obi… Pismo B… Swim… major  surf…
## 6 6                4    28  1957 13:30 San Luis Obi… Morro B… Swim… fatal  surf…
## # ℹ 6 more variables: species <chr>, comment <chr>, longitude <chr>,
## #   latitude <dbl>, confirmed_source <chr>, wfl_case_number <chr>
```

3. (3 points) Are there any "hotspots" for shark incidents in California? Make a plot that shows the total number of incidents per county. Which county has the highest number of incidents?


```r
sharks %>% 
  count(county) %>% 
  ggplot(aes(x=reorder(county, n), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  coord_flip() +
  labs(title="Number of Shark Incidents by County",
       x=NULL,
       y="# of incidents") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

_San Diego County has the highest number of incidents._

4. (3 points) Are there months of the year when incidents are more likely to occur? Make a plot that shows the total number of incidents by month. Which month has the highest number of incidents?  


```r
sharks %>% 
  mutate(month=as.factor(month)) %>% 
  count(month) %>% 
  ggplot(aes(x=month, y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  labs(title="Number of Shark Incidents by Month",
       x=NULL,
       y="# of incidents") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

_The 10th month, October, has the highest number of incidents._

5. (3 points) How do the number and types of injuries compare by county? Make a table (not a plot) that shows the number of injury types by county. Which county has the highest number of fatalities?  


```r
sharks %>% 
  group_by(county, injury) %>% 
  summarize(n_injury=n(), .groups = "keep") %>% 
  pivot_wider(names_from = injury,
              values_from = n_injury) %>% 
  arrange(desc(fatal))
```

```
## # A tibble: 21 × 5
## # Groups:   county [21]
##    county              minor  none major fatal
##    <chr>               <int> <int> <int> <int>
##  1 San Luis Obispo         1     7     3     3
##  2 Monterey                2     3     8     2
##  3 San Diego               8     9     4     2
##  4 Santa Barbara           6     9     2     2
##  5 Island - San Miguel     2    NA     2     1
##  6 Los Angeles             6     2    NA     1
##  7 Mendocino               1    NA     3     1
##  8 San Francisco          NA     1    NA     1
##  9 San Mateo               4    12     1     1
## 10 Santa Cruz              3     8     3     1
## # ℹ 11 more rows
```

_San Luis Obispo has had the highest number of fatalities._

6. (2 points) In the data, `mode` refers to a type of activity. Which activity is associated with the highest number of incidents?


```r
sharks %>% 
  count(mode) %>% 
  arrange(desc(n))
```

```
## # A tibble: 7 × 2
##   mode                    n
##   <chr>               <int>
## 1 Surfing / Boarding     80
## 2 Freediving             35
## 3 Kayaking / Canoeing    29
## 4 Swimming               22
## 5 Scuba Diving           19
## 6 Hookah Diving          10
## 7 Paddleboarding          7
```

_Surfing/boarding is associated with the highest number of incidents._

7. (4 points) Use faceting to make a plot that compares the number and types of injuries by activity. (hint: the x axes should be the type of injury) 


```r
sharks %>% 
  ggplot(aes(x=injury, fill=injury)) +
  geom_bar(color="black", alpha=0.5) +
  facet_wrap(~mode) +
  scale_fill_brewer(palette = "Paired") +
   labs(title="Number and Type of Injuries by Activity",
       x=NULL,
       y="n",
       fill="Injury") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.text.x = element_text(angle = 60, hjust = 1),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

8. (1 point) Which shark species is involved in the highest number of incidents?  

```r
sharks %>% 
  count(species) %>% 
  arrange(desc(n))
```

```
## # A tibble: 8 × 2
##   species        n
##   <chr>      <int>
## 1 White        179
## 2 Unknown       13
## 3 Hammerhead     3
## 4 Blue           2
## 5 Leopard        2
## 6 Salmon         1
## 7 Sevengill      1
## 8 Thresher       1
```

_The Great White Shark._


```r
sharks %>% 
  count(species) %>% 
  ggplot(aes(x=reorder(species, n), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  coord_flip() +
  labs(title="Number of Incidents by Species",
       x=NULL,
       y="# of incidents") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

9. (3 points) Are all incidents involving Great White's fatal? Make a plot that shows the number and types of injuries for Great White's only.  


```r
sharks %>% 
  filter(species == "White") %>% 
  count(injury)
```

```
## # A tibble: 4 × 2
##   injury     n
##   <chr>  <int>
## 1 fatal     15
## 2 major     59
## 3 minor     31
## 4 none      74
```


```r
sharks %>% 
  filter(species == "White") %>% 
  count(injury) %>% 
  ggplot(aes(x=injury, y=n, fill=injury)) +
  geom_col(color="black", alpha=0.5) +
  scale_fill_brewer(palette = "Paired") +
   labs(title="Types of Injuries by Great White Sharks",
       x=NULL,
       y="# of incidents") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

_Most incidents with Great White Sharks result in no injury._

## Background
Let's learn a little bit more about Great White sharks by looking at a small dataset that tracked 20 Great White's in the Fallaron Islands. The [data](https://link.springer.com/article/10.1007/s00227-007-0739-4) are from: Weng et al. (2007) Migration and habitat of white sharks (_Carcharodon carcharias_) in the eastern Pacific Ocean.

## Load the data

```r
white_sharks <- read_csv("data/White sharks tracked from Southeast Farallon Island, CA, USA, 1999 2004.csv", na = c("?", "n/a")) %>% clean_names()
```

10. (1 point) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?


```r
glimpse(white_sharks)
```

```
## Rows: 20
## Columns: 10
## $ shark           <chr> "1-M", "2-M", "3-M", "4-M", "5-F", "6-M", "7-F", "8-M"…
## $ tagging_date    <chr> "19-Oct-99", "30-Oct-99", "16-Oct-00", "5-Nov-01", "5-…
## $ total_length_cm <dbl> 402, 366, 457, 457, 488, 427, 442, 380, 450, 530, 427,…
## $ sex             <chr> "M", "M", "M", "M", "F", "M", "F", "M", "M", "F", NA, …
## $ maturity        <chr> "Mature", "Adolescent", "Mature", "Mature", "Mature", …
## $ pop_up_date     <chr> "2-Nov-99", "25-Nov-99", "16-Apr-01", "6-May-02", "19-…
## $ track_days      <dbl> 14, 26, 182, 182, 256, 275, 35, 60, 209, 91, 182, 240,…
## $ longitude       <dbl> -124.49, -125.97, -156.80, -141.47, -133.25, -138.83, …
## $ latitude        <dbl> 38.95, 38.69, 20.67, 26.39, 21.13, 26.50, 37.07, 34.93…
## $ comment         <chr> "Nearshore", "Nearshore", "To Hawaii", "To Hawaii", "O…
```


```r
summary(white_sharks)
```

```
##     shark           tagging_date       total_length_cm     sex           
##  Length:20          Length:20          Min.   :360.0   Length:20         
##  Class :character   Class :character   1st Qu.:400.5   Class :character  
##  Mode  :character   Mode  :character   Median :434.5   Mode  :character  
##                                        Mean   :436.1                     
##                                        3rd Qu.:457.0                     
##                                        Max.   :530.0                     
##                                                                          
##    maturity         pop_up_date          track_days      longitude     
##  Length:20          Length:20          Min.   : 14.0   Min.   :-156.8  
##  Class :character   Class :character   1st Qu.: 85.0   1st Qu.:-137.8  
##  Mode  :character   Mode  :character   Median :182.0   Median :-133.2  
##                                        Mean   :166.8   Mean   :-120.3  
##                                        3rd Qu.:216.8   3rd Qu.:-124.3  
##                                        Max.   :367.0   Max.   : 131.7  
##                                                        NA's   :1       
##     latitude       comment         
##  Min.   :20.67   Length:20         
##  1st Qu.:22.48   Class :character  
##  Median :26.39   Mode  :character  
##  Mean   :28.24                     
##  3rd Qu.:36.00                     
##  Max.   :38.95                     
##  NA's   :1
```


```r
miss_var_summary(white_sharks)
```

```
## # A tibble: 10 × 3
##    variable        n_miss pct_miss
##    <chr>            <int>    <dbl>
##  1 sex                  3       15
##  2 maturity             1        5
##  3 longitude            1        5
##  4 latitude             1        5
##  5 shark                0        0
##  6 tagging_date         0        0
##  7 total_length_cm      0        0
##  8 pop_up_date          0        0
##  9 track_days           0        0
## 10 comment              0        0
```

11. (3 points) How do male and female sharks compare in terms of total length? Are males or females larger on average? Do a quick search online to verify your findings. (hint: this is a table, not a plot).  

```r
white_sharks %>% 
  filter(sex != "NA") %>% 
  group_by(sex) %>% 
  summarize(avg_length=mean(total_length_cm))
```

```
## # A tibble: 2 × 2
##   sex   avg_length
##   <chr>      <dbl>
## 1 F           462 
## 2 M           425.
```

_Females are larger, on average (confirmed by Google search)._

12. (3 points) Make a plot that compares the range of total length by sex.


```r
white_sharks %>% 
  filter(sex != "NA") %>% 
  ggplot(aes(x=sex, y=total_length_cm, fill=sex)) +
  geom_boxplot(alpha=0.5) +
   labs(title="Range of GWS Length by Sex",
       x=NULL,
       y="Total Length (cm)",
       fill="Sex") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

13. (2 points) Using the `sharks` or the `white_sharks` data, what is one question that you are interested in exploring? Write the question and answer it using a plot or table.  

How does the range of length compare between maturity levels? How does this vary between the sexes?


```r
white_sharks %>% 
  filter(sex != "NA") %>% 
  ggplot(aes(x=maturity, y=total_length_cm, fill=maturity)) +
  geom_boxplot(alpha=0.5) +
  facet_wrap(~sex) +
  scale_fill_brewer(palette = "Paired") +
   labs(title="Range of GWS Length by Maturity",
       x=NULL,
       y="Total Length (cm)") +
  theme(plot.title = element_text(size=12, face="bold"),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10))
```

![](midterm2_files/figure-html/unnamed-chunk-24-1.png)<!-- -->
