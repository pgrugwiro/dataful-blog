---
layout: post
title: 'ADFS: Taming Big Data with MapReduce'
date: 2021-04-26 13:50:22 +0000
always_allow_html: TRUE
output:
  md_document:
    variant: gfm
    preserve_yaml: TRUE
categories: jekyll update
image: /assets/feature_images/post5.jpg
permalink: /:title:output_ext
---

#### **Myth Busters**

This is not the age of data. This is the age of data tech.
Data itself (or themselves depending on your school of thought) is
(are), and has (have) always been, and will always be. It is the
technology to collect, transform, analyse, and present data that has
soared to unprecedented levels and continues to be on the rise. Devices,
algorithms, and apps are now collecting data about us people, other
living and non-living organisms, systems, and processes, resulting in
enormous volumes of data. <br> <br>This data comes in different shapes and forms; 
there is a common saying that “data is messy”. No, data is not messy. Data
just is. (Okay, I suppose you can say that I am with the “is” school of
thought). However, if one is using the wrong data for a certain purpose,
or the wrong tool for a certain data, then it can get pretty messy
pretty quick. <br><br>Along with the rise of data collection technologies, is
the rise of data analysis technologies capable of handling such volumes
of data. One such technology and the main topic of this post is
**MapReduce**. 
<br>
<br>

#### **MapReduce – What’s that?**

MapReduce is a programming model that is used
to access and analyse data stored in the Hadoop Distributed File System.
Simply put, imagine a very big data that is split up into smaller chunks
or blocks of data and these smaller blocks are stored in clusters of
commodity servers, thus the term ‘distributed files system’. With
MapReduce, each block of data can be analysed on the server where it
resides. The analysis of all the blocks of data happens in parallel,
therefore speeding up the process. Imagine once again a 1TB dataset.
Attempting to analyse such data on a regular PC would be challenging, if
not impossible. Imagine a framework that allows you to split up this
data into 10000 partitions and store each partition on its own PC; each
of the 10000 PCs would only store 100MB of data (Think Hadoop
Distributed File System, or HDFS). Attempting to analyse 100MB is a
simple task that takes no time (Think MapReduce). Beautiful\!
<br>
<br>

#### **MapReduce – How’s that?**

The two main components of MapReduce are, as the
name suggests, Map and Reduce. The Map function takes input data from
storage (small block of data) in the form of {key:value} pairs, processes the data (or
rearranges it in some elegant way), and produces an intermediate output
also in the form of {key:value} pairs. The Reduce function takes Map
function’s output as input, processes the data, and produces the final
output, once again, in the form of {key:value} pairs. The data analyst
defines both the map and reduce functions according to the computational
objectives.

Well, that was a lot of blah blah blah meeh...meehhhh. <br> <br> Let’s use a portion of my
partner’s **shoe collection** to show how MapReduce **really works**.

It begins with one pile of shoes, which we will refer to as one block of
data. Now just imagine there exists another 9999 piles of shoes (blocks
of data) somewhere in our various abodes around the world (the
distributed file system).

This block of data is a bit challenging to make sense of. I won’t bore
you with the details … you see what I mean. What a mess! Oh darn it, I did it too!

<p align="center">
  <img width="400" height="400" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/map1.PNG">
</p> 
<br>
So let’s send a Map function (mapper) to this block of data. What the
mapper is simply going to do, is to rearrange this block of data in some
fashion. Remember how we said earlier that the input to the mapper is in
the form of {*key:value*} pairs? Well, in this case the input pairs to the
mapper are {*piles:shoes*}. And the output from the mapper are also in the
form of {*key:value*} pairs after some kind of arrangement. In this example,
the arrangement is simply identifying each individual shoe and setting
it aside. So, the output will be **{*shoetype:1*}**. Well, that’s about it.
That’s all we want the mapper to do. Identify a shoe and set it aside.
The mapper will complete the same task on all the other 9999 {*piles:shoes*}
in the distributed file system.

<p align="center">
  <img width="400" height="400" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/map2.PNG">
</p> 
<br>

This is still not enough. Still difficult to make sense of... again, for
reason I won’t bother explaining. <br><br>We would like to know how many shoes
of each type there are. (In our simple example, there should be 2 shoes of each
type, unless for some reason a squirrel broke into our flat and stole some shoes). 
This is where the Reduce function (reducer) comes in. Before the
reducer does the aggregation for us, the MapReduce framework will
complete some shuffle and sort magic behind the scene for us, collecting
shoetypes that are similar from all the different piles of shoes and
putting them together, side by side. The input to the reducer will therefore be
{*key:value*} pairs of the form **{*shoetype:(1,1)*}**. The output of the reducer is
whatever information we want to generate from the input. Let’s say that
for example we want to sum up how many shoes there are for each type,
then our output would be **{*shoetype:(1+1)*}**, or **{*shoetype:2*}**.

