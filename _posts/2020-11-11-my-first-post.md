---
layout: post
title:  "London Bike Share"
date:   2020-11-11 22:50:22 +0000
categories: jekyll update
---

Besides your Oyster card and London Underground, another excellent way to get around the city of London for visitors is by bicycle. The bike share program has made it easy for travelers by placing over 700 docking stations and over 10000 bicycles around the city. These bicycles are truly ubiquitous and have become a staple of the city. Renting a bicycle will only cost your 2$ for a full day access as long as your rides are below 30 minutes. Longer rides will cost you an additional fee. 
<br />
<p align="center">
  <img width="300" height="300" src="https://user-images.githubusercontent.com/59604828/98951668-73e4eb80-24f2-11eb-8450-177230229650.png">
</p>              
<br />
Did you know that the average bicycle gets picked up 2 times per day? What about the fact that in 2018, there were 10 million rentals and riders spent a total of 40 million hours on the bicycle? 

In this dataful story, we access Transport for London open data repositories and analyze the 2018 bike sharing statistics for the city of London. 

Data
Bike rental transaction data is shared here:  https://cycling.data.tfl.gov.uk/, with full access granted to the general public under these terms and conditions: https://tfl.gov.uk/corporate/terms-and-conditions/transport-data-service. The data files contain transactions for a week’s period. 
 

To calculate yearly statistics, the first step is to download these files and combine them all in one master dataset. We find that there are over 10 million rows in our dataset, which will require advanced data analysis tools such as Python Pandas to accomplish the task of data analysis. 
The figure below is a sneak peek of the data, showing the first 3 rows and the last 3 rows (data loaded in no particular chronological order), confirming that there were indeed 10,500,357 bike rentals in 2018. 

 
The dataset contains rental Id for each bike rental, the duration of the bike rental in seconds, the specific bike Id that was rented, pick up and drop off times, as well as pick up and drop off stations (and their Id’s). 
Now that we know that there were 10,500,357 bike rentals in 2018, what else can we learn from this dataset? 
-	How many times was each bike rented in 2018?
-	What was the average duration of a rental in 2018?
-	What are the famous pick up and drop off locations?
-	What are the popular months for bike rentals?
-	What is the average time between rentals for each bike?
-	Does the weather affect the number of bikes rented?


How many times was each bike rented in 2018?
On average, each bike was rented 796 times in 2018, which is a little over 2 times per day, and in fact, over 70% of the bikes were rented at least 2 times per day.

 

Average duration of a rental:
On average, whenever a bike was picked up, the ride lasted just under 20 minutes. In fact, 99.7% of the bike rentals lasted just under 30 minutes. Is this perhaps because the first 30 minutes are free? Side note: we see the law of large numbers and the central limit theorem come into full effect.
 

Idle time.
Measured as the time between a drop off and a subsequent pick up for each bike on any given day. On average, each bike registers an idle time of 2.5 hours before it’s picked up again.  

 




Famous pick up and drop off locations. King’s Cross, Hyde Park, and Waterloo are the most famous pick up and drop off station. If anyone reading this post wishes to reach out to physically active tourists, you may want to focus on these stations. 

  


Famous months.
As expected, starting in early spring as the weather begins to be better, the number of rentals starts to pick up, peaking in mid-summer as tourists flock the city before tapering off. 

 
