library(DiagrammeR)



grViz("digraph{

     graph [compound = true, nodesep = .5, ranksep = .5,
         color = crimson, rankdir = TB]

  node [fontname = Helvetica, fontcolor = darkslategray,
        shape = rectangle, fixedsize = true, width = 2,
        color = darkslategray]
        
  Forslag[label = 'Forslag på indikator og\nreferanseverdier']
  Datasett[label = 'Mulige datasett']
  Indikatorer[label = 'Mulige indikatorer']
  Ekspert[label='Indikatorekspert(er)']
  Umulig[label = 'Umulig' shape=plaintext, fontcolor=red, fontsize=20]
  Sjekkliste[label = 'Utfylling\nav sjekkliste']
  Ekskludert[shape = plaintext, fontcolor=red, fontsize=20]
  Mulig[shape = plaintext, fontcolor=darkgreen, fontsize=20]
  OK[shape = plaintext, fontcolor=darkgreen, fontsize=20]
  Rapport[label='Ferdig rapport']
  Ekspert1[label=Ekspertpanel]
  Ekspert2[label=Ekspertpanel]
  Metadata[label = 'Dokumentasjon\n(metadata)']

  
  edge [color = black]
  
  subgraph cluster0 {
       label = Scoping;
       node [fixedsize = true, width = 2];
      Datasett
      Indikatorer
      
      edge[dir = both]
      Datasett -> Indikatorer
  }
  
  
  subgraph cluster {
       label = Analyse;
       node [fixedsize = true, width = 2];
      Utregninger
      Metadata
      
      edge[dir = both]
      Utregninger -> Metadata
  }
       
       Datasett -> Forslag [ltail = cluster0, headport = w, tailport = e]
       Ekspert -> Forslag
       Forslag -> Umulig
       Forslag -> Mulig
       Mulig -> Sjekkliste
       Ekspert1 -> Sjekkliste
       Sjekkliste -> Ekskludert
       Sjekkliste -> OK
       OK -> Utregninger[lhead = cluster, tailclip=false]
       Utregninger -> Rapportutkast
       Rapportutkast -> Rapport
       Ekspert2 -> Rapportutkast
       Metadata -> 'GitHub-pages'
}")