<p align="center">
  <img width="400" height="400" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/agg1.PNG">
</p> 
<br>

We could also be interested in finding out what different categories of
shoes there are in our {*piles:shoes*} (e.g., pumps, flats, sneakers, etc.),
assuming that they are properly labelled. In that case, we could write a
second mapper that takes these sorted pairs as input, arranges them in
their proper categories, and the reducer will carry out the aggregation,
allowing to know how many individual categories there are, how big each
category is (see image below), etc… **How simple was that?**


<p align="center">
  <img width="400" height="600" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/agg2.PNG">
</p> 
<br>
The beauty of MapReduce, which is shared by many other common data
analysis tools, is that it is **simple enough** that it can be picked up by
just about **anyone in the data analysis community** and does not require advanced
programming knowledge. **It’s a low code tool**.
<br>
<br>
#### **MapReduce – How’s that Really?**

Let’s see some MapReduce in action. We will write a mapper and reducer
to help us understand energy usage in some London households from an
experiment that was run a few years ago. Smart meters were used to
collect this energy usage data. Smart meters (in the context of energy
consumption) are digital devices that provide accurate reading of real
time energy usage in a home. The readings can be sent to the energy
supplier via a secure internet network, which effectively puts an end to
estimated energy bills and manual meter readings. Smart meters allow the
consumer to better understand their energy usage and become more energy
efficient. With smart meters, the supplier can monitor consumption in
real time, respond quicker to outages, and determine better pricing
models among other things. I guess all I'm trying to say is "get one of those!"
<br><br>The data collected by millions of smart
meters at small time intervals can grow quickly and daily. The
aggregation and analysis of this big data requires advanced data
analytic tools and high-performance computational frameworks such as
Hadoop and MapReduce. In this short example, we will use data from 95
households. These households belong to various economic backgrounds
categorised as Adversity (this is probably where I belong), Comfortable
(this is where I hope you belong), and Affluent (the Earl of
Hertfordshire definitely belongs here... if you know him, give him my regards s'il vous plait). A portion of the households were subjected to a variable tariff (67.2p/kWh, 11.76p/kWh, and 3.99p/kWh)
and households were informed of the tariffs rates one day ahead. The
rest of the households were on standard rates of 14.228p/kWh.
Usage readings were taken every 30 minutes. The dataset contains about 3
million rows and looks like this:

<table class=" lightable-classic-2 table" style="font-family: Arial; width: auto !important; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

LCLid

</th>

<th style="text-align:left;">

stdorToU

</th>

<th style="text-align:left;">

DateTime

</th>

<th style="text-align:right;">

kWhphh

</th>

<th style="text-align:left;">

AcornGroup

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

MAC000069

</td>

<td style="text-align:left;">

Std

</td>

<td style="text-align:left;">

5/12/2013 22:30

</td>

<td style="text-align:right;">

0.063

</td>

<td style="text-align:left;">

Comfortable

</td>

</tr>

<tr>

<td style="text-align:left;">

MAC000069

</td>

<td style="text-align:left;">

Std

</td>

<td style="text-align:left;">

5/12/2013 23:00

</td>

<td style="text-align:right;">

0.106

</td>

<td style="text-align:left;">

Comfortable

</td>

</tr>

<tr>

<td style="text-align:left;">

MAC000069

</td>

<td style="text-align:left;">

Std

</td>

<td style="text-align:left;">

5/12/2013 23:30

</td>

<td style="text-align:right;">

0.029

</td>

<td style="text-align:left;">

Comfortable

</td>

</tr>

<tr>

<td style="text-align:left;">

MAC000069

</td>

<td style="text-align:left;">

Std

</td>

<td style="text-align:left;">

5/13/2013 0:00

</td>

<td style="text-align:right;">

0.108

</td>

<td style="text-align:left;">

Comfortable

</td>

</tr>

<tr>

<td style="text-align:left;">

MAC000069

</td>

<td style="text-align:left;">

Std

</td>

<td style="text-align:left;">

5/13/2013 0:30

</td>

<td style="text-align:right;">

0.033

</td>

<td style="text-align:left;">

Comfortable

</td>

</tr>

</tbody>

</table>

Let’s design a MapReduce program that aggregates energy usage data for
each tariff type (standard and dynamic) and for each economic (acorn) group
(affluent, comfortable, and adversity) by time. <br><br>The MapReduce program begins with the
user choosing a category of interest. The mapper will receive the
document containing all the data (house number, tariff type, date and
time, energy used, economic grouping) and will proceed by mapping the
energy consumption to each datetime, forming a key value pair. The
mapper will emit these key value pairs of datetime and energy
consumption only for the category that matches the chosen category by
the user. <br><br>The reducer will receive key-values (list of values) pairs,
i.e., for each datetime, a list of energy consumptions in all households
is provided **(**Recall shoetype:(1,1)? Yes, just like that.**)**. The reducer will then aggregate these values according to
the goal of the project, which in this project is to calculate the
average per datetime. Finally, the reducer will emit key value pairs of
datetime and average energy consumption. <br><br>
**Pseudo code**: 

<p align="center">
  <img width="800" height="350" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/pseudo.PNG">
</p> 
<br>

**Actual code**: 
<br>

<p align="center">
  <img width="600" height="500" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/mapper.PNG">
</p> 
<br>

<p align="center">
  <img width="600" height="500" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/reducer.PNG">
</p> 
<br>

In addition to writing a mapper and reducer, there's also a driver class that makes it all work.
Writing MapReduce code in Java is simple but is as hard as writing
MapReduce code gets. The same code can be written with much less effort
in Python to accomplish the same tasks (I’ll spare you the boring
details). I’ll also proceed by sparing you yet more boring details of
how to create .jar files (basically, stuff like File + Save As… you know
the drill) to create the final MapReduce app.
<br><br>

So, let’s run the program. <br>

Step 1. Start and confirm HDFS daemons are
running (wait, but what are the HDFS daemons?? arghhhhh… well, next time
maybe). For now, let’s just say that you’re setting up your distributed
file system. Remember those 10000 PCs we talked about earlier? Yes,
that. You’re waking them up, getting them ready for work.

<p align="center">
  <img width="400" height="100" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/jps.PNG">
</p> 
<br>

Step2. Create a directory in HDFS and upload data (your big data) to the
directory. Then relax. The system you set up above will know how to spit
it in smaller data and distribute it across the clusters.

<p align="center">
  <img width="400" height="50" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/upload.PNG">
</p> 
<br>
Step 3. Run the MapReduce program: This particular program is aggregating data for
the Acorn type “Comfortable”.

<p align="center">
  <img width="400" height="30" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/run.PNG">
</p> 
<br>

Step 4. You can view data in HDFS:

<p align="center">
  <img width="400" height="130" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/viewdata.PNG">
</p> 
<br>

Step 5. And finally, download aggregated data from HDFS to local disk for further
analysis.

**Boom\!** That’s it. With just a few keystrokes, you have tamed big data\!<br><br>
The ever-growing size of data requires novel and powerful data analysis
tools to gain real time insights. MapReduce programming
makes it possible to perform calculations, from the basic calculations
such as mean, max to more advanced calculations, on large-scale data
that is distributed on many independent computing nodes while
maintaining a high level of efficiency and fault tolerance. Be it 1TB, be
it 10PB, data’s yours to own and dominate, thanks to the powerful data
tech available to us\!

Anywhoo… I had time today so I went ahead and did some analysis on this
aggregated data above. Enjoy. <br><br>

**Energy use by Tariff type** <br> As the graphs below
show, the households on standard tariff consume on average more energy
compared to the households on a dynamic time of use tariff throughout
the day and over time.

<p align="center">
  <img width="400" height="300" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/tariffdaily.png">
</p> 
<p align="center">
  <img width="400" height="300" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/tariffhourly.png">
</p> 

**Energy use by Economic (Acorn) Category** <br> According to the graphs below,
the Affluent and Comfortable households use comparable amounts of energy
throughout the day and over time, while Adversity households use
significantly less energy throughout the day and over time.

<p align="center">
  <img width="400" height="300" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/acorndaily.png">
</p> 
<p align="center">
  <img width="400" height="300" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/acornhourly.png">
</p> 

**Energy use by Tariff type and Economic Category** <br> Adversity households on
dynamic tariff use significantly less energy than those on regular flat
rate tariffs. This indicates that they are very conscious about money
spent on electricity would do whatever it takes to save.

<p align="center">
  <img width="600" height="280" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/tariffecoadversity.PNG">
</p> 

Households in comfortable category on dynamic tariff use more energy in
comparison to those on flat rate tariff. This indicates that middle
class people are lenient in changing their energy usage habits even when
provided with opportunities to save.

<p align="center">
  <img width="600" height="280" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/tariffecocomfortable.PNG">
</p> 

Households categorised as affluent who are on dynamic tariff use
slightly less energy in comparison to those on standard flat rate
tariff. This is an interesting finding, indicating that the richest
households would tend to be more frugal in their energy usage when
alerted about the prices ahead of time.

<p align="center">
  <img width="600" height="280" src="https://raw.githubusercontent.com/pgrugwiro/dataful-blog/main/_images/_post5/tariffecoaffluent.PNG">
</p> 

Data source: London Data Store

So, what will you use MapReduce to do?

#### NEVER.STOP.LEARNING