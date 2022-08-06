---
layout: post
title: "ADFS: Interactive Data Visualization"
date: 2022-01-08 20:50:22 +0000
output:
  md_document:
    variant: gfm
    preserve_yaml: yes
  html_document:
    df_print: paged
always_allow_html: yes

categories: jekyll update
image: /assets/feature_images/post6.jpg
permalink: /:title:output_ext
---


This post is showcasing the use Tableau to exploring various datasets on local authority schools in England. 

#### Introduction

A major key performance index in an organization, either for or not for
profit, is the effective management of resources. In an educational
setting, effective money management could lead to student success, staff
satisfaction, and overall prosperity of the institution while improper
use of money could have long lasting negative consequences. The people
in charge must make effective, fact and data driven decisions to lead
their organisations to success. One tool that helps achieve this
objective is an information dashboard, “a visual display of the most
important information needed to achieve one or more objectives;
consolidated on a single screen so that the information can be monitored
at a glance” (Few, 2004). An information dashboard has been referred to
as “a virtual staff of 24x7 analysts” where “each agent in the dashboard
intelligently gathers, processes and presents data, generating alerts
and revising actions as conditions change” (Hovis, 2002). The purpose of
this project is to analyse the financial reports of the Local Authority
maintained primary schools across England and to build an interactive
visualization that could be used to derive insights from the raw data.

#### Data

The dataset used in this project was retrieved from “Find and Compare
Schools in England” (Gov.UK 2021), an online repository for the
educational data in England. The repository contains a wide range of
reports from schools in the country. These reports comprise of general
school information, academic performance, pupil census, staff and
workforce information, financial report, and more. In this project, the
focus is on the financial reports, which contains details on the sources
of income for schools as well as itemized expenses. The financial report
is combined with selected key variables from other reports to identify
possible correlations and to study the impact, if any, of money
management on academic performance of the pupils. The find and compare
schools in England offers users the ability to retrieve historical
school information in four easy steps: 1. Select the academic year of
interest (2018-2019 for this project), 2. Choose data for all England or
a specific Local Authority (all England for this project), 3. Select
desired data type (general school information, financial, and
performance data), 4. Download data in the desired format (CSV). The
platform then provides a zip file containing all the datasets as well as
a data dictionary that explains all the variables contained in the
dataset.

Figure 1. Instructions to Download Data

In addition to original variables, additional variables were derived
from the data by means of algorithmic clustering or simple computations.
Finally, latitude and longitude data for each school were added to the
core dataset to help place the schools on a map. Below is the complete
list of variables used in the study: Table 1. Data Dictionary Name
Description Domain LAESTAB Local Authority Number + Establishment Number
Nominal LONDON/NOT LONDON Describes whether the school is in London or
not Boolean REGION NAME Name of the region in which the school is
located Nominal RATPUTTEA Pupil: Teacher Ratio Float SALARY Mean Gross
Salary Float GRANTFUNDING Funds received through various government
grants + funds delegated by the local authority Float
SELFGENERATEDINCOME Income from facilities, services, donations, private
funds, etc.. Float TOTALEXPENDITURE Total Expenditure Float OFSTEDGRADE
4-point grading system Nominal PTRWM\_EXP Percentage of pupils reaching
the expected standard in reading, writing, and maths Float LATITUDE
Latitude of the school location Float LONGITUDE Longitude of the school
location Float NET INCOME Derived from (GRANTFUNDING +
SELFGENERATEDINCOME – TOTAL EXPENDITURE) Float CLUSTER Algorithmic
clustering based on various spending categories (teaching staff, supply
staff, education support staff, premises, back office, catering, energy,
learning resources, ICT, professional services, other expenses) Float

#### Data Cleaning and Exploration

The data cleaning and exploration activities were completed in R, a
statistical and data analysis open-source software. The data cleaning
process involved steps to change the variables to their appropriate data
types, e.g., character to numerical, standardizing number format, as
well as removing special characters such as pound sterling signs. Data
exploration involved steps to remove strong outliers, impute missing
data points or drop variables with a significant amount of missing data
points. In addition, a distance-based hierarchical clustering algorithm
was applied on the dataset to identify 3 different clusters based on
school spending and workforce information. This algorithmic clustering
did not yield logically different clusters and was henceforth dropped
from further consideration.

