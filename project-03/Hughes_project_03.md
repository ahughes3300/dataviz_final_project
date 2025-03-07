---
title: "Data Visualization for Exploratory Data Analysis"
output: 
  html_document:
    keep_md: true
    toc: true
    toc_float: true
---

# Data Visualization Project 03

In this exercise you will explore methods to create different types of data visualizations (such as plotting text data, or exploring the distributions of continuous variables).

## PART 1: Density Plots

Using the dataset obtained from FSU's [Florida Climate Center](https://climatecenter.fsu.edu/climate-data-access-tools/downloadable-data), for a station at *Tampa International Airport (TPA)* for 2022, attempt to recreate the charts shown below which were generated using data from 2016. You can read the 2022 dataset using the code below:



See <https://www.reisanar.com/slides/relationships-models#10> for a reminder on how to use this type of dataset with the `lubridate` package for dates and times (example included in the slides uses data from 2016).

Using the 2022 data:

(a) **: Facet Wrap Histogram**

    **Graph**: This *histogram* shows the number of days for each of the maximum temperature bins per month for Atlanta 2022.

    **Analysis** : July and August are the hottest months shown here. Jan and Feb are cooler months with Jan having some very low max temperature days.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-2-1.png" width="80%" style="display: block; margin: auto;" />

(b) **Density Graph** :

    **Graph**: This density graph shows what the **proportions** of days are at for each temperature. This is for the entire year for 2022.

    **Analysis** : **Spikes** in max temperature can be seen at *70, 80, 90* with a large jump at ***90***. Every ten degrees there is an increase in proportion of days of the higher temperature.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-3-1.png" width="80%" style="display: block; margin: auto;" />

(c) **Facet Wrap Monthly Density Plots** :

    **Graph**: The graph shows the **density** for max temp values similar to the above graph but instead of the *entire* *year* are divided by **month**.

    **Analysis**: There is a very **large spike** in max temperature in **July** which coincides with the analysis on the *facet wrap* plot above. This is followed by *Aug* with *Jan* and *Feb* having much **lower** max temperatures. **July** seems to have been an extremely **hot** month in comparison to other months for the year. People should be aware and take precautions outside in the heat.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-4-1.png" width="80%" style="display: block; margin: auto;" />

(d) **Monthly Density Ridge Plots** :

    **Graph**: The graph shows the **density** for values similar to the above graph but places them in **1** column with many rows. The mounds of each column overlap each other. This makes it easy to see the trends of the density plots per month and not as condensed as the *facet wrap* graph above.

    **Analysis**: It is easy to see that the **middle months** of the year such as **July** and **August** denominate with **higher** temperature max temp days. Not only are they far right they are also higher than the other months indicating more days. The *color fill* also helps convey the temperatures with a *magma color scheme*.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-5-1.png" width="80%" style="display: block; margin: auto;" />

(e) Create a plot of your choice that uses the attribute for precipitation.

    **Picked**: The *ridge density monthly map*. I chose the Mako color pallete to display precipitation. I chose this because the blue color opposes the hot red-yellow of the magma palette. The clash in graphs is appealing as they are opposing elements, water is usually used to cool.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

-   **Data Used**: The days with precipitation **over** 0.1 inches were graphed here with the *density ridge graph*. The graph was *facet wraped* by month.

-   **Story:** Here it can be seen on the mound for April that it has the most amount of days with a heavy rain fall. Jan, Feb, Oct didn't have any days with more than 0.1 inches of precipitation. They would be good days for outdoor activities. Sept, Nov, Jul, and Jun had a small amount of days were precipitation approached or reached 3 inches. April is often referred to as a rainy month in many places, *April showers*, and it appears to be that case here as well.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-7-1.png" width="80%" style="display: block; margin: auto;" />

-   **Data Used**: This graph includes all days where precipitation was **above** zero. Max temperature were graphed against precipitation and a trend line was produced, default smooth line, with a shaded confidence area.

-   **Story:** Here it can be seen that days with a **higher** amount of precipitation tend to be on days where the max temperature was **above** 80. The trend line shows that it is much more likely to get a heavy rain on hotter days than cooler days.

## PART 2

### Option (A): Visualizing Text Data

Review the set of slides (and additional resources linked in it) for visualizing text data: <https://www.reisanar.com/slides/text-viz#1>

Choose any dataset with text data, and create at least one visualization with it. For example, you can create a frequency count of most used bigrams, a sentiment analysis of the text data, a network visualization of terms commonly used together, and/or a visualization of a topic modeling approach to the problem of identifying words/documents associated to different topics in the text data you decide to use.

Make sure to include a copy of the dataset in the `data/` folder, and reference your sources if different from the ones listed below:

-   [Billboard Top 100 Lyrics](https://github.com/reisanar/datasets/blob/master/BB_top100_2015.csv)

-   [RateMyProfessors comments](https://github.com/reisanar/datasets/blob/master/rmp_wit_comments.csv)

-   [FL Poly News Articles](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)

(to get the "raw" data from any of the links listed above, simply click on the `raw` button of the GitHub page and copy the URL to be able to read it in your computer using the `read_csv()` function)

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

#### NRC Sentiment Totals for All FL Poly Articles

-   **Data Source**: [flpoly_news_SP23.csv](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)

-   **Analysis:** Positive is by far the largest of the NRC sentiments for the articles with disgust being the lowest value sentiment. Overall all good emotions are associated with Florida Polytechnic in the articles. Middle values include fear and negativity.

-   **Issues**: The word University was removed due to being an extreme outliner, over 400 occurrences, and also being associated with the name Florida Polytechnic University as a place.

-   **Story:** The story that can be told here is what is being written about Florida Polytechnic University is associated with positive sentiment and low on negative sentiment. Public perception of Florida Polytechnic is good at least in article form.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

#### ***NRC*** **Sentiment Totals for All FL Poly Articles**

-   **Data Source**: [*flpoly_news_SP23.csv*](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)

-   **Analysis:** This is more of a granular approach than the generalized graph above. Here the details of the top 10 words per sentiment are shown. Community is the number 1 positive word and fall is the number 1 negative word. It is interesting if *NRC* should be separated out by meaning of the word, it is likely that fall here means a season and not actually falling to the ground. Pandemic tops the fear sentiment, this is likely due the recent pandemic and articles heavily writing about it 2020-2022

-   **Issues**: The word University was removed due to being an extreme outliner and also being associated with the name Florida Polytechnic University as a place.

-   **Story:** The story that can be told here is once again an overall **positive** sentiment. It is easy to see from the graph that positive sentiments like joy and trust are much thicker than negative sentiments such as fear and sadness. It seems for anger articles use the word challenging several times. Community and Career are high occurrence words, universities are often associated with careers and community as well.
