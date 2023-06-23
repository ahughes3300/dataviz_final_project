library(tidyverse)
library(ggplot2)
library(viridis)
library(ggridges)
library(tidytext)
library(scales)
library(lubridate)

## read in csv
weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")



##function to product graph 1A
P1A_graph<-function(){
  weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")

  ##data processing 
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))
  
  ## plot the graph 1A
  ggplot(tpa_clean, aes(max_temp, fill=month(ymd(doy),))) +
    geom_histogram(binwidth=3,colour = "white",lwd = 0.8,linetype = 1,
    position = "identity")+ facet_wrap(~month(ymd(doy),label=TRUE,abbr = FALSE),ncol=4) + 
    scale_fill_viridis(guide = "none")+theme_bw() + 
    theme(axis.text = element_text(size = 13),text = element_text(size = 17)) +
    xlab("Maxium temperatures") + 
    ylab("Number of Days")+ylim(0,20) +
    scale_x_continuous(breaks = seq(60, 90, 10), lim = c(55, 97))
  
}

###function for graph 1B
p1B_graph <-function(){
  weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")

### data processing
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))
  
  ## plot graph 1B
  ggplot(tpa_clean, aes(max_temp)) +
    geom_density(position = "stack",bw = 0.5,fill="#7F7F7F",kernel="epanechnikov",size=.8) +  
    scale_fill_grey()+theme_minimal() +
    ylim(0, 0.08)+ theme(axis.text = element_text(size = 13),text = element_text(size = 17)) +
    scale_x_continuous(breaks = seq(60, 90, 10), lim = c(55, 97)) +
    xlab("Maxium temperature") + 
    ylab("density")
}

## function to plot graph 1C
p1C_graph <-function(){
  weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")
  
## data processing
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))

##plot graph 1 c  
  ggplot(tpa_clean, aes(max_temp,fill=month(ymd(doy),label=TRUE))) +
    geom_density(size=1)+ facet_wrap(~month(ymd(doy),label=TRUE,abbr = FALSE)) +
    scale_color_viridis(guide = "none") +  
    guides(fill = FALSE) + 
    theme_bw() + theme(axis.text = element_text(size = 13),text = element_text(size = 17)) +
    xlab("Maxium temperatures") +
    ylab("") +
    scale_x_continuous(breaks = seq(60, 90, 10), lim = c(55, 100)) +
    scale_y_continuous(breaks = seq(0, .3, .05), lim = c(0, .38)) + 
    ggtitle("Density plots for each month in 2022")  
}

## function to graph 1D
p1D_graph <-function(){
  weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")
  
## data processing
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))

##plot graph 1D  
  ggplot(tpa_clean, aes(x = max_temp, y = month(ymd(doy),label=TRUE,abbr = FALSE), fill = stat(x))) +
    geom_density_ridges_gradient(size=1,quantile_lines = TRUE, quantiles = 2) +
    scale_fill_viridis_c(name = "Depth", option = "C") +
    coord_cartesian(clip = "off") + 
    theme_minimal()+xlab("Maxium temperature (in Fahrenheit degrees)") + 
    ylab("") +
    scale_x_continuous(breaks = seq(50, 100, 10), lim = c(50, 100)) + 
    theme(axis.text = element_text(size = 13),text = element_text(size = 17),legend.title = element_blank()) +
    labs(color = NULL) 
}

##fucntion to graph 1EE
p1EE_graph<-function(){
 
  ## data prcessessing 
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))
## data processing filter out days than are greater that 0.1 prciipitation  
  t2 <- tpa_clean %>%
    filter(precipitation > 0.1)
  
## plot out graph 1EE 
  ggplot(t2, aes(x = precipitation, y = month(ymd(doy),label=TRUE,abbr = FALSE), fill = stat(x))) +
    geom_density_ridges_gradient(size=1,quantile_lines = TRUE,quantiles = 2)+
    scale_fill_viridis_c(name = "Depth", option = "G") +
    theme_minimal()+xlab("Precipitation (inches)") + ylab("")+
    theme(axis.text = element_text(size = 13),text = element_text(size = 17),legend.title = element_blank()) +
    labs(color = NULL)  +
    xlab("Precipitation (inches)") +ggtitle("Days Precipitation Above 0.1 inches Atlanta 2022 ")+
    labs(title = "Days Precipitation Above 0.1 inches",
           subtitle = "Atlanta 2022")
}

