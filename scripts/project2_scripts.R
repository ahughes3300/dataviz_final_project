library(tidyverse)
library(usmap)
library(ggplot2)
library(broom)
library(lubridate)
library(plotly)

marathon_usa_sex_pace <- read_csv("../data/marathon_usa_sex_pace.csv")

project2_graph1_map <- function(){
  
  ### create a choropleth
  p <- plot_usmap(data = marathon_usa_sex_pace, values = "number", color = "black",)+scale_size_continuous(range = c(min(marathon_usa_sex_pace$n), max(marathon_usa_sex_pace$n)))+  scale_fill_continuous(
    low = "#FEEBE7", high = "red", name = "Total", label = scales::comma
  ) + theme(legend.position = "right")+
    facet_wrap(~ Sex,ncol = 1,labeller = as_labeller(c('F' = "Number of Female Pariticpants", 'M' = "Number of Male Participants"))) +ggtitle(label = "Boston Marathon 2017")
  
  p2<-p + theme(
    legend.position = c(1, .3), 
    legend.background = element_rect(fill = "white", colour = NA),
    strip.background = element_blank(),
    plot.title = element_text(size=20),
    strip.text = element_text(size=15),
    panel.spacing = unit(2, "lines"),
    plot.caption = element_text("State of Participants Origin")
    
  )
  
  ggplotly(p2) 
}

### read in and process data
marathon <- read_csv("../data/marathon.csv")
marathon <- na.omit(marathon)
marathon$Half<- hms(marathon$Half)
marathon$OfficialTime<- hms(marathon$OfficialTime)
marathon$tenK<- hms(marathon$tenK)
marathon$thirtyK<- hms(marathon$thirtyK)
marathon$Pace<- hms(marathon$Pace)

marathon$Half<- as.numeric(marathon$Half)
marathon$OfficialTime<- as.numeric(marathon$OfficialTime)
marathon$tenK<- as.numeric(marathon$tenK)
marathon$thirtyK<- as.numeric(marathon$thirtyK)
marathon$Pace<- as.numeric(marathon$Pace)


Project2_graph3_coef<-function(){
  ### create models
  
  ### create model 2
  m2_model <- lm(OfficialTime ~ tenK + Half + thirtyK, data = marathon)
  tidy(m2_model)
  m2_coefs <- tidy(m2_model, conf.int = TRUE) %>% filter(term != "(Intercept)")  
  
  ### create model 3
  m3_model <- lm(OfficialTime ~ tenK + Half + thirtyK+Age,data = marathon)
  tidy(m3_model)
  m3_coefs <- tidy(m3_model, conf.int = TRUE) %>% filter(term != "(Intercept)")  
 
  
  ###create coefficent plot from models 
  lables2<-c("30K","10K", "Half Race","Age")
  
  pco<-ggplot(m3_coefs,aes(x = estimate, y = fct_rev(term))) +
    geom_pointrange(aes(xmin = conf.low, xmax = conf.high, color=fct_rev(term)),size=.75) +
    geom_vline(xintercept = 0, color = "purple") + 
    scale_color_brewer(palette="Set1") +
    theme_minimal() +
    labs(title = "Linear Model Coefficents for Finish Time", x= "Estimate Coefficent", y="Distance Run") +
    scale_color_discrete(name="Distance Run", labels=lables2) +
    scale_y_discrete(labels=lables2)
  
  pco
}

Project2_graph2_lm<-function(){
  
  ### read in and process data
  marathon <- read_csv("../data/marathon.csv")
  marathon <- na.omit(marathon)
  marathon$Half<- hms(marathon$Half)
  marathon$OfficialTime<- hms(marathon$OfficialTime)
  marathon$tenK<- hms(marathon$tenK)
  marathon$thirtyK<- hms(marathon$thirtyK)
  marathon$Pace<- hms(marathon$Pace)
  
  marathon$Half<- as.numeric(marathon$Half)
  marathon$OfficialTime<- as.numeric(marathon$OfficialTime)
  marathon$tenK<- as.numeric(marathon$tenK)
  marathon$thirtyK<- as.numeric(marathon$thirtyK)
  marathon$Pace<- as.numeric(marathon$Pace)
  
  ### create models
  
  ### create model 2
  m2_model <- lm(OfficialTime ~ tenK + Half + thirtyK, data = marathon)
  tidy(m2_model)
  m2_coefs <- tidy(m2_model, conf.int = TRUE) %>% filter(term != "(Intercept)")  
  
  ### create model 3
  m3_model <- lm(OfficialTime ~ tenK + Half + thirtyK+Age,data = marathon)
  tidy(m3_model)
  m3_coefs <- tidy(m3_model, conf.int = TRUE) %>% filter(term != "(Intercept)")  
 
  
  
  ggplot() +
    geom_smooth(aes(x = tenK, y = OfficialTime), data = m2_model, 
                method = "lm", se = FALSE, color = "red4") + 
    geom_smooth(aes(x = Half, y = OfficialTime), data = m2_model, 
                method = "lm", se = FALSE, color = "blue4") + 
    geom_smooth(aes(x = thirtyK, y = OfficialTime), data = m2_model, 
                method = "lm", se = FALSE, color = "green4") + 
    geom_point(aes(x = tenK, y = OfficialTime), data = m2_model, color = "red",alpha = 0.02)+
    geom_point(aes(x = Half, y = OfficialTime), data = m2_model, color = "blue",alpha = 0.02) +
    geom_point(aes(x = thirtyK, y = OfficialTime), data = m2_model, color = "green",alpha = 0.02)+ 
    annotate('text', x = 5100, y = 27000, label = 'Ten K',size = 5,angle='68', color= 'red4')+ 
    annotate('text', x = 11000, y = 25500, label = 'Half Race',size = 5,angle='51', color= 'blue4')+ 
    annotate('text', x = 18000, y = 27500, label = 'Thrity K',size = 5,angle='41', color= 'green4')+labs(
    title = "Linear Model Line for Offical Time by Distance Time", x= "Distance Time in Seconds", y="Finish Time in Seconds")+theme_minimal()
  
  
  
  
  
  
}