


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
            rankdir = LR
        ]

  
    node [
            fontname = Helvetica, 
            fontcolor = darkslategray,
            shape = rectangle, 
            fixedsize = true, 
            width = 1,
            color = darkslategray
        ]
        
        
    edge [
            color = black
        ]
        
        
   subgraph clusterTop {
      graph[color = black]
      
    subgraph cluster0 {
      peripheries=0;
       
       subgraph cluster0_1 {
        label='sub-region 1';
        labeljust=l;
        Area1[label = 'Value = 5\nRef. = 10']
       }
       
       subgraph cluster0_2 {
        label='sub-region 2';
        labeljust=l;
        Area2[label = 'Value = 1\nRef. = 4']
       }
    }
    
    subgraph clusterScaledUpper {
      graph[style=dashed]
      style=filled; color=grey90;
      
    subgraph cluster1 {
      peripheries=0;
        
        subgraph cluster1_1 {
          label='sub-region 1';
          labeljust=l;
          Area1_2[label = '.5']
        }
        
        subgraph cluster1_2 {
          label='sub-region 2';
          labeljust=l;
          Area2_2[label = '.25']
        }
    }   
    
    
    subgraph cluster2 {
      peripheries=0;
      label = region;
      labeljust=l;
      Norge[label = '.375']
    }
    }
    
    Area1 -> Area1_2 -> Norge
    Area2 -> Area2_2 -> Norge
  
   }  
   
   
   
   
   subgraph clusterBottom {
    graph[color = black];

    
    subgraph cluster0b {
       peripheries=0;
       
       
       subgraph cluster0_1b {
        label='sub-region 1';
        labeljust=l;
        Area1b[label = 'Value = 5\nRef = 10']
       }
       
       subgraph cluster0_2b {
        label='sub-region 2';
        labeljust=l;
        Area2b[label = 'Value = 1\nRef = 4']
       }
    }
      
      subgraph cluster1b {
        peripheries=0;
        label = region;
        labeljust=l;
        NorwayValues[label = 'Value = 6\nRef. = 14']
        }

    
    
    subgraph cluster2b {
      graph[style=dashed]
      style=filled; color=grey90;
      
      subgraph clusterScaledB {
      
      peripheries=0;
      label = region;
      labeljust=l;
      Norgeb[label = '.43']
      
      }
    }   
    
    Area1b -> NorwayValues -> Norgeb
    Area2b -> NorwayValues
  
   }
   
   

}")

fig


fig %>%
  export_svg %>% charToRaw %>% rsvg_png("output/NivåetForSkalering.png")