Figure 2. Hierarchical Clustering of Spending and Workforce Variables.
Persona Specification The user of the data visualization is an employee
at the department of education who was tasked to compile a financial
report that highlights school spending per pupil in all local authority
maintained primary schools across England. At a glance, the user should
be able to see the top spending local authorities in each geographic
region of the country. Specifically, the user must be able to answer the
following two questions: 1. How does the spending vary across local
authorities within a given geographical region? 2. Is there a
relationship between spending, school ranking, and pupil’s success?

#### Requirements Specification

Different views (charts and graphs) were developed to help the user
answer the questions above. To answer the question “How does the
spending vary across local authorities within a given geographical
region?”, the user must use the following visualizations: - A horizontal
column chart that shows the average expenditure per pupil by local
authority. - A map showing the location of the local authorities and
individual schools. - A doughnut chart showing the proportions of
spending categories. To answer the question “Is there a relationship
between spending, school ranking, and pupil’s success?”, the following
visualizations will be used: - A barplot of Ofsted Ranking by Average
Expenditure - A scatterplot of expenditure vs. academic performance of
pupils (reading, writing, and maths). In addition to the views above,
additional key performance indices were developed to help the user
further assess the difference between various local authorities and
regions. The KPIs are: 1) student success rate average for local
authority or region, and 2) self-generated income percentage of total
income for local authority or region. The infographic was designed to
fit on a standard desktop screen and should be viewed without the need
to scroll. The size of the infographic is 1000x800.

#### Prototype Design

Below is the initial paper landscape design. From this infographic, the
user can gain useful insights on how money is being managed by local
authority maintained primary schools across England. The user can easily
see the top spending regions and the impact, if any, to the school
rating and academic performance of pupils. Following the feedback
received, the infographic’s functional requirements were refined as
elaborated in the steps under the Evaluation subsection. Additional
changes were also made to the infographic in the final implementation to
better answer the user’s questions. The following changes were made to
the initial prototype design: - Expenditure by Region was replaced by
Expenditure by Local Authority. The latter gives the user the
opportunity to drill down further at the local authority level. -
Expenditure by Ofsted grade was sorted from highest to lowest for better
visualization. - Expenditure vs. Pupil’s success was replaced by Salary
vs. Pupil’s success after determining that amongst all spending
categories, salary is the one with the highest impact on the academic
success of the pupils. - Filters were changed: London vs. Not London was
replaced by the Region filter, allowing the user to simply pick a region
of interest. Total Expenditure vs. Net Income was removed from
consideration after data analysis showed no value added. Top N Local
Authority parameter was added to the chart to allow the user to modify
the number of top spending local authorities to display.

Figure 3. Prototype Design.

#### Implementation

The horizontal column chart was made by plotting the aggregated average
total expenditure by region and local authority. An additional Rank
variable was created to be used for ranking the local authorities by
their average expenditure. A filter for region was added on the chart to
allow the user to select any given region of interest and retried the
data for that region only. The user is also able to select all regions.
Due to the high number of local authorities, the chart cannot be easily
viewed by the user. To overcome this challenge, a control parameter, Top
N, was created to control the number of local authorities to be shown on
the visual. A default value of 5 is used and the user can change this
parameter to any number. For good visibility, it is recommended that the
user picks a maximum of 10 local authorities for this chart. In the
dashboard, this horizontal column chart was used as a filter, which
allows the user to select any given local authority of interest and view
the data for that local authority only.

Figure 4. Column Chart of Expenditure by Local Authority. The regional
map of England was made by plotting the latitude vs longitude, coloured
by region to view the geographical borders between regions, and total
expenditure and school name added to the tooltip to allow the user to
view individual school’s information. Total expenditure is also added to
the size mark to provide relative comparison of spending amongst
different schools. The region filter is applied to the graph, allowing
the user to view one region at a time or all regions at once.

Figure 5. Map Chart of Primary Schools in England.

To view the proportions of spending categories for each selected local
authority or region, a doughnut chart was drawn. Spending is split into
four different categories: Faculty and staff salaries, spending related
to maintaining the school property, spending related to teaching
resources and ICT, and other spending (ex. Catering, etc…).

