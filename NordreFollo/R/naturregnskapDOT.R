library(DiagrammeR)

# A flowchart showin the different steps in creating a SEEA EA condition account
# where the focus is to keep the information, which starts off as varibles, as maps for as long as possible

# help: https://forum.graphviz.org/

flyt <- 
  grViz("digraph{

  graph [compound = true, nodesep = .15, ranksep = .8,
         color = crimson, rankdir = TB]

  
  node [fontname = Helvetica, 
        fontcolor = darkslategray,
        shape = rectangle, 
        fixedsize = true, 
        width = 2,
        color = darkslategray]
        
  
   subgraph clusterLeftColumn {
   peripheries=0;
   
      label = 'ECT1: Physical state';
      node [fixedsize = true, width = 2];
      CharA[label = 'Characteristic A']
      CharB[label = 'Characteristic B']
      
      
      
      {rank = same; CharA; CharB}
  }
  
  
    subgraph clusterRightColumn {
   
      label = 'ECT2: Chemical  state';
      node [fixedsize = true, width = 2];
      CharC[label = 'Characteristic A']
      
    }
  
  Forslag[label = 'Forslag på indikator og\nreferanseverdier']
  Ekspert[label='Indikatorekspert(er)']
  Sjekkliste[label = 'Utfylling\nav sjekkliste']
  Rapport[label='Ferdig rapport']
  Ekspert1[label=Ekspertpanel]
  Ekspert2[label=Ekspertpanel]
  Metadata[label = 'Dokumentasjon\n(metadata)']

  
  edge [color = black]
  
  Datasett -> Forslag [ltail = cluster0, headport = n, tailport = e]
       
       
       {rank = same; Ekspert -> Forslag [minlen=2]}
       
       {rank = same; Forslag -> 'Indikator\nforkastes' 
                          [label = 'Umulig', 
                           fontcolor=red, 
                           fontsize=20]}
       
       Forslag -> Sjekkliste [label = ' Mulig', fontcolor=darkgreen, fontsize=20]
       
       {rank = same; Ekspert1 -> Sjekkliste [minlen=2]}
       
       {rank = same;  Sjekkliste -> Ekskludert 
                        [label = 'Indikator\nuegnet',
                         fontcolor=red, 
                         fontsize=20
                         ]}
       
       Sjekkliste -> Indikatorsett [label = ' OK', fontcolor=darkgreen, fontsize=20]
       
subgraph cluster {
       label = Analyse;
       node [fixedsize = true, width = 2];
      
      edge[dir = both]
      {rank = same; Utregninger -> Metadata}
  }
       
       Indikatorsett -> Utregninger[lhead = cluster]
       Utregninger -> Rapportutkast
       Rapportutkast -> Rapport
       Ekspert2 -> Rapportutkast
       'Ekstern vurdering' -> Rapportutkast
       Metadata -> 'GitHub-pages'
}")

flyt
#flyt
#DiagrammeR::export_graph(graph = flyt, 
#                         file_type = 'PNG', 
#                         file_name = '../output/flytskjema.png')
#


