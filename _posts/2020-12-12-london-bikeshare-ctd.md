---
layout: post
title: 'ADFS: London Bike Share Cntd'
date: 2020-12-12 19:50:22 +0000
always_allow_html: TRUE
output:
  md_document:
    variant: gfm
    preserve_yaml: TRUE
categories: jekyll update
image: /assets/feature_images/post2.jpg
permalink: /:title:output_ext
---

In the <a href="https://dataful.blog/london-bike-share.html"> previous post </a>, we were able to uncover useful insights from the
London Bike Sharing programme. We learned that in 2018 there were 10.3
million rentals amounting to a total of 3.5 million hours of bike rental
time. We also learned that each bike on average was rented 2 times per
day and each ride on averages lasts about 20 minutes. We identified the
top ten most frequented bike stations as well as the most popular months
for rentals.

This post picks up from the previous by looking at the hourly weather
conditions in the city of London in 2018 and attempting to analyse their
impact on the number of bikes rented. Historical weather data for the
city of London was retrieved from <https://freemeteo.co.uk/weather>.

Preview of the weather data:

<font size = "1">
<table class=" lightable-classic-2 table" style="font-family: Arial; size = 2; width: 100% !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">

<thead>
<tr>
<th style="text-align:left;">
Time
</th>
<th style="text-align:left;">
Temp
</th>
<th style="text-align:left;">
Rel Temp
</th>
<th style="text-align:left;">
Wind
</th>
<th style="text-align:left;">
Wind.Gust
</th>
<th style="text-align:left;">
Rel Hum
</th>
<th style="text-align:left;">
Dew.Point
</th>
<th style="text-align:left;">
Pressure
</th>
<th style="text-align:left;">
Icon
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Date
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
21:20
</td>
<td style="text-align:left;">
10°C
</td>
<td style="text-align:left;">
8°C
</td>
<td style="text-align:left;">
280°17 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
71%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1035.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 670m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
<tr>
<td style="text-align:left;">
21:50
</td>
<td style="text-align:left;">
10°C
</td>
<td style="text-align:left;">
8°C
</td>
<td style="text-align:left;">
290°19 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
71%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1034.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 670m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
<tr>
<td style="text-align:left;">
22:20
</td>
<td style="text-align:left;">
10°C
</td>
<td style="text-align:left;">
8°C
</td>
<td style="text-align:left;">
280°17 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
71%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1034.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 640m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
<tr>
<td style="text-align:left;">
22:50
</td>
<td style="text-align:left;">
9Â°C
</td>
<td style="text-align:left;">
6°C
</td>
<td style="text-align:left;">
280°17 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
76%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1034.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 640m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
<tr>
<td style="text-align:left;">
23:20
</td>
<td style="text-align:left;">
10°C
</td>
<td style="text-align:left;">
8°C
</td>
<td style="text-align:left;">
290°19 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
71%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1034.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 640m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
<tr>
<td style="text-align:left;">
23:50
</td>
<td style="text-align:left;">
9°C
</td>
<td style="text-align:left;">
6°C
</td>
<td style="text-align:left;">
280°17 Km/h
</td>
<td style="text-align:left;">
N/A
</td>
<td style="text-align:left;">
76%
</td>
<td style="text-align:left;">
5°C
</td>
<td style="text-align:left;">
1034.0mb
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Cloudy at 640m
</td>
<td style="text-align:left;">
2018-12-31
</td>
</tr>
</tbody>
</table>
</font>

