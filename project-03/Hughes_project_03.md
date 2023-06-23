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

Using the dataset obtained from FSU's [Florida Climate Center](https://climatecenter.fsu.edu/climate-data-access-tools/downloadable-data), for a station at Tampa International Airport (TPA) for 2022, attempt to recreate the charts shown below which were generated using data from 2016. You can read the 2022 dataset using the code below:



See <https://www.reisanar.com/slides/relationships-models#10> for a reminder on how to use this type of dataset with the `lubridate` package for dates and times (example included in the slides uses data from 2016).

Using the 2022 data:

(a) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_facet.png" width="80%" style="display: block; margin: auto;" />

Hint: the option `binwidth = 3` was used with the `geom_histogram()` function.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-3-1.png" width="80%" style="display: block; margin: auto;" />

(b) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_density.png" width="80%" style="display: block; margin: auto;" />

Hint: check the `kernel` parameter of the `geom_density()` function, and use `bw = 0.5`.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-5-1.png" width="80%" style="display: block; margin: auto;" />

(c) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_density_facet.png" width="80%" style="display: block; margin: auto;" />

Hint: default options for `geom_density()` were used.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-7-1.png" width="80%" style="display: block; margin: auto;" />

(d) Generate a plot like the chart below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_ridges_plasma.png" width="80%" style="display: block; margin: auto;" />

Hint: use the`{ggridges}` package, and the `geom_density_ridges()` function paying close attention to the `quantile_lines` and `quantiles` parameters. The plot above uses the `plasma` option (color scale) for the *viridis* palette.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-9-1.png" width="80%" style="display: block; margin: auto;" />

(e) Create a plot of your choice that uses the attribute for precipitation *(values of -99.9 for temperature or -99.99 for precipitation represent missing data)*.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

-   **Data Used**: The days with precipitation **over** 0.1 inches were graphed here with the *density ridge graph*. The graph was *faceted* by month.

-   **Story:** Here it can be seen on the hump for April that it has the most amount of days with a heavy rain fall. Jan, Feb, Oct didn't have any days with more than 0.1 inches of precipitation. They would be good days for outdoor activities. Sept, Nov, Jul, and Jun had a small amount of days were precipitation approached or reached 3 inches. April is often referred to as a rainy month in many places, *April showers*, and it appears to be that case here as well.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-11-1.png" width="80%" style="display: block; margin: auto;" />

-   **Data Used**: This graph includes all days were precipitation was **above** zero. Max temperature were graphed against precipitation and trend line was produced, default smooth line, with a shaded confidence area.

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

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

#### NRC Sentiment Totals for All FL Poly Articles

-   **Data Source**: [flpoly_news_SP23.csv](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)

-   **Analysis:** Positive is by far the largest of the NRC sentiments for the articles with disgust being the lowest value. Overall all good emotions are associated with Florida Polytechnic in the articles.

-   **Issues**: The word University was removed due to be an extreme outline, over 400 occurrences, and also being associated with the name Florida Polytechnic University as a place.

-   **Story:** The story that can be told here is what is being written about Florida Polytechnic University is associated with positive sentiment and low on negative sentiment. Public peception of Florida Polytechnic is good.

<img src="Hughes_project_03_files/figure-html/unnamed-chunk-13-1.png" style="display: block; margin: auto;" />

#### ***NRC*** **Sentiment Totals for All FL Poly Articles**

-   **Data Source**: [*flpoly_news_SP23.csv*](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)

-   **Analysis:** This is more of a granular approach than the generalized graph above. Here the details of the top 10 words per sentiment are shown. Community is the number 1 positive word and fall is the number 1 negative word. It is interesting if *NRC* should be separated out by meaning of the word, it is likely that fall here means a season and not actually falling to the ground.

-   **Issues**: The word University was removed due to be an extreme outline and also being associated with the name Florida Polytechnic University as a place.

-   **Story:** The story that can be told here is once again an overall **positive** sentiment. It is easy to see from the graph that positive sentiments like joy and trust are much thicker than negative sentiments such as fear and sadness.
