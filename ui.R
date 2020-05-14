# version 14.05.2020 15:30


ui <- fluidPage(
  tags$head(tags$style(HTML(" body { margin:0.4%; "))),
  titlePanel(HTML("Screening example"), windowTitle="Screening example"),
  fluidRow(shinyjs::useShinyjs(),column(4,
    
    #textInput('in_name', 'Your username:'),
    passwordInput('in_pass', 'Your password:'),
    verbatimTextOutput('out_text', placeholder=TRUE),
    
    br()),column(8, h2("Welcome to the Screening example page"),br(),
HTML("<b>INSTRUCTIONS:</b> Quick demo of the screening app. Login using the password 'crowd'. The verbatim output will show you the return status of interactions."))
    
  ), fluidRow(actionButton("add", "Let's Go!"))
)