The dataframe structure and variable data types as extracted from the
webpage:



    ## 'data.frame':    45837 obs. of  11 variables:
    ##  $ Time                : chr  "00:20" "00:50" "01:20" "01:50" ...
    ##  $ Temperature         : chr  "6Â°C" "6Â°C" "6Â°C" "5Â°C" ...
    ##  $ Relative.Temperature: chr  "3Â°C" "4Â°C" "4Â°C" "2Â°C" ...
    ##  $ Wind                : chr  "230Â°17 Km/h" "230Â°9 Km/h" "220Â°11 Km/h" "220Â°11 Km/h" ...
    ##  $ Wind.Gust           : chr  "N/A" "N/A" "N/A" "N/A" ...
    ##  $ Rel..humidity       : chr  "81%" "81%" "81%" "87%" ...
    ##  $ Dew.Point           : chr  "3Â°C" "3Â°C" "3Â°C" "3Â°C" ...
    ##  $ Pressure            : chr  "1021.0mb" "1021.0mb" "1021.0mb" "1022.0mb" ...
    ##  $ Icon                : logi  NA NA NA NA NA NA ...
    ##  $ Description         : chr  " " " " " " " " ...
    ##  $ Date                : chr  "2016-01-01" "2016-01-01" "2016-01-01" "2016-01-01" ...

The data must undergo a cleaning and transformation process before
carrying out the analysis. The steps following steps are taken to
prepare the data:

  - Extracting numerical values from temperatures, wind speed, humidity
    and pressure,
  - Filtering data to keep weather data for each hour mark instead of
    30-min intervals,
  - Combining the time and date columns to create a new ‘datetime’
    column.

Preview of the cleaned data:

<font size = "1">
<table class=" lightable-classic-2 table" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">

<thead>

<tr>


<th style="text-align:right;">

Temp

</th>

<th style="text-align:right;">

Rel Temp

</th>

<th style="text-align:right;">

Wind

</th>

<th style="text-align:right;">

Rel Hum

</th>

<th style="text-align:right;">

Dew.Point

</th>

<th style="text-align:right;">

Pressure

</th>

<th style="text-align:left;">

Description

</th>

<th style="text-align:left;">

DateTime

</th>

</tr>

</thead>

<tbody>

<tr>



<td style="text-align:right;">

10

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

15

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1035

</td>

<td style="text-align:left;">

Cloudy at 670m

</td>

<td style="text-align:left;">

2018-12-31 19:00:00

</td>

</tr>

<tr>



<td style="text-align:right;">

10

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

15

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1035

</td>

<td style="text-align:left;">

Cloudy at 700m

</td>

<td style="text-align:left;">

2018-12-31 20:00:00

</td>

</tr>

<tr>



<td style="text-align:right;">

10

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

15

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1035

</td>

<td style="text-align:left;">

Cloudy at 640m

</td>

<td style="text-align:left;">

2018-12-31 21:00:00

</td>

</tr>

<tr>



<td style="text-align:right;">

10

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

19

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1034

</td>

<td style="text-align:left;">

Cloudy at 670m

</td>

<td style="text-align:left;">

2018-12-31 22:00:00

</td>

</tr>

<tr>



<td style="text-align:right;">

9

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

17

</td>

<td style="text-align:right;">

0.76

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1034

</td>

<td style="text-align:left;">

Cloudy at 640m

</td>

<td style="text-align:left;">

2018-12-31 23:00:00

</td>

</tr>

<tr>



<td style="text-align:right;">

9

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

17

</td>

<td style="text-align:right;">

0.76

</td>

<td style="text-align:right;">

5

</td>

<td style="text-align:right;">

1034

</td>

<td style="text-align:left;">

Cloudy at 640m

</td>

<td style="text-align:left;">

2019-01-01 00:00:00

</td>

</tr>

</tbody>

</table>

</font>

Recalling from the previous post, each rental record contained
timestamps for bike pick-up and drop-off down to the minute mark. This
data can be aggregated to count the number of rentals in hourly
intervals in 2018.

<font size = "1">
<table class=" lightable-classic-2 table" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

DateTime

</th>

<th style="text-align:right;">

Rentals.Num

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

1/1/2018 0:00

</td>

<td style="text-align:right;">

252

</td>

</tr>

<tr>

<td style="text-align:left;">

1/1/2018 1:00

</td>

<td style="text-align:right;">

348

</td>

</tr>

<tr>

<td style="text-align:left;">

1/1/2018 2:00

</td>

<td style="text-align:right;">

244