## function to graph out 1E
p1E_graph <-function(){
  weather_tpa <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/tpa_weather_2022.csv")
  
## Data Processessing   
  tpa_clean <- weather_tpa %>% 
    unite("doy", year, month, day, sep = "-") %>% 
    mutate(doy = ymd(doy), 
           max_temp = as.double(max_temp), 
           min_temp = as.double(min_temp), 
           precipitation = as.double(precipitation))
  
  ## data processing filter out days that are greater than 0 prciipitation  
  t2 <- tpa_clean %>%
    filter(precipitation > 0)
  
## gpot out 1E  
  ggplot(tpa_clean, aes(y=max_temp, x=precipitation)) +
    geom_point(color="red4")+geom_smooth(fill="lightblue", color="blue4") +
    theme_classic()+xlab("Precipitation (inches)") +
    ylab("Maxium Temperature (F)") +
    labs(title="Trendline of Precicptation and Max Temp on Rainy Days") +
    theme(axis.text = element_text(size = 12),text = element_text(size = 14)) 
}

### graph out part 2 facet graph
P2_graph_facet <- function() { 
  ##read in data
  polynews <- read_csv("../data/flpoly_news_SP23.csv", col_types = cols())
  ## crate tokens
  poly_tokens <- polynews %>% 
    unnest_tokens(word, news_summary) %>%
    anti_join(stop_words, by = "word") %>% # remove stopwords
    group_by(news_title) %>% 
    count(word, sort = TRUE) %>% 
    top_n(9, n) %>% 
    ungroup() %>% 
    mutate(word = fct_inorder(word))
  ##processess tokens
  polywords <- poly_tokens[2]
  
  ##create dataframes
  polywords_total<- polywords %>% count(word)
  
  ##more processessing
  poly_sent2 <- polywords_total %>% 
    group_by(word) %>% 
    inner_join(get_sentiments("nrc"))
  
  poly_sent2<-poly_sent2[!(poly_sent2$word=="university"),]
  
  
  total_sents <- poly_sent2 %>% group_by(sentiment) %>% 
    summarise(sum_sent = sum(n),.groups = 'drop')
  
  poly_words_sentiment <- polywords %>% 
    group_by(word) %>% 
    inner_join(get_sentiments("nrc"))
  poly_words_sentiment<-poly_words_sentiment[!(poly_words_sentiment$word=="university"),]
  
  ## create top 10 words
  top10_words = poly_sent2 %>% arrange(desc(n)) %>% group_by(sentiment) %>% slice(1:10)
  
  ##plot p1 facet graph
  ggplot(top10_words, aes(x =fct_rev(reorder(word, -n)), y = n, fill = sentiment)) +
    geom_col() +
    guides(fill = FALSE) +
    labs(x = NULL, y = NULL) +
    scale_fill_viridis_d()+
    facet_wrap(vars(sentiment),nrow=3,scales = "free") +
    theme_minimal()+coord_flip()+theme(axis.text.x=element_text(size=7)) +
    scale_y_continuous(breaks= pretty_breaks())+
     labs(title = "Top 10 Words by NRC Sentiment for Poly Articles",
       caption = 'Word university removed due to excessive outlier')

}
## function for graph p2 bar graph
P2_graph_bar <- function() { 
  polynews <- read_csv("../data/flpoly_news_SP23.csv", col_types = cols())
 ## creat tokens
   poly_tokens <- polynews %>% 
    unnest_tokens(word, news_summary) %>%
    anti_join(stop_words, by = "word") %>% # remove stopwords
    group_by(news_title) %>% 
    count(word, sort = TRUE) %>% 
    top_n(9, n) %>% 
    ungroup() %>% 
    mutate(word = fct_inorder(word))
## data processessing   
  polywords <- poly_tokens[2]
  
  polywords_total<- polywords %>% count(word)
  
  poly_sent2 <- polywords_total %>% 
    group_by(word) %>% 
    inner_join(get_sentiments("nrc"))# %>%
  poly_sent2<-poly_sent2[!(poly_sent2$word=="university"),]
  
  
  total_sents <- poly_sent2 %>% group_by(sentiment) %>% 
    summarise(sum_sent = sum(n),
              .groups = 'drop')
  
### plot bar graph for p2 bar
  ggplot(total_sents, aes(x =reorder(sentiment, +sum_sent), y = sum_sent, fill = sentiment)) +
    geom_col() +
    guides(fill = FALSE) +
    labs(x = NULL, y = NULL) +
    scale_fill_viridis_d()+
    theme_minimal()+coord_flip()+
    labs(title = "NRC Sentiment Totals for FL Poly Articles",
         caption = 'Word university removed due to excessive outlier')
}

