library(DiagrammeR)


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
        
  
   subgraph cluster0 {
   
       label = Scoping;
       node [fixedsize = true, width = 2];
      Datasett[label = 'Mulige\ndatasett']
      Indikatorer[label = 'Mulige\nindikatorer']
      
      edge[dir = both]
      {rank = same; Datasett -> Indikatorer}
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


DiagrammeR::export_graph(graph = flyt, 
                         file_type = 'PNG', 
                         file_name = '../output/flytskjema.png')