</td>

</tr>

<tr>

<td style="text-align:left;">

1/1/2018 3:00

</td>

<td style="text-align:right;">

119

</td>

</tr>

<tr>

<td style="text-align:left;">

1/1/2018 4:00

</td>

<td style="text-align:right;">

90

</td>

</tr>

<tr>

<td style="text-align:left;">

1/1/2018 5:00

</td>

<td style="text-align:right;">

57

</td>

</tr>

</tbody>

</table>

</font>

Hourly weather data and hourly bike rental counts are joined to form a
larger dataset containing both the weather and rental numbers. For
simplicity, only 25% (200) top docking stations responsible for over
half of total rentals are considered.

Joint Data Preview:

<font size = "1">
<table class=" lightable-classic-2 table" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Time

</th>

<th style="text-align:right;">

Temp

</th>

<th style="text-align:right;">

Rel Temp

</th>

<th style="text-align:right;">

Wind

</th>

<th style="text-align:right;">

Rel Hum

</th>

<th style="text-align:right;">

Dew.Point

</th>

<th style="text-align:right;">

Pressure

</th>

<th style="text-align:left;">

Description

</th>

<th style="text-align:right;">

Rentals.Num

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

2018-01-01 00:00:00

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

35

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

996

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

252

</td>

</tr>

<tr>

<td style="text-align:left;">

2018-01-01 01:00:00

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

33

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

997

</td>

<td style="text-align:left;">

Few Clouds at 880m

</td>

<td style="text-align:right;">

348

</td>

</tr>

<tr>

<td style="text-align:left;">

2018-01-01 02:00:00

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

4

</td>

<td style="text-align:right;">

30

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

999

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

244

</td>

</tr>

<tr>

<td style="text-align:left;">

2018-01-01 03:00:00

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

26

</td>

<td style="text-align:right;">

0.76

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

999

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

119

</td>

</tr>

<tr>

<td style="text-align:left;">

2018-01-01 04:00:00

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

24

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

999

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

90

</td>

</tr>

<tr>

<td style="text-align:left;">

2018-01-01 05:00:00

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

26

</td>

<td style="text-align:right;">

0.71

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

999

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

57

</td>

</tr>

</tbody>

</table>

</font>

Below is the final structure of the complete dataset:

    ## 'data.frame':    6769 obs. of  9 variables:
    ##  $ Time                : POSIXct, format: "2018-01-01 00:00:00" "2018-01-01 01:00:00" ...
    ##  $ Temperature         : num  8 8 8 7 7 7 7 7 7 7 ...
    ##  $ Relative.Temperature: num  4 4 4 3 3 3 4 5 5 5 ...
    ##  $ Wind                : num  35 33 30 26 24 26 20 13 13 11 ...
    ##  $ Rel..humidity       : num  0.71 0.71 0.71 0.76 0.71 0.71 0.71 0.71 0.76 0.76 ...
    ##  $ Dew.Point           : num  3 3 3 3 2 2 2 2 3 3 ...
    ##  $ Pressure            : num  996 997 999 999 999 999 999 998 997 997 ...
    ##  $ Description         : chr  " " " Few Clouds at 880m  " " " " " ...
    ##  $ Rentals.Num         : int  252 348 244 119 90 57 45 22 39 40 ...


<br>

#### **Exploratory data analysis**

The first step in our exploratory data analysis is to look at the
distribution of hourly bike rentals in 2018, which is our response
variable of interest.

![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-8-1.png)<!-- -->
<br>
The number of hourly bike rentals clearly does not follow a normal
distribution. This is a fact to consider in the data modeling process.
<br>

**Correlations**

The objective of this exercise is to estimate the number of bike rentals
based on weather parameters, and weather parameters only.

It is helpful to look at the possible correlations that exist between
the variables in the dataset, which might help to reduce the number of
variables and to choose the right modeling approach (Note that a strong
linear correlation exists between temperature, relative temperature, and
dew point, therefore only the temperature variable will be kept).

![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-9-1.png)<!-- -->

