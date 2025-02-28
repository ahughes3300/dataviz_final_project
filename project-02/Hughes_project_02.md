---
title: "Mini-Project 01"
output: 
  html_document:
    keep_md: true
    toc: true
    toc_float: true
---



![](Hughes_project_02_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

## Spatial Visualization

-   What I originally wanted to make was a world map showing the participants origins. However when going through the data it become apparent that there wasn't a high number participants represented outside the USA in comparison to inside the USA. So I switched to a USA map and decided to show the participants by state. I further divided the data by Sex to see if there were any visual differences.

-   The steps I took were filtering out the non USA participants and then further dividing them up by sex. I then summed the amount of each per state and created a new data frame to graph the data. Finally I wanted to have something interactive so I decided to use ***plotly package*** so the individual numbers per state can be seen.

-   Looking at this map you can see two things. That the general distribution of male and female participants is very similar as the colors for each state look similar. Also you can see which states have the most participants with **Massachusetts** having the most. This makes sense because the marathon is hosted in Boston. However whats interesting the second state is California. I think this is interesting because California is so far away from Massachusetts. It's also fun to see that they also had participants from Alaska and Hawaii.

-   I kept the design simple and used a base red color to make the populations stand out more, and kept it to one color. I made the title left aligned because the viewers eyes tend to view the left. I used a *facet* style graph to show side by side the male and female participants in a way that was easy to see. I used *ggploty()* to make the map interactive so you can hover over every plot and see the numbers. This draws in the user to use the map.


```r
source("../scripts/project2_scripts.R")
Project2_graph2_lm()
```

![](Hughes_project_02_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

## Linear Model Line Plot

-   For the model I originally planned to create a line with *geom_smooth()* and a linear model. I created a linear model then used the linear model data to draw three lines with its associated plot cloud. I also had to convert the time to seconds. I also originally wanted to plot age but it didn't turn out good.

-   Looking at the data you can see the plot cloud for the three different distances over Finish time. You can see where each distance as a linear model and how it associates with what it predicts where the finish time should be compared to the time at the associated distance. You can see the slopes of the predicted lines.

-   The story you can tell here is follow the line and if you passed a distance at x time your finish them will likely be y time. A runner can use this to target times they need to meet. This is followed for each of the three distances. I had difficulty here adding Age as a component it doesn't seem to create a usable line.

-   I continued to keep the design simple with bright colors to clash against the white background. I'm a fan of *theme_minimal()* and think it does a good job of de-cluttering the graph. I added a opacity to the plot points because they were so thick you couldn't see the lines. For each line I added an annotation to identify which line goes to which variable distance.


```r
source("../scripts/project2_scripts.R")
Project2_graph3_coefc()
```

![](Hughes_project_02_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Model Visualization Coefficient Plot

-   For the model I originally planed to create a coefficient plot. I wanted to have more elements originally but I decided to keep it simple and limit it to four plot elements, early in the race, middle of the race and late in the race and finally age. I found that adding more distances was somewhat redundant and complicated the model.

-   The steps I took were running the variables through a linear model, then getting the coefficients and converting the information into to tidy data.

-   Looking at this map you can see the coefficients and it has a vertical line at zero. Points that are close to the zero don't have much bearing on the outcome. Looking at the plots you can see that 10K is close to the zero line. You can also see that Half race has a value of **-1.3** which has a negative influence on the outcome and that 30K is **2.3** positive and has very strong bearing on the overcome of the Finish Time.

-   The Story here is that how you do early in the race has much less effect on your finishing time than how you do later in the race. One last coefficient I threw in here for the graph is Age, you see that Age age has large bearing on your Finish Time.

-   Difficulties I had were the linear model function in R would not take it in time properly I had to change all the times to seconds.

-   Again I kept design of the graph simple. I have a line in the graph to easily show where zero is. the points are large and easy to see. The theme used here is a minimal theme. I used a *SET2* palette to make the colors pop against the white background.

## Interactive Visualization

#### Go to Interactive_Viz.R and select run app to load up interactive bar graph. Below is a screenshot of the app for reference purposes.

![](../figures/pj2_interactive_screenshot.png){width="600"}



***Shiny App needs to be loaded up ***

**Go to Interactive_Viz.R and select run app to load up Shiny interactive bar graph. Above is a screenshot of the app for reference purposes.**

-   For my final visualization I wanted to create a *shiny* application. I decided on displaying the running information for each distance segment on a bar graph and I wanted to make it selectable for each runner in the marathon. I later decided to make a second runner selectable pull down menu so you can compare two runners information to each other.

-   To prepare the data I had to filter out all the missing or bad data. I also had to cut down the size of my data frame to 300 because large sizes were causing errors.

-   This map allows an interesting story , you can select two different runners. You can compare their different times at each distance. On the left side you get personal information about the runner such as name, sex, country of origin and age. I used up nearly all the variable information in the dataframe and feel I represented it well in the graph.

-   I had difficulty with the dataframe at full size and had to limit the graph to the top 300 participants. I think I was running out of memory on my computer with a larger dataset, but I am not sure.

-   The interactive visualization is fairly self explanatory On the left in a clearly marked box you can select between two drop menus. The names for the top 300 runners are in each menu. When you select participant their information is listed below and the graph to right is updated to display each runners times per distance run along with their pace. You can then directly compare two runners.

-   I chose bar graphs because they easily display the information and fill up the available space . I kept the rest of the graph simple with easy to understand legend and labels and used a minimal theme. I chose the colors yellow and blue because they are the colors of the Boston Marathon and very close to being complimentary colors. I decided on changing from seconds to minutes because people understand minutes in large numbers more than seconds.
