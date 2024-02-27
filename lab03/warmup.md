---
output: 
  html_document: 
    keep_md: yes
---
## Warm-up

1. Build a vector that includes the following height measurements for five plants:plant 1 30.7, plant 2 37.6, plant 3 28.4, plant 4 NA, plant 5 33.2


```r
plant_height <- c(30.7, 37.6, 28.4, NA, 33.2)
```

2. Build another vector that includes the following mass measurements:plant 1 4, plant 2 5.2, plant 3 3.7, plant 4 NA, plant 5 4.6


```r
plant_mass <- c(4, 5.2, 3.7, NA, 4.6)
```

3. Assemble these vectors into a labeled data matrix with two columns


```r
heightmass <- c(plant_height, plant_mass)
plant_matrix <- matrix(heightmass, ncol =2, byrow = F)
plant_matrix
```

```
##      [,1] [,2]
## [1,] 30.7  4.0
## [2,] 37.6  5.2
## [3,] 28.4  3.7
## [4,]   NA   NA
## [5,] 33.2  4.6
```


```r
samples <- c("plant1", "plant2", "plant3", "plant4", "plant5")
measurements <- c("height", "mass")
```


```r
colnames(plant_matrix) <- c(measurements)
rownames(plant_matrix) <- c(samples)
plant_matrix
```

```
##        height mass
## plant1   30.7  4.0
## plant2   37.6  5.2
## plant3   28.4  3.7
## plant4     NA   NA
## plant5   33.2  4.6
```
4. Calculate the mean for height and mass and add them to the data matrix


```r
plant_avg <- colMeans(plant_matrix, na.rm = T)
plant_avg
```

```
## height   mass 
## 32.475  4.375
```


```r
plant_matrix <- rbind(plant_matrix, plant_avg)
plant_matrix
```

```
##           height  mass
## plant1    30.700 4.000
## plant2    37.600 5.200
## plant3    28.400 3.700
## plant4        NA    NA
## plant5    33.200 4.600
## plant_avg 32.475 4.375
```