From the graph above, a measurable (not strong) correlation is observed
between the number of rentals and the temperature & relative humidity
values.

The tree model below also indicates that relative humidity is a strong
factor in the dataset that affects the number of bike rentals. It is
also clear that no complex interactions exist between the variables in
the dataset.

![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-10-1.png)<!-- -->

#### **Prediction Models**

Data preparation and cleaning are generally the hardest part of most
data science projects. Making predictions based on the data is largely
about picking the right predictive algorithm for the dataset. The
following section explores a few well known algorithms: linear model, k
nearest neighbors, decision trees, and random forests models.

The dataset is split 75% and 25% for training dataset and testing
dataset respectively (the training is done on 3/4 of the data, and the validation of the
model on the remaining 1/4).


``` r
#Spliting the dataset into training and testing sets:
set.seed(1, sample.kind = "Rounding")  #setting seed

test_index <- createDataPartition(y = joint_df$Temperature, 
                                  times = 1, p = 0.25, list = FALSE)

#Training and Testing sets:
train_set <- joint_df %>% slice(-test_index)
test_set <- joint_df %>% slice(test_index)
```
<br>
**1. Fitting a Linear Model**

Recall that the rentals distribution in the dataset does not follow a
normal distribution. Additionally, the number of rentals should be
considered as ‘count data’ rather than a regular numerical continuous
variable. GLM with poisson errors would be an appropriate method to handle this
data.

``` r
#####
#Linear Model:
fit_lm <- glm(Rentals.Num ~ Temperature + Wind + 
                   Rel..humidity + Pressure, quasipoisson,
                 data = train_set)
summary(fit_lm)
```

    
    ## Coefficients:
    ##                Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   -0.961727   1.594252  -0.603    0.546    
    ## Temperature    0.037298   0.002621  14.230  < 2e-16 ***
    ## Wind           0.009363   0.001896   4.938 8.17e-07 ***
    ## Rel..humidity -1.767641   0.103741 -17.039  < 2e-16 ***
    ## Pressure       0.007719   0.001541   5.009 5.65e-07 ***
    ## ---
    ## 
    ##     Null deviance: 2664777  on 5074  degrees of freedom
    ## Residual deviance: 1956992  on 5070  degrees of freedom
    ## AIC: NA
    ## 
    ## Number of Fisher Scoring iterations: 5

The residual deviance in the model is incredibly large in comparison to
the degrees of freedom. This is an indication of strong overdispersion,
i.e. unexplained variations and a *clear evidence that the weather
parameters do not really affect the number of bikes rented* in the
dataset.

**Testing the Linear Model**

It has just been established that there are a lot of variations in the
number of bikes rented that are not explained by the weather parameters.
*It would be a bad practice to rely on the weather parameters to
estimate the rentals*.

We can still attempt to make predictions in the test set using the model
and see how well the model does compared to real data.

``` r
#predict number of bikes rented in the test set:
predict_lm <- predict(fit_lm, test_set)
```

Compare the predicted values by the linear model to the real values by
calculating the RMSE.

<table class=" lightable-classic-2" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Method

</th>

<th style="text-align:right;">

RMSE

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Linear Model

</td>

<td style="text-align:right;">

783.7156

</td>

</tr>

</tbody>

</table>

On overage, the predicted numbers of bike rentals are off by a whooping
784 in comparison to the actual numbers.

Let’s see how other algorithms compare (note: the number of rentals is
modeled as a continuous numerical variable in the algorithms below):

<br>

**2. Fitting the kNN model**

The k-NN (k-nearest neighbors) performs the training for a given
datapoint using the points that are most similar to it (neighbors).

Fitting k-NN with default tuning parameters:

``` r
fit_knn <- train(Rentals.Num ~ Temperature + Wind + 
                   Rel..humidity + Pressure, method = 'knn',
                 data = train_set)
```

Predicting the number of rentals in the test set:

``` r
predict_knn <- predict(fit_knn, test_set)
```

