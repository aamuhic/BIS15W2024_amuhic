---
title: "Extra Credit W24"
author: "Amina Muhic"
date: "2024-03-06"
output:
  html_document: 
    keep_md: true
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document.  

Don't forget to answer any questions that are asked in the prompt. Some questions will require a plot, but others do not- make sure to read each question carefully.  

For the questions that require a plot, make sure to have clearly labeled axes and a title. Keep your plots clean and professional-looking, but you are free to add color and other aesthetics.  

Be sure to follow the directions and push your code to your repository.

## Background
In the `data` folder, you will find data about global shark attacks. The data are updated continuously, and are taken from [opendatasoft](https://public.opendatasoft.com/explore/dataset/global-shark-attack/table/?flg=en-us&disjunctive.country&disjunctive.area&disjunctive.activity).  

## Load the libraries

```r
library("tidyverse")
library("janitor")
library("naniar")
```

## Load the data
Run the following code chunk to import the data.

```r
global_sharks <- read_csv("data/global-shark-attack.csv") %>% clean_names()
```

## Questions
1. (2 points) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?  


```r
glimpse(global_sharks)
```

```
## Rows: 6,890
## Columns: 21
## $ date                   <date> 2023-07-29, 2023-04-22, 2023-03-02, 2023-02-18…
## $ year                   <dbl> 2023, 2023, 2023, 2023, 2022, 2022, 2021, 2021,…
## $ type                   <chr> "Unprovoked", "Unprovoked", "Unprovoked", "Ques…
## $ country                <chr> "USA", "AUSTRALIA", "SEYCHELLES", "ARGENTINA", …
## $ area                   <chr> "Florida", "Western Australia", "Praslin Island…
## $ location               <chr> "Tampa Bay", "Lucy's Beach", NA, "Chubut Provin…
## $ activity               <chr> "Swimming", "Surfing", "Snorkeling", NA, "Snork…
## $ name                   <chr> "Natalie Branda", "Max Marsden", "Arthur \xc9",…
## $ sex                    <chr> "F", "M", "M", "M", "F", "M", "M", "M", "M", "M…
## $ age                    <chr> "26", "30", "6", "32", NA, "21.0", "15.0", "73.…
## $ injury                 <chr> "Superficial injuries to abomen and thighs", "B…
## $ fatal_y_n              <chr> "N", "N", "UNKNOWN", "UNKNOWN", "N", "N", "N", …
## $ time                   <chr> "20h00", "07h15", "Afternoon", NA, "12h30", "15…
## $ species                <chr> NA, "Bronze whaler shark, 1.5 m", "Lemon shark"…
## $ investigator_or_source <chr> "Fox12, 8/1/2023", "The West Australian, 4/22/2…
## $ pdf                    <chr> NA, NA, NA, NA, "2022.07.28-Cornwall.pdf", "202…
## $ href_formula           <chr> NA, NA, NA, NA, "http://sharkattackfile.net/spr…
## $ href                   <chr> NA, NA, NA, NA, "http://sharkattackfile.net/spr…
## $ case_number_19         <chr> NA, NA, NA, NA, "2022.07.28", "2022.03.09", "20…
## $ case_number_20         <chr> NA, NA, NA, NA, "2022.7.28", "2022.03.09", "202…
## $ original_order         <dbl> NA, NA, NA, NA, 6792, 6743, 6720, 6626, 6618, 6…
```


```r
summary(global_sharks)
```

```
##       date                 year          type             country         
##  Min.   :1018-06-01   Min.   :   1   Length:6890        Length:6890       
##  1st Qu.:1951-08-16   1st Qu.:1950   Class :character   Class :character  
##  Median :1988-02-02   Median :1986   Mode  :character   Mode  :character  
##  Mean   :1973-01-14   Mean   :1971                                        
##  3rd Qu.:2009-08-30   3rd Qu.:2009                                        
##  Max.   :2023-08-16   Max.   :2023                                        
##  NA's   :305          NA's   :132                                         
##      area             location           activity             name          
##  Length:6890        Length:6890        Length:6890        Length:6890       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##      sex                age               injury           fatal_y_n        
##  Length:6890        Length:6890        Length:6890        Length:6890       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##      time             species          investigator_or_source
##  Length:6890        Length:6890        Length:6890           
##  Class :character   Class :character   Class :character      
##  Mode  :character   Mode  :character   Mode  :character      
##                                                              
##                                                              
##                                                              
##                                                              
##      pdf            href_formula           href           case_number_19    
##  Length:6890        Length:6890        Length:6890        Length:6890       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  case_number_20     original_order
##  Length:6890        Min.   :   2  
##  Class :character   1st Qu.:1702  
##  Mode  :character   Median :3401  
##                     Mean   :3401  
##                     3rd Qu.:5100  
##                     Max.   :6802  
##                     NA's   :91
```


```r
miss_var_summary(global_sharks)
```

```
## # A tibble: 21 × 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 time       3518    51.1 
##  2 species    3118    45.3 
##  3 age        2982    43.3 
##  4 activity    586     8.51
##  5 sex         572     8.30
##  6 location    565     8.20
##  7 area        481     6.98
##  8 date        305     4.43
##  9 name        220     3.19
## 10 year        132     1.92
## # ℹ 11 more rows
```

2. (3 points) Are there any "hotspots" for shark incidents? Make a plot that shows the total number of incidents for the top 10 countries? Which country has the highest number of incidents?


```r
global_sharks %>% 
  count(country) %>% 
  top_n(10, n) %>% 
  ggplot(aes(x=reorder(country, n), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  coord_flip() +
  labs(title="Number of Shark Incidents by Country",
       x=NULL,
       y="# of Incidents") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

_The US has the highest number of incidents._

3. (3 points) Are there months of the year when incidents are more likely to occur? Make a plot that shows the total number of incidents by month. Which month has the highest number of incidents?


```r
global_sharks %>% 
  separate(date, into = c("yr", "month", "day"), sep = "-") %>%
  filter(month != "NA") %>% 
  count(month) %>% 
  ggplot(aes(x=factor(month), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  labs(title="Number of Shark Incidents by Month",
       x="Month",
       y="# of Incidents") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

_January has the highest number of incidents._

4. (3 points) Which activity is associated with the highest number of incidents? Make a plot that compares the top 5 riskiest activities. "NA" should not be classified as an activity.


```r
global_sharks %>% 
  filter(activity != "NA") %>% 
  count(activity) %>% 
  top_n(5, n) %>% 
  ggplot(aes(x=reorder(activity, n), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  labs(title="Number of Shark Incidents by Activity",
       x="Activity",
       y="# of Incidents") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

5. (3 points) The data include information on who was attacked. Make a plot that shows the total number of fatalities by sex- are males or females more likely to be killed by sharks?


```r
global_sharks %>% 
  filter(fatal_y_n == "Y") %>% 
  filter(sex == "F" | sex == "M") %>% 
  count(sex) %>% 
  ggplot(aes(x=sex, y=n, fill=sex)) +
  geom_col(color="black", alpha=0.5) +
  labs(title="Fatal Shark Incidents by Sex",
       x=NULL,
       y="# of Incidents",
       fill="Sex") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

6. (3 points) Make a plot that shows the range of age for the individuals that are attacked. Make sure to restrict sex to M or F (some of the codes used are not clear). You will also need to find a way to manage the messy age column.


```r
sharks_age <- global_sharks %>% 
  filter(sex == "F" | sex == "M") %>% 
  filter(!str_detect(age, "[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&'_]")) %>% mutate(age=as.numeric(age))
```

```
## Warning: There was 1 warning in `mutate()`.
## ℹ In argument: `age = as.numeric(age)`.
## Caused by warning:
## ! NAs introduced by coercion
```


```r
sharks_age %>% 
  ggplot(aes(x=sex, y=age, fill=sex)) + 
  geom_boxplot(alpha=0.5) +
  labs(title="Age of Shark Attack Victims",
       x=NULL,
       y="Age",
       fill="Sex") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

```
## Warning: Removed 5 rows containing non-finite values (`stat_boxplot()`).
```

![](extra_credit_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

7. (3 points) In the United States, what are the top 5 states where shark attacks have been recorded since 1950? Make a plot that compares the number of incidents for these 5 states.


```r
global_sharks %>% 
  filter(country == "USA") %>% 
  count(area) %>% 
  top_n(5, n) %>% 
  ggplot(aes(x=reorder(area, n), y=n)) +
  geom_col(color="black", fill="cornflowerblue", alpha=0.5) +
  labs(title="Number of Shark Incidents by Top 5 States",
       x="State",
       y="# of Incidents") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.text.x = element_text(angle = 60, hjust = 1),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

8. (3 points) Make a new object that limits the data to only include attacks attributed to Great White Sharks. This is trickier than it sounds, you should end up with 494 observations. Look online and adapt code involving `str_detect`. Which country has the highest number of Great White Shark attacks?


```r
greatwhite <- global_sharks %>% 
  filter(str_detect(species, "White"))
```


```r
greatwhite %>% 
  count(country) %>% 
  arrange(desc(n))
```

```
## # A tibble: 36 × 2
##    country          n
##    <chr>        <int>
##  1 USA            151
##  2 AUSTRALIA      135
##  3 SOUTH AFRICA   124
##  4 NEW ZEALAND     17
##  5 ITALY           16
##  6 CROATIA          9
##  7 GREECE           4
##  8 CHILE            3
##  9 BAHAMAS          2
## 10 CANADA           2
## # ℹ 26 more rows
```

_The US has the highest number of Great White Shark Attacks._

9. (4 points) Use faceting to compare the number of fatal and non-fatal attacks for the top 5 countries with the highest number of Great White Shark attacks.


```r
greatwhite %>% 
  filter(fatal_y_n == "Y" | fatal_y_n == "N") %>% 
  filter(country == "USA" | country == "AUSTRALIA" | country == "SOUTH AFRICA" | country == "NEW ZEALAND" | country == "ITALY") %>% 
  ggplot(aes(x=country, fill=country)) +
  geom_bar(color="black", alpha=0.5) +
  coord_flip() +
  facet_grid(fatal_y_n~.) +
  labs(title="Non-fatal & Fatal GWS Incidents by Top 5 Countries",
       x=NULL,
       y="# of Incidents",
       fill="Country") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

10. (3 points) Using the `global_sharks` data, what is one question that you are interested in exploring? Write the question and answer it using a plot or table. 

How do the number of fatal and non-fatal attacks compare when the incident was provoked vs. unprovoked?

```r
global_sharks %>% 
  filter(fatal_y_n == "Y" | fatal_y_n == "N") %>% 
  filter(type == "Provoked" | type == "Unprovoked") %>% 
  ggplot(aes(x=fatal_y_n, fill=fatal_y_n)) +
  geom_bar(color="black", alpha=0.5) +
  facet_wrap(~type) +
  labs(title="Number of Non-fatal and Fatal Incidents",
       x=NULL,
       y="# of Incidents",
       fill="Fatal: No or Yes") +
  theme(plot.title=element_text(size=12, face="bold"),
        axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10))
```

![](extra_credit_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