Figure 6. Pie chart showing major spending categories.

Ofsted grading rates the schools using a four-point system: Inadequate,
Requires Improvement, Good, and Outstanding. The following areas are
inspected: effectiveness of leadership and management, quality of
teaching, learning and assessment, personal development, behaviour and
welfare, and outcome for pupils. The average expenditure by Ofsted grade
chart allows the user to see if there exists a relationship between
spending and school grade. The user can view the chart for the entire
region or for a specific local authority. The user is also able to
select a specific rating and the map will show the schools that fall
into that rating category.

Figure 7. Average Spending by Ofsted Grade Ranking.

The success of the pupils is measured in terms of their ability in
reading, writing, and math. Each school has a percentage value for its
pupils. Through data analysis, it was observed that the higher the
teacher salary the higher the success rate of students. It was also
noticed that schools with a higher percentage of self-generated income
with respect to the total income tend to have higher pupil’s success
rate.

Figure 8. SGI & Average Teacher Salary vs. Student Success.

Two key performance indices were introduced: SGI (self-generated income
percentage) and SSR (average student success rate), which allows the
user to easily determine if a given local authority or region is higher
or lower than average in terms of SGI and SSR.

The final implementation of the design is shown below. All the views fit
together in once single 1000x800 desktop screen.

Figure 9 Design Implementation - Tableau.

#### Evaluation

The dashboard design is simple, clean, and aesthetic. All the views fit
nicely on the graph, are easily seen by the user with minimal effort,
and their interactions are fluid. More importantly, the dashboard helps
answer the user’s questions. To answer the question “How does the
spending vary across local authorities within a given geographical
region?”, the user must follow these steps: - The user selects a region
of interest from the Region filter, - A horizontal column chart that
shows the average expenditure per pupil per local authority, sorted from
highest to lowest within the chosen geographical region appears in the
top left corner of the infographic. - With the control parameter “Top N
LA”, set to 5 by default, the user can change the number of local
authorities to display (up to 15 top local authorities can be easily
viewed). This chart helps the user visualize if the spending is evenly
distributed or if a certain local authority is spending more money per
pupil compared to the rest in the same region. - The user can then
select a specific local authority by clicking on the corresponding
column to view the data related to that specific local authority,  
- The size of the circles in the regional map correspond to the total
average spending for each specific local authority displayed on the map.
- The doughnut chart in the middle of the infographic provides
additional information on the proportions of the spending categories for
the selected region or selected local authority. To answer the question,
“Is there a relationship between spending, school ranking, and pupil’s
success?”, the user must take the following steps: - The user selects
the region of interest from the Region filter, - The column chart of
Expenditure by Ofsted grade appears at the bottom left of the
infographic, ranked from top spending category to lowest spending
category, - The user can select a local authority within the region and
view the Expenditure by Ofsted grade chart for that local authority. -
Over the course of data analysis, it was noticed that there exists a
positive correlation between teacher salary and pupil’s success. A
scatterplot of average teacher salary vs. student success for all
schools in the chosen region or local authority is provided on the
infographic, allowing the user to confirm that such relationship exists
for selected regions or local authorities. - The analysis also showed
that schools with more self-generated income tend to have more
successful students. Therefore, two key performance indices were
generated that show the percentage of self-generated income with respect
to total income as well as the average student success rate for the
selected region/local authority. The user can see how the chosen
region/local authority compares to national averages. Finally, a
download PDF button was added on the infographic, allowing the user to
download, print or save the infographic for external use. As per
requirement, the infographic is 1000x800 Desktop Browser size. The
infographic provided an unexpected insight: for nearly all regions and
local authorities, the schools that have the highest spending are the
ones that are rated “Inadequate” per OfSted Grade and the schools in the
“Outstanding” category have the lowest average spending per pupil. This
leads to an unexpected conclusion that effective management of resources
is a primary consideration in Ofsted Grading. Over the course of
dashboard design, it was also noticed that various spending categories
have no impact on the student success except the teacher salary. It was
observed that the higher the teacher salary the more successful the
pupils are in terms of reading, writing, and maths, and this would be a
key information to consider when trying to improve the success rate of
students. Likewise, it was observed that schools that are creative in
terms of generating their own income also tend to have more successful
students.