Comparing predictions by the k-NN model to actual numbers by calculating
the RMSE:

<table class=" lightable-classic-2" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Method

</th>

<th style="text-align:right;">

RMSE

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Linear Model

</td>

<td style="text-align:right;">

783.7156

</td>

</tr>

<tr>

<td style="text-align:left;">

KNN Model

</td>

<td style="text-align:right;">

485.7629

</td>

</tr>

</tbody>

</table>

The k-NN model, although it presents an improvement over the linear
model, is still off by a lot\!

<br>
**3. Fitting the Decision Trees Model**

Decision trees (regression trees in our example) is another simple and
popular machine learning algorithm that is used to predict outcomes
based on a number of features.

Fitting decision trees model:

``` r
#Decision Trees:
fit_rpart <- train(Rentals.Num ~ Temperature + Wind + 
                   Rel..humidity + Pressure, method = 'rpart',
                   tuneGrid = data.frame(cp = 0.001),
                   data = train_set)
```

Predicting with decision trees model:

``` r
predict_rpart <- predict(fit_rpart, test_set)
```

Comparing the predicted values by the decision (regression) trees model
to the real values by calculating the RMSE:

<table class=" lightable-classic-2" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Method

</th>

<th style="text-align:right;">

RMSE

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Linear Model

</td>

<td style="text-align:right;">

783.7156

</td>

</tr>

<tr>

<td style="text-align:left;">

KNN Model

</td>

<td style="text-align:right;">

485.7629

</td>

</tr>

<tr>

<td style="text-align:left;">

Trees Model

</td>

<td style="text-align:right;">

474.3502

</td>

</tr>

</tbody>

</table>

Another slight improvement is observed by using the decision
(regression) trees algorithm. However, the numbers are still not
satisfactory (which is expected).

**4. Random Forests**

Finally, let’s consider the performance of the random forests algorithm
compared to the previous three. The algorithm essentially operates by
grouping a number of decision trees picked from random sampling of the
data in the training set. Random forests generally tend to be more
accurate than simple decision trees.

Fitting random forests model to the training set:

``` r
#Random Forests:
fit_rf <- train(Rentals.Num ~ Temperature + Wind + 
                     Rel..humidity + Pressure, method = 'rf',
                   data = train_set)
```

Predicting with the random forest model on the testing set:

``` r
predict_rf <- predict(fit_rf, test_set)
```

Comparing predictions by random forest to actual values:

<table class=" lightable-classic-2" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Method

</th>

<th style="text-align:right;">

RMSE

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Linear Model

</td>

<td style="text-align:right;">

783.7156

</td>

</tr>

<tr>

<td style="text-align:left;">

KNN Model

</td>

<td style="text-align:right;">

485.7629

</td>

</tr>

<tr>

<td style="text-align:left;">

Trees Model

</td>

<td style="text-align:right;">

474.3502

</td>

</tr>

<tr>

<td style="text-align:left;">

Forests Model

</td>

<td style="text-align:right;">

451.8286

</td>

</tr>

</tbody>

</table>

The best model in the four studied so far is off by 452 rentals on
average. This number is high compared to the nature of the dataset.

At this point, it would be appropriate to surrender and declare that we
cannot predict the number of bikes that shall be rented solely based on
the weather forecast.

Before we do that, there’s one final element to consider: since we’re
attempting to predict hourly bike rentals, let’s look at the total
number of bikes rented in 2018 by ‘hour of the day’.

``` r
joint_df %>%
  mutate(hour = hour(Time)) %>%
  group_by(hour) %>%
  summarize(Hour_tot = sum(Rentals.Num)) %>%
  ggplot(aes(hour, Hour_tot)) +
  geom_line(col = 'brown4', size = 1) +
  scale_x_discrete(limits = seq(0,23,1)) +
  xlab('Hour of the Day') +
  ylab('Total bikes rented 2018') +
  ggtitle('Number of Rentals by Hour of the Day') +
  theme(plot.title = element_text(size = 10), axis.title = element_text(size = 8))
```
<br>
![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-24-1.png)<!-- -->

