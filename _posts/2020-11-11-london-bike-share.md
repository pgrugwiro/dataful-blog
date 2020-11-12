---
layout: post
title:  "London Bike Share"
date:   2020-11-11 22:50:22 +0000
categories: jekyll update
---

Besides your Oyster card and London Underground, another excellent way to get around the city of London for visitors is by bicycle. The bike share program has made it easy for travelers by placing over 700 docking stations and over 10000 bicycles around the city. Commonly known as the Boris bikes, they are truly ubiquitous and have become a staple of the city. Renting a bicycle will only cost your 2$ for a full day access as long as your rides are below 30 minutes. Longer rides will cost you an additional fee. 
<br />
<p align="center">
  <img width="300" height="300" src="https://user-images.githubusercontent.com/59604828/98951668-73e4eb80-24f2-11eb-8450-177230229650.png">
</p>              
<br />
Did you know that the average bike gets picked up 2 times per day? What about the fact that in 2018, there were 10 million bike rentals and riders spent a total of 3.5 million hours on the bikes? 

In this dataful story, we access Transport for London open data repositories and analyze the 2018 bike sharing statistics for the city of London. 

#### Data
Bike rental transaction data is shared here: <a href="https://cycling.data.tfl.gov.uk/"> cycling.data.tfl.gov.uk</a>, with full access granted to the general public under these terms and conditions: <a href= "https://tfl.gov.uk/corporate/terms-and-conditions/transport-data-service"> Transport Data Service </a>. <br />
Individual data files contain transactions for a week’s period. 
To calculate yearly statistics, the first step is to download these files and combine them all in one master dataset. We find that there are over 10 million rows (transactions) in our dataset, which requires advanced tools for transactional data processing and analysis such as **Python Pandas**. The Jupyter Notebook used for the following exercise can be found <a href="https://still-cleaning-it-up"> here </a>.<br />
The figure below is a sneak peek of the data, showing the first 3 rows and the last 3 rows (data loaded in no particular chronological order), confirming that there were indeed 10,500,357 bike rentals in 2018. 
<br />
<br />
<p align="center">
  <img width="600" height="300" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/headtail.PNG?raw=true">
</p> 
<br />
<br />
The dataset contains rental Id for each bike rental, the duration of the bike rental in seconds, the specific bike Id that was rented, pick up and drop off times, as well as pick up and drop off stations (and their Id’s). 
Now that we know that there were 10,500,357 bike rentals in 2018, what else can we learn from this dataset? 
-	How many times was each bike rented in 2018?
-	What was the average duration of a rental in 2018?
-	What was the average daily idle time for each bike?
-	What are the famous pick up and drop off locations?
-	What are the popular months for bike rentals?
-	Does the weather affect the number of bikes rented?
<br />
<br />

#### How many times was each bike rented in 2018?  
Grouping and counting the rental Ids for each bike, we find that, **on average each bike was rented 796 times in 2018**, which is a little over 2 times per day, and in fact, over 70% of the bikes were rented at least 2 times per day. The distribution of total number of rentals per bike is shown in the figure below:
<br />
<br />
<p align="center">
<img width="400" height="300" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/rentalsperbike.png?raw=true">
</p> 
<br /> 
<br />

#### What was the average duration of a bike rental in 2018?
Perhaps we may be wondering how long is a bike ride each time a client picks it up. Again, grouping and averaging the duration of rentals for each bike, we calculated that whenever a bike was picked up, **the ride lasted just under 20 minutes on average**. In fact, 99.7% of the bike rentals lasted just under 30 minutes. Is this perhaps because the first 30 minutes are free? Side note: we see the law of large numbers and the central limit theorem come into full effect in the distribution of bike rental duration in the figure below:
<br />
<br />
<p align="center">
<img width="400" height="300" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/rentalduration.png?raw=true">
</p> 
<br />
<br />

#### What was the average daily idle time for each bike?
The idle time is measured as the time between a drop off and a subsequent pick up for each bike on any given day. It does not account for overnight idle time, and also sets a maximum threshold to remove incidents where a bike went unused for a number of days. On average, each bike registered **an idle time of 2.5 hours** before it’s picked up again. 
As a product manager, if you found that the bikes only get picked up 2 times per day on average for a duration of 20 minutes per ride and then sit idle for the remainder of the day, what would you do? The full distribution of idle time is shown in the figure below: 
<br />
<br />
<p align="center">
<img width="400" height="300" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/idletime.png?raw=true">
</p> 
<br />
<br /> 

#### What are the famous pick up and drop off locations?
If you are a tourist, you may wonder what the most famous pick up and drop off locations are. They could be right next to the most attractive tourist locations, or the most accessible underground stations. Or you're doing some kind of outreach and wish to reach out to the "physically active" Londoners and visitors. Whatever the reasons, **King’s Cross, Hyde Park, and Waterloo** are the most famous pick up and drop off station.
<br />
<br />
<p align="center">
<img width="500" height="280" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/pickupstation.png?raw=true">
<img width="500" height="280" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/dropoffstation.png?raw=true">
</p> 
<br />
<br /> 

#### What are the popular months for bike rentals?
As expected, the number of bike rentals starts to pick up in early spring as the weather becomes more favorable, peaking in mid summer as tourists flock the city before tapering off. 
<br />
<br />
<p align="center">
<img width="400" height="300" src="https://github.com/pgrugwiro/my-blog/blob/main/_images/rentalweekcount.png?raw=true">
</p> 
<br />
<br /> 

#### Does the weather affect the number of bikes rented?
Since the number of bike rentals begins to pick up in early spring, can we say that the weather has a strong impact on the number of bicycles rented? **In the next blog post**, we will analyze the hourly weather for the city of London in 2018 and determine if there was a direct correlation between the weather conditions and the number of bikes rented. 
**See you next time**. 
<br />
<br /> 

<p style="font-size:12px"> 
This blog post and the contents therein are for educational purposes and should not be used to drive any business decisions or profit making. <br /> 
Bike image: From @santandercycles on Instagram <br />
Contains OS data © Crown copyright and database rights 2016' and Geomni UK Map data © and database rights [2020]</p>