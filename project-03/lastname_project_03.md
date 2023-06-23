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


```r
library(tidyverse)
library(ggplot2)
library(viridis)
library(ggridges)
library(tidytext)
library(scales)
weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")
# random sample 
samplen<-sample_n(weather_tpa, 4)
```

See https://www.reisanar.com/slides/relationships-models#10 for a reminder on how to use this type of dataset with the `lubridate` package for dates and times (example included in the slides uses data from 2016).


```
## Warning: Removed 3 rows containing non-finite values (`stat_bin()`).
```

```
## Warning: Removed 24 rows containing missing values (`geom_bar()`).
```

<img src="lastname_project_03_files/figure-html/unnamed-chunk-2-1.png" width="80%" style="display: block; margin: auto;" />



Using the 2022 data: 

(a) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_facet.png" width="80%" style="display: block; margin: auto;" />

Hint: the option `binwidth = 3` was used with the `geom_histogram()` function.




(b) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_density.png" width="80%" style="display: block; margin: auto;" />

Hint: check the `kernel` parameter of the `geom_density()` function, and use `bw = 0.5`.



```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 3 rows containing non-finite values (`stat_density()`).
```

<img src="lastname_project_03_files/figure-html/unnamed-chunk-5-1.png" width="80%" style="display: block; margin: auto;" />



(c) Create a plot like the one below:

<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_density_facet.png" width="80%" style="display: block; margin: auto;" />

Hint: default options for `geom_density()` were used. 



```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 2 rows containing non-finite values (`stat_density()`).
```

<img src="lastname_project_03_files/figure-html/unnamed-chunk-7-1.png" width="80%" style="display: block; margin: auto;" />


(d) Generate a plot like the chart below:


<img src="https://github.com/reisanar/figs/raw/master/tpa_max_temps_ridges_plasma.png" width="80%" style="display: block; margin: auto;" />

Hint: use the`{ggridges}` package, and the `geom_density_ridges()` function paying close attention to the `quantile_lines` and `quantiles` parameters. The plot above uses the `plasma` option (color scale) for the _viridis_ palette.



```
## Warning: `stat(x)` was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(x)` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Picking joint bandwidth of 1.87
```

```
## Warning: Using the `size` aesthetic with geom_segment was deprecated in ggplot2 3.4.0.
## ℹ Please use the `linewidth` aesthetic instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

<img src="lastname_project_03_files/figure-html/unnamed-chunk-9-1.png" width="80%" style="display: block; margin: auto;" />



(e) Create a plot of your choice that uses the attribute for precipitation _(values of -99.9 for temperature or -99.99 for precipitation represent missing data)_.


```r
t2 <- tpa_clean %>%
filter(precipitation > 0)


ggplot(tpa_clean, aes(y=max_temp, x=precipitation)) +
  geom_point(color="red4")+geom_smooth(fill="lightblue", color="blue4")+theme_classic()
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](lastname_project_03_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## PART 2 

> **You can choose to work on either Option (A) or Option (B)**. Remove from this template the option you decided not to work on. 


### Option (A): Visualizing Text Data

Review the set of slides (and additional resources linked in it) for visualizing text data: https://www.reisanar.com/slides/text-viz#1

Choose any dataset with text data, and create at least one visualization with it. For example, you can create a frequency count of most used bigrams, a sentiment analysis of the text data, a network visualization of terms commonly used together, and/or a visualization of a topic modeling approach to the problem of identifying words/documents associated to different topics in the text data you decide to use. 

Make sure to include a copy of the dataset in the `data/` folder, and reference your sources if different from the ones listed below:

- [Billboard Top 100 Lyrics](https://github.com/reisanar/datasets/blob/master/BB_top100_2015.csv)

- [RateMyProfessors comments](https://github.com/reisanar/datasets/blob/master/rmp_wit_comments.csv)

- [FL Poly News Articles](https://github.com/reisanar/datasets/blob/master/flpoly_news_SP23.csv)


(to get the "raw" data from any of the links listed above, simply click on the `raw` button of the GitHub page and copy the URL to be able to read it in your computer using the `read_csv()` function)



```r
polynews <- read_csv("../data/flpoly_news_SP23.csv", col_types = cols())
poly_tokens <- polynews %>% 
  unnest_tokens(word, news_summary) %>%
  anti_join(stop_words, by = "word") %>% # remove stopwords
  group_by(news_title) %>% 
  count(word, sort = TRUE) %>% 
  top_n(9, n) %>% 
  ungroup() %>% 
  mutate(word = fct_inorder(word))
