


# A flowchart showing the differences in workflow leading to IBECA 
# indicators and Independene Viariables for predicting Ecosystem Services



library(DiagrammeR)
library(DiagrammeRsvg)
library(magrittr)
library(rsvg)






fig <- 
  grViz("digraph{
  
   
    graph [
            compound = true, 
            nodesep = .8, 
            ranksep = .8,
            color = crimson, 
            rankdir = TB,
            label= 'Figure of two work flows,\n
                    one to produce a scalabel IBECA indicator and \n 
                    one to produce a predictor variable for modelling ecosystem servises.\n
                    Both have the same starting point but seperate ways early on due to\n
                    different requirements and uses for the end products.',
            labelloc='t'
        ]

  
    node [
            fontname = Helvetica, 
            fontcolor = darkslategray,
            shape = rectangle, 
            color = darkslategray
        ]
        
        
    edge [
            color = black
        ]
        
        
    Dataset[shape = triangle]
    
    Dataset -> Variable
    
    N1[label= 'Describes an\necosystem characteristic?']
    
    Variable -> N1
    
    Scalable[label= 'Is scalable?']
    
    N1 -> Scalable[label='YES']
    
    N2[label = 'Appropriate resolution\nand extent?']
    
    {rank = same; Scalable -> N2[label='NO']}
    
    N1 -> N2[label=NO]
    
    Valid[label= 'Valid at\nrelevant scale?']
    
    Scalable -> Valid[label=YES]
    
    
    Scalable -> Discard[label=NO]
    
    Indicator[label= 'IBECA indicator']
    
    Valid -> Indicator[label=YES]
    
    {rank = same; Valid -> Discard[label=NO]}
    
    
    N3[label = 'Has explanatory\npower?']
    
    N2 -> N3[label=YES]
    
    Dis2[label=Discard]
    
    N2 -> Dis2[label=NO]
    
    N4[label = 'Independent variable\nfor modelling\nEcosystem services']
    
    N3 -> N4[label=YES]
    
    {rank=same; N3 -> Dis2[label= NO]}
   
   

}")

fig


#fig %>%
#  export_svg %>% charToRaw %>% rsvg_png("output/....png")