#### Implementation of the design in Power BI

The design above was implemented in Power BI, following the same
principles and logic. Generally, the solution is nearly identical aside
from the colour palette from the two software that is slightly
different. In terms of putting together the dashboard, Power BI is more
user-friendly when it comes to adding, lining, justifying new elements
to the canvas. The map function in Power BI is also more user-friendly
compared to Tableau. The other advantage of Power BI over Tableau for
this solution was the ability to rotate the x-axis labels by 45 degrees
on the Expenditure vs. Ofsted Grade chart, allowing the user to properly
read the labels. This function is not available in Tableau. In Tableau,
it was much easier to manipulate the actual charts and create new
variables and parameters. As an example, the Top N parameter in Tableau
could not be easily implemented in Power BI. Also, Power BI made it
challenging to implement a 2-level display on the Local Authority
Expenditure per Pupil chart and does not show the region column as is
the case in Tableau. It was also difficult to implement the ranking
variable for the same chart. Nevertheless, both solutions work and can
be used to answer the user’s questions.

Figure 10. Design Implementation - Power BI.

#### Reflective Discussion

This project was a success. It achieved its main objective, which was to
implement an information graphic that could be used by the defined
persona to find answers to pre-defined questions. The final solution
also allowed the user to uncover additional insights beyond the initial
posed questions. Finally, a secondary visualization tool, Power BI, was
used to implement the same solution. Both Tableau and PowerBI
implementations followed the accepted principles of infographic design
(Few 2013). The following principles were considered in the design: -
Organize information to support its meaning and use: putting items that
belong together in the same groups. The infographic has the top half
answering persona question 1: Spending distribution by Local Authority
and the bottom half answering persona question 2: the relationship
between spending and pupil’s performance. The generated key performance
indices were also put together in the middle of the infographic. -
Delineate groups by using least visible means. Space was used to
elegantly separate different views and groups. - Avoiding excessive
level of detail and meaningless comparisons. Although it was possible to
compare individual schools to one another, this level of detail was
avoided as it would clutter the infographic and would not necessarily
serve the overall purpose which was to compare local authorities within
a geographical region. - Keeping bright colours to a minimum, using less
saturated colours, and using a barely discernible pale background. The
choice of colours and colour gradient in the infographic followed these
colour principles. In addition to colours, no meaningless decoration was
added to the dashboard to animate or exaggerate what evidence there is
in the data, a common malpractice in dashboard design (Tufte 1983). In
addition to adhering to the above design principles, attribute
exploration was implemented in the dashboard, allowing the user to pick
an individual attribute of interest and retrieve information and metrics
for that attribute. For example, the user might be interested to find
the expenditure numbers for only the local authorities that achieved the
“outstanding” grade. Attribute explorer is described as “Given a
collection of objects, each described by the values associated with a
set of attributes, find the most acceptable such object or, perhaps, a
small number of candidate objects suited to more detailed consideration
(Spence and Tweedie, 1998). This project provided a great learning
experience, from data collection, cleaning and exploration to persona
and persona question definition, to design and implementation. At the
implementation stage, advanced techniques such as “Level of Detail
(LoD)” calculations were used to make the visualization possible. The
collaborative nature of the project at the initial stage provided an
opportunity to work in a group and to provide and receive constructive
feedback. Course material and external research was consulted to create
views that follow best practice. I count on building upon the knowledge
I gained in the module and in the coursework to continue practicing and
building more visualization tools for my blog (<https://dataful.blog>).

References 1. Few, S (2004) Dashboard Confusion, Intelligent Enterprise
2. Few, S (2013) Information Dashboard Design: Displaying data for
at-a-glance monitoring. Analytics Press. 3. GOV.UK, (2021). Find and
Compare Schools in England. \[Online\] Available at:
<https://www.compare-school-performance.service.gov.uk/download-data>
\[Accessed 1/4/21\]. 4. Hovis L., Gregory (2002). “Stop Searching for
Information – Monitor it with Dashboard Technology.” DM Direct. 5.
Spence, R. and Tweedie, L. (1998). “The Attribute Explorer: information
synthesis via exploration”. Imperial College, London, UK 6. Tufte, E.R.,
(1983). “The Visual Display of Quantitative Information”. Graphics Press