polywords <- poly_tokens[2]

polywords_total<- polywords %>% count(word)
```




```r
poly_sent2 <- polywords_total %>% 
  group_by(word) %>% 
   inner_join(get_sentiments("nrc"))# %>%
```

```
## Joining with `by = join_by(word)`
```

```r
poly_sent2<-poly_sent2[!(poly_sent2$word=="university"),]


total_sents <- poly_sent2 %>% group_by(sentiment) %>% 
  summarise(sum_sent = sum(n),
            .groups = 'drop')
total_sents
```

```
## # A tibble: 10 × 2
##    sentiment    sum_sent
##    <chr>           <int>
##  1 anger             102
##  2 anticipation      494
##  3 disgust            41
##  4 fear              181
##  5 joy               331
##  6 negative          260
##  7 positive         1319
##  8 sadness           118
##  9 surprise          151
## 10 trust             735
```




```r
poly_words_sentiment <- polywords %>% 
  group_by(word) %>% 
   inner_join(get_sentiments("nrc"))# %>%
```

```
## Joining with `by = join_by(word)`
```

```
## Warning in inner_join(., get_sentiments("nrc")): Detected an unexpected many-to-many relationship between `x` and `y`.
## ℹ Row 1 of `x` matches multiple rows in `y`.
## ℹ Row 1520 of `y` matches multiple rows in `x`.
## ℹ If a many-to-many relationship is expected, set `relationship =
##   "many-to-many"` to silence this warning.
```

```r
poly_words_sentiment<-poly_words_sentiment[!(poly_words_sentiment$word=="university"),]
#top10_words = poly_sent2 %>% group_by(sentiment) %>% top_n(10,n)
# library(dplyr)
top10_words = poly_sent2 %>% arrange(desc(n)) %>% group_by(sentiment) %>% slice(1:10)




ggplot(top10_words, aes(x =fct_rev(reorder(word, -n)), y = n, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = NULL) +
  scale_fill_viridis_d()+
  facet_wrap(vars(sentiment),nrow=3,scales = "free") +
  theme_minimal()+coord_flip()+theme(axis.text.x=element_text(size=7)) +
scale_y_continuous(breaks= pretty_breaks())
```

![](lastname_project_03_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
                                     #,axis.text.y=element_text(size=12))
#+
  # scale_fill_manual(values=c("red3",
  #                            "#E05D09",
  #                            "green3",
  #                            "gray2",
  #                            "violet",
  #                            "#7b5c00",
  #                            "yellow2",
  #                            "#007BD8",
  #                            "#037F25",
  #                            "purple4"
  #                            ))


ggplot(total_sents, aes(x =reorder(sentiment, +sum_sent), y = sum_sent, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = NULL) +
  scale_fill_viridis_d()+
  theme_minimal()+coord_flip()#+
```

![](lastname_project_03_files/figure-html/unnamed-chunk-13-2.png)<!-- -->

```r
  # scale_fill_manual(values=c("red3",
  #                            "#E05D09",
  #                            "green3",
  #                            "gray2",
  #                            "violet",
  #                            "#7b5c00",
  #                            "yellow2",
  #                            "#007BD8",
  #                            "#037F25",
  #                            "purple4"
  #                            ))
  # 
```


```r
ggplot(total_sents, aes(x =reorder(sentiment, +sum_sent), y = sum_sent, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = NULL) +
  #scale_fill_viridis_d()+
  theme_minimal()+coord_flip()+
  scale_fill_manual(values=c("red2",
                             "#E05D09",
                             "green3",
                             "black",
                             "yellow1",
                             "brown4",
                             "gold3",
                             "#007ED3",
                             "#037F25",
                             "#73BFF0"
                             ))
```

![](lastname_project_03_files/figure-html/unnamed-chunk-14-1.png)<!-- -->




