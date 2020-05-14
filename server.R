source("shared.R")
server <- function(input, output, session) {

  #rvals = reactiveValues()

  redcapdb<-read.csv("data.csv", stringsAsFactors = FALSE) # data examples follow this structure: https://ispmbern.github.io/covid-19/living-review/datastructure.html
  redcapdb=head(redcapdb,25)
  
  observeEvent(input$add, {

	if(input$in_pass=="crowd"){

      output$out_text <- renderText({ "LOGIN SUCCESFULL" })
      shinyjs::disable("add") #disable login button
	  
      for(a in 1:nrow(redcapdb)) {     
    
      abstract = redcapdb$abstract[a]
      
      insertUI( # add ui elements (fluidrows)
      selector = "#add",
      where = "afterEnd",
      ui = fluidRow(id= paste0("rcid_",redcapdb$id[a]),
          column(7,
            h3(paste0(redcapdb$title[a], " [", redcapdb$id[a],"]")),
            tags$div(HTML(paste0("<a target=\"_blank\" href=\"http://dx.doi.org/",redcapdb$doi[a],"\" >DOI</a> | <a target=\"_blank\" href=\"",redcapdb$url[a],"\" >url</a>"))),
            h4(HTML(abstract))),
          column(5,                            
            selectInput(paste0('studydesign', redcapdb$id[a]), paste0(redcapdb$id[a], " Study design: \n"),
                        choices = studytypes, size = 14, width = '500px', selectize = F, selected=NULL)),
			actionButton(paste0('c', redcapdb$id[a]), paste0("Submit:",redcapdb$id[a])),br()                     
          
      ))
	  }
	 }else{
        output$out_text <- renderText({ "LOGIN FAILED" })
      }  

  })
  

  lapply( # add click handling elements (observeEvent) for all
    X = 1:nrow(redcapdb),
    FUN = function(a){ 
      observeEvent(input[[paste0("c", redcapdb$id[a])]], {
        
	# handle the input here:

	   studydesign = input[[paste0("studydesign", redcapdb$id[a])]]
        output$out_text <- renderText({ paste0("For record:",redcapdb$id[a], " you clicked:", studydesign) })
      
     # remove UI elements when clicked/finished:

        removeUI(paste0("#rcid_",redcapdb$id[a]))
        removeUI(paste0('#sel_', redcapdb$id[a]), immediate = T) 
      })
    }
  )

}
