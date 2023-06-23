#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(forcats)
library(plotly)

#marathon_csv <- read_csv("https://raw.githubusercontent.com/reisanar/datasets/master/marathon_results_2017.csv")
#marathon500 <- head(marathon_csv, 100)
marathon <- read_csv("data/marathon.csv")
marathon500 <- head(marathon, 300)
colnames(marathon500)[9] ="tenk"
colnames(marathon500)[19] ="OfficalTime"




# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("2017 Boston Marathon Top 300 Participant Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "Participant_Name",
                      label ="Choose a Participant",
                      "Names"),
          
          htmlOutput("selected_var1"),
          
          selectInput(inputId = "Participant_Name2",
                      label ="Choose a Participant",
                      "Names"),    
          
          htmlOutput("selected_var2"),
          ),

        
        
        
        

        # Show a plot of the generated distribution
        mainPanel(
          
          
          #textOutput("selected_var"),
          
           plotOutput("plot500")
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  observe({
    updateSelectInput(session,"Participant_Name", choices = marathon500$Name)
  })
  
  observe({
    updateSelectInput(session,"Participant_Name2", choices = marathon500$Name, selected = marathon500$Name[300])
  })
  
  data <- reactive({
    req(input$Participant_Name)
    req(input$Participant_Name2)
    Participant_Name = input$Participant_Name
    Participant_Name2 = input$Participant_Name2
    data4 <- data.frame(Name=c(Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,Participant_Name,    Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2,Participant_Name2) ,
                        race=c("5K","10K","15K","20K","Half","25K","30K","35K","40K","Finish","Pace","5K","10K","15K","20K","Half","25K","30K","35K","40K","Finish","Pace") ,  
                        time=c(as.numeric(marathon[which(marathon500$Name == Participant_Name), 8]/60  ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name), 9] /60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name), 10] /60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name), 11]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 12]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 13] /60 ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 14]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 15]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 16]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 18] /60 ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name), 17] /60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 8] /60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 9]/60),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 10]/60  ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 11]/60  ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name2), 12]/60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 13] /60 ),
                               as.numeric(marathon[which(marathon500$Name == Participant_Name2), 14] /60 ),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name2), 15]/60),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name2), 16]/60),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name2), 18]/60),
                               as.numeric(marathon500[which(marathon$Name == Participant_Name2), 17]/60)           
                               )
    ) 
    
      
  })
  
  output$plot500 <- renderPlot({
    # print(data())
    # p<-ggplot(data(), aes(x = fct_inorder(race), y=time, fill=race)) + 
    #   geom_col()+ylim(0,10000) 
    # p

    
    p<-ggplot(data(), aes(x = fct_inorder(race), y=time, fill=Name)) + 
      geom_col(position = "dodge")+ylim(0,170)+
      xlab("") + ylab("Time in Minutes")+ xlab("Distance")+
      scale_fill_manual(values = c("#EAC115", "#153EEA"))
    p+theme_minimal()
    
  })
  
  # output$selected_var <- renderText({
  #   age1<-marathon[which(marathon500$Name == input$Participant_Name), 3]
  #   age2<-marathon[which(marathon500$Name == input$Participant_Name2), 3]
  #   name1 <-input$Participant_Name
  #   name2 <-input$Participant_Name2
  #   sex1 <- marathon[which(marathon500$Name == input$Participant_Name), 4]
  #   sex2 <- marathon[which(marathon500$Name == input$Participant_Name2), 4]
  #   city1 <- marathon[which(marathon500$Name == input$Participant_Name), 5]
  #   city2 <- marathon[which(marathon500$Name == input$Participant_Name2), 5]
  #   country1 <- marathon[which(marathon500$Name == input$Participant_Name), 7]
  #   country2<- marathon[which(marathon500$Name == input$Participant_Name2), 7]
  #   place1 <- marathon[which(marathon500$Name == input$Participant_Name), 19]
  #   place2 <- marathon[which(marathon500$Name == input$Participant_Name2), 19]
  #   gender1 <- marathon[which(marathon500$Name == input$Participant_Name), 20]
  #   gender2 <- marathon[which(marathon500$Name == input$Participant_Name2), 20]
  #  HTML(paste0("<h5>","Name: ", name1,'<br>', "Age: ",age1,'<br>',"Sex: ",sex1,'<br>',"City: ",city1,'<br>',"Country: ",country1,'<br>',"Place: ",place1,'<br>'," Place Gender: ",gender1,
  #              "<hr>","Name: ", name2,'<br>', "Age: ",age2,'<br>',"Sex: ",sex2,'<br>',"City: ",city2,'<br>',"Country: ",country2,'<br>',"Place: ",place2,'<br>'," Place Gender: ",gender2))
  # })
  
  output$selected_var1 <- renderText({
    age1<-marathon[which(marathon500$Name == input$Participant_Name), 3]
    name1 <-input$Participant_Name
    sex1 <- marathon[which(marathon500$Name == input$Participant_Name), 4]
    city1 <- marathon[which(marathon500$Name == input$Participant_Name), 5]
    country1 <- marathon[which(marathon500$Name == input$Participant_Name), 7]
    place1 <- marathon[which(marathon500$Name == input$Participant_Name), 19]
    gender1 <- marathon[which(marathon500$Name == input$Participant_Name), 20]
    HTML(paste0("<h5>","Name: ", name1,'<br>', "Age: ",age1,'<br>',"Sex: ",sex1,'<br>',"City: ",city1,'<br>',"Country: ",country1,'<br>',"Place: ",place1,'<br>'," Place Gender: ",gender1))
  })
    
  output$selected_var2 <- renderText({
    age2<-marathon[which(marathon500$Name == input$Participant_Name2), 3]
    name2 <-input$Participant_Name2
    sex2 <- marathon[which(marathon500$Name == input$Participant_Name2), 4]
    city2 <- marathon[which(marathon500$Name == input$Participant_Name2), 5]
    country2<- marathon[which(marathon500$Name == input$Participant_Name2), 7]
    place2 <- marathon[which(marathon500$Name == input$Participant_Name2), 19]
    gender2 <- marathon[which(marathon500$Name == input$Participant_Name2), 20]
    HTML(paste0("<h5>","Name: ", name2,'<br>', "Age: ",age2,'<br>',"Sex: ",sex2,'<br>',"City: ",city2,'<br>',"Country: ",country2,'<br>',"Place: ",place2,'<br>'," Place Gender: ",gender2))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
