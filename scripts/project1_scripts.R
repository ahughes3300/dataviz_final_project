library(tidyverse)
library(ggplot2)

birhtrate_cvs <- read_csv("../data/us_births_00_14.csv",col_types = cols())
### dataframe for birthrate by year used for most graphs
birthrate_by_year <- plyr::ddply(birhtrate_cvs,"year",numcolwise(sum))


#### function to create the line graph one Birthrates from 2000-2014
graph1 <-function(){

  graph1<-ggplot(data = birhtrate_cvs, aes(x = year, y = births)) +  
  stat_summary(fun = sum, geom="line", colour = "red", linewidth = 1) +
  labs(title = "Birthrates From 2000-2014", colour ="Top Month") +
  xlab("Year 2000-2014")+ylab("Total Births for Year")
  
  graph1
}

#### Function to create the line graph Birthrates From 2000-2014 with Top Month
graph2 <- function(){
### create a dataframe for birthrates by the year
  library(plyr)
  birthrate_by_year <- plyr::ddply(birhtrate_cvs,"year",numcolwise(sum))
  
  # data_max3 <- brith_month_totals_by_year %>%               
  #   group_by(year) %>%
  #   summarise_at(vars(births),
  #                list(max = max))
  
  top_month <- c("Aug", "Aug", "Aug", "July", "July", "Aug", "Aug", "Aug", "July", "July", "Sep", "Aug", "Aug", "Aug", "July"  )
  
  
  graph2<-ggplot(birthrate_by_year, aes(x = year, y = births, color=top_month)) +
    geom_line(color='steelblue4') +
    scale_x_continuous(breaks = birthrate_by_year$year) +
    scale_color_discrete(name  ="Top Month")+
    geom_point()+scale_color_brewer(palette="Dark2") +
    labs(title = "Birthrates From 2000-2014 with Top Month", colour ="Top Month") +
    xlab("") +
    ylab("Total Birts per Year")
  
  graph2
}

### function to create graph 3 Birth Percentage and Total by Day for 2000-2014
### create facet bar graphs
graph3<-function(){
  
  
  ### dataframe for birthrate by year used for most graphs
  library(dplyr)
  birthrate_by_year <- plyr::ddply(birhtrate_cvs,"year",numcolwise(sum))
  #### Data proprecessing create the dataframe for graph 3
  ### Creating a new dataframe for births per month with totals by day
  ### and percent of births each day
  ### dataframe for birthrate by year used for most graphs
  year <- c(2000)
  day <- c(1)
  births <-c(2)
  percent <-(0)
  birth_month_totals_by_day_porportions <- data.frame(year, day, births, percent)
  days_of_week<-c("Sat","Sun","Mon", "Tues", "Wed","Thurs","Fri")
  
  for (years in 2000:2014) {
    for(i in days_of_week){
      summer <- sum(birhtrate_cvs[which(birhtrate_cvs$day_of_week==i & birhtrate_cvs$year==years),6])
      total_births_year <- birthrate_by_year$births[birthrate_by_year$year==years]
      percent_day <- (summer/total_births_year)*100
      birth_month_totals_by_day_porportions[nrow(birth_month_totals_by_day_porportions) + 1,] <- list(years, i, summer,percent_day)
    }}
  
  birth_month_totals_by_day_porportions = birth_month_totals_by_day_porportions[-1,]
  
  ###code for creating graph 3
  graph3<-ggplot(birth_month_totals_by_day_porportions, aes(x = fct_rev(day), y = percent, fill=births)) + 
    geom_col() +
    coord_flip() +
    facet_wrap(~ year,scales="free", ncol=5) + 
    labs(y = "Percent of Births per Day", x = "",title="Birth Percentage and Total by Day for 2000-2014")+
    scale_color_brewer(palette = "Dark2")+
    theme(panel.background = element_rect(fill = "#Eedfcd"),strip.background =element_rect(fill="#Eedfcd"))
  
  graph3
}

### function for creating graph4 Births by Day for August 2005-2007
graph4<-function(){
  
  #####Create a new dataframe for August births for years 2005-2007
  aug_birth3 <- subset(birhtrate_cvs, month == 8 & (year==2005 | year==2006 | year==2007))
  
  #### code for graph 4
  graph4<- ggplot(aug_birth3,aes(x = date_of_month, y = births, color = day_of_week)) +
    geom_pointrange(aes(ymin = 0, ymax = births,shrink=TRUE)) +
    facet_wrap(~ year, scales="free",ncol=1) + 
    theme_minimal()+
    scale_color_discrete(name  ="Day of Week")+
    scale_x_continuous(breaks = aug_birth3$date_of_month)+
    labs(y = "Number of Births", x = "Day of the Month",title="Births by Day for August 2005-2007")
  
  graph4
  
}