Looking at the data by hour of the day, one major observation is made:
The spike in bike rentals at 8AM and 9AM, followed by another spike at
5PM and 6PM cannot be missed. Another secondary observation is a
relatively flat usage in the hours of the night from midnight to 6AM.
These observations lead us to make a strong assumption: _**The bike usage
at 8, 9, 17, & 18 hours is largely driven by the people commuting to and
from work**_. In this case, regardless of the weather conditions, these
customers will rent the bike. This could explain a big part of
variations observed in our model above. Similarly, people using the
bikes in night hours perhaps do it because they don’t have other
alternatives and weather conditions don’t matter. Therefore, we can
attempt to make a distinction between people that use the bikes for
business (e.g. going to and from work) and those that use it for
pleasure.

It would certainly make sense that the weather conditions would affect
the leisure users more than it would the utility users.

Let’s re-rerun the model and recalculate the RMSEs only on the leisure
users (selected hours: 6, 7, 10, 11, 12, 13, 14, 15, 16, 19, 20 and 21)

``` r
#New dataset for leisure users:

leisure_hours <- c(6,7,10,11,12,13,14,15,16,19,20,21)

leisure_df <- joint_df %>%
  mutate(Hour = hour(Time)) %>%
  filter(Hour %in% leisure_hours)
```
<br>
![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-26-1.png)<!-- -->

The new distribution is slightly more “normal” but not quite. GLM with
poisson errors will still be the preferred approach when fitting a
linear model.

Below is a summary of the RMSE comparisons for all four models and for
overall data vs. ‘leisure’ users.

<table class=" lightable-classic-2" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

Method

</th>

<th style="text-align:right;">

RMSE

</th>

<th style="text-align:right;">

RMSE Leisure

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Linear Model

</td>

<td style="text-align:right;">

783.7156

</td>

<td style="text-align:right;">

693.8746

</td>

</tr>

<tr>

<td style="text-align:left;">

KNN Model

</td>

<td style="text-align:right;">

485.7629

</td>

<td style="text-align:right;">

289.8861

</td>

</tr>

<tr>

<td style="text-align:left;">

Trees Model

</td>

<td style="text-align:right;">

474.3502

</td>

<td style="text-align:right;">

278.3836

</td>

</tr>

<tr>

<td style="text-align:left;">

Forests Model

</td>

<td style="text-align:right;">

451.8286

</td>

<td style="text-align:right;">

268.7474

</td>

</tr>

</tbody>

</table>

Significant improvements in our prediction power can be observed,
however we can still conclude that there exist additional variations in
the response variable (number of rentals) that are not explained by the
weather parameters. A few additional weather parameters that were not
considered that may also play a key role are ‘precipitation’ and ‘cloud
description’. The data for precipitation was not readily available and the
cloud description data is limited.

Finally, one might be curious to visualize the predicted vs. actual
numbers graphically:
<br>

![](/rmd_images/2020-12-12-london-bikeshare-ctd/unnamed-chunk-29-1.png)<!-- -->

While our best model is not great, it is not terribly bad either and the
correlation coefficient of 0.7 between the actual numbers and the
predicted numbers is quite impressive given the data.
<br>

#### **Conclusion**
It is well possible that one can forecast the number of bike
rentals for the next day based on the number of rentals observed on the
prior day and achieve a better accuracy than our weather-based models.
Nevertheless, this was an interesting exercise on the application of
predictive models on a real world business dataset joined with a natural
phenomenon such as weather. You can find the Rmd file for this post
here. I certainly enjoyed scraping, cleaning, and analyzing this data. I
hope you enjoyed reading these posts. Write me\!


<p style="font-size:12px"> 
This blog post and the contents therein are for educational purposes and should not be used to drive any business decisions or profit making. <br /> 
Weather image: iStock/Getty Images Plus/Composite <br />
Contains OS data © Crown copyright and database rights 2016' and Geomni UK Map data © and database rights [2020]</p>
