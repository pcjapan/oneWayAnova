##
## UI
##

ui <- fluidPage(
  ## Styling
  tags$head(tags$link(
    rel = "stylesheet", type = "text/css", href = "app.css"
  )),
  ## End Styling
  
  titlePanel("Oneway ANOVA"),
  
  
  sidebarLayout(
    sidebarPanel(
      fluidRow(column(
        4,
        p(strong("Grouping Variable:")),
        tags$textarea(
          id = "grp",
          rows = 20,
          cols = 10,
          "grp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp1\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp2\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3\ngrp3"
        )
      ),
      column(
        4,
        p(strong("Response:")),
        tags$textarea(
          id = "scr",
          rows = 20,
          cols = 10,
          "12.4\n11.4\n12.7\n7.7\n11.7\n13.7\n12.2\n12.0\n9.2\n12.1\n12.3\n11.5\n14.3\n13.7\n11.9\n14.4\n12.8\n14.2\n14.9\n10.1\n12.5\n14.0\n11.5\n13.1\n11.6\n11.4\n16.5\n13.9\n11.9\n14.4\n19.2\n16.9\n14.4\n17.2\n17.9\n18.6\n17.2\n18.6\n17.9\n18.7\n20.6\n17.9\n20.3\n15.6\n19.2\n15.1\n18.1\n22.7\n19.8\n16.9\n19.5\n16.9\n15.9\n19.0\n18.2\n17.4\n17.9\n16.4\n17.5\n14.8\n11.1\n10.3\n8.2\n7.8\n9.4\n11.1\n10.8\n9.9\n11.4\n12.8\n10.9\n11.5\n8.5\n8.2\n9.7\n12.4\n11.4\n10.6\n8.1\n8.5\n10.4\n10.5\n10.4\n9.8\n10.5\n9.1\n10.9\n8.4\n8.7\n8.6"
        )
      ),),
      fluidRow(column(
        6,
        "Post-hoc Method",
        pickerInput(
          inputId = "postHocMethod",
          choices = c(
            "Holm" = "holm",
            "Hochberg" = "hochberg",
            "Hommel" = "hommel",
            "Bonferroni" = "bonferroni",
            "Benjamini & Hochberg (FDR)" = "BH",
            "Benjamini & Yekutieli" = "BY",
            "None" = "none"
          ),
          options = list(style = "btn-primary"),
        )
      ),),
      fluidRow(
        column(
          6,
          "Trimmed Mean",
          numericInput(
            "trm",
            label = "Select the trimmed mean %",
            value = .2,
            min = 0,
            max = .2,
            step = .05
          ),
          "Bootstrap Samples",
          sliderInput(
            "btsn",
            label = "Set the number of bootstrap samples",
            value = 600,
            step = 50,
            min = 200,
            max = 1000
          ),
        ),
      ),
      fluidRow(column(
        6,
        h3("Show the following tests"),
        awesomeCheckbox("welch",
                        "Welch's Test",
                        status = "info"),
        awesomeCheckbox("nonPar",
                        "Nonparametric Tests",
                        status = "info")
      )),
      fluidRow(column(
        6,
        h3("Show the following graphs"),
        p("These will be displayed under the", em("Exploring Data"), "tab.", class = "text-primary"),
        awesomeCheckbox("vp",
                        "Violin Plot",
                        status = "info"),
        awesomeCheckbox("dp",
                        "Dotplot",
                        status = "info")
      ))
    ),
    mainPanel(tabsetPanel(
      tabPanel(
        "Results",
        tags$h3("Descriptive Statistics"),
        verbatimTextOutput("descStats1"),
        tags$h3("Checking Assumptions"),
        verbatimTextOutput("shapTest"),
        verbatimTextOutput("shapTestG"),
        verbatimTextOutput("leveneT"),
        tags$h3("Robust ANOVA"),
        htmlOutput("robustANOVAinfo", class = "text-primary"),
        verbatimTextOutput("robustANOVA"),
        htmlOutput("robustPosthocinfo", class = "text-primary"),
        verbatimTextOutput("robustPostHoc"),
        tags$h3("Standard ANOVA"),
        verbatimTextOutput("res.aov"),
        tags$h3("Post-hoc Test Result"),
        htmlOutput("pairwise.t.adjustment", class = "text-primary"),
        verbatimTextOutput("pwtt"),
        tags$h3("Alternatives"),
        verbatimTextOutput("tukeyHSD"),
        verbatimTextOutput("scheffe"),
        conditionalPanel(
          condition = "input.welch == 1",
          tags$h3("Welch's Tests"),
          tags$p(
            "If Levene\'s test fails, then an alternative to the standard ANOVA test is recommended.", br(),
            "While reporting the results of the robust test is recommended, Welch's test is one possibility"
          ),
          verbatimTextOutput("WelchT"),
        ),
        conditionalPanel(
          condition = "input.nonPar == 1",
          tags$h3("Non-parametric Tests"),
          verbatimTextOutput("nonPar"),
          tags$p("Games-Howell Post-hoc Test"),
          verbatimTextOutput("ghT"),
        ),
      ),
      
      tabPanel(
        "Exploring data",
        fluidRow(
          h3("Check Assumptions"),
          p("The following graphs show how your data is distributed. Check to see if there are any possible problems.", class = "text-primary"),
          plotOutput("ggP"),
          plotOutput("homV"),
          plotOutput("gNorm"),
        ),
        conditionalPanel(
          condition = "input.vp == 1",
          fluidRow( 
            h3("Violin Plot"),
            plotOutput("vp"),
            ),
          ),
        conditionalPanel(
          condition = "input.dp == 1",
          fluidRow(
            h3("Dotplot"),
            plotOutput("dp"),
            ),
          ),
      ),
      tabPanel(
        "Effect Size Calculation",
        tags$h3("Descriptive Statistics"),
        fluidRow(column
                 (
                   8,
                   verbatimTextOutput("descStats2"),
                   tags$p(
                     "To calculate the effect size for the difference between your groups, enter the mean (M), standard deviation (SD), and sample size (SD) for each group in the input boxes below. Clicking the", code("Calculate"), " button will generate the effect size data."
                   )
                 )),
        fluidRow(column
                 (
                   8,
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "m1",
                         label = "M 1",
                         width = "12ch"
                       )),
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "sd1",
                         label = "SD 1",
                         width = "12ch"
                       )),
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "n1",
                         label = "N 1",
                         width = "12ch"
                       )),
                 ),),
        fluidRow(column
                 (
                   8,
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "m2",
                         label = "M 2",
                         width = "12ch"
                       )),
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "sd2",
                         label = "SD 2",
                         width = "12ch"
                       )),
                   div(style = "display:inline-block",
                       textInput(
                         inputId = "n2",
                         label = "N2",
                         width = "12ch"
                       ), ),
                 ),
                 fluidRow(
                   column(
                     8,
                     actionBttn(
                       inputId = "submit_data",
                       label = "Calculate",
                       lib = "glyphicon",
                       icon = icon("circle-play"),
                       style = "float",
                       color = "primary",
                       size = "sm",
                       
                     ),
                     tags$hr(),
                     verbatimTextOutput("ES"),
                   ),
                 ),),
      ),
      tabPanel("Instructions",
               includeHTML("include.html")),
    )
    ),
  ),
)
