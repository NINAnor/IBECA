library(readxl)
library(DiagrammeR)
library(dplyr)



# IMPORT ------------------------------------------------------------------


ind <- read_excel("data/indData.xlsx", 
                  sheet = "tilstandsindikatorer")

paa <- read_excel("data/indData.xlsx", 
                  sheet = "paavirkninger")

ege <- read_excel("data/indData.xlsx", 
                  sheet = "egenskaper")

dat <- read_excel("data/indData.xlsx", 
                  sheet = "datasett")

edges <- read_excel("data/indData.xlsx", 
                    sheet = "relasjoner")


# combine nodes
nodes <- data.frame(nodes = c(ind$node,
                              paa$node,
                              ege$node,
                              dat$datasettnavn),
                    tooltip = c(ind$tooltip,
                                paa$tooltip,
                                ege$tooltip,
                                dat$dataeier),
                    type = rep(c("ind", "paa", "ege", "dat"), 
                               times=c(nrow(ind),
                                       nrow(paa),
                                       nrow(ege),
                                       nrow(dat))),
                    group = c(ind$kategori,
                              rep(c("NA", "NA", "NA"), 
                                  times=c(
                                    nrow(paa),
                                    nrow(ege),
                                    nrow(dat)))))  # har kan vi også legge til en kolonne for tooltips etc



# Spacing --------------------------------------------------------------

# Creating fake nodes and edges to ensure correct spacing between columns
# (hackish)
fakeEdge <- data.frame(ID = "",
                       from = c("Fremmede arter", "spacenode", 
                                "Bestandsnivå villrein", "spacenode2"),
                       to = c("spacenode","Bestandsnivå villrein", 
                              "spacenode2", "Funksjonelt viktige arter og strukturer"),
                       tooltip = "",
                       beskrivelse = "",
                       kategori = "space-cat",
                       referanser = "")

edges <- rbind(edges, fakeEdge)

theTo <- c("spacenode","Bestandsnivå villrein", 
           "spacenode2", "Funksjonelt viktige arter og strukturer")
theFrom <- c("Fremmede arter", "spacenode", 
             "Bestandsnivå villrein", "spacenode2")

space <- data.frame(nodes = c("spacenode", "spacenode2"),
                    tooltip= c("", ""),
                    type = c("space", "space2"),
                    group = c("NA", "NA"))
nodes <- rbind(nodes, space)








# subset -----------------------------------------------------------------
# Removing the dataset stuff from this figure

nodes2 <- nodes[nodes$type!="dat",]
edges2 <- edges[edges$kategori!="dat-ind",]
# reset rownames so that the ID's (below) corresponds to the node_df
row.names(nodes2) <- seq(1:nrow(nodes2))


# IDs -----------------------------------------------------------------

indID <- row.names(nodes2)[nodes2$type=="ind"]
paaID <- row.names(nodes2)[nodes2$type=="paa"]
egeID <- row.names(nodes2)[nodes2$type=="ege"]
datID <- row.names(nodes2)[nodes2$type=="dat"]
supID <- row.names(nodes2)[nodes2$group=="supplerende"]
supID <- row.names(nodes2)[nodes2$group=="supplerende"]
mainID <- row.names(nodes2)[nodes2$group=="tilstandsindikator"]
spaceID <- row.names(nodes2)[nodes2$type=="space"]
space2ID <- row.names(nodes2)[nodes2$type=="space2"]
fromID <- row.names(nodes2)[nodes2$nodes %in% theFrom]
toID <- row.names(nodes2)[nodes2$nodes %in% theTo]


#table(edges2$from %in% nodes2$nodes)
#table(edges2$to %in% nodes2$nodes)
# all edges to's and from's are identical to node names




# the dag craches if there's a column called tooltip
edges2 <- rename(edges2, tooltip_edge = tooltip)


# linebreaks for egenskaper
lineBreaks <-  nodes2
nodes2$br <- nodes2$nodes
nodes2$br[nodes2$type=="ege"] <- c(
                  "Primærproduksjon",
                 "Biomasse mellom\ntrofiske nivåer",
                 "Funksjonell\nsammensetning\ninnen trofiske\nnivåer",
                 "Funksjonelt\nviktige arter\nog strukturer",
                 "Landskaps-\nøkologiske\nmønstre",
                 "Biologisk\nmangfold",
                 "Abiotiske\nforhold")


# Add URLs ---------------------------------------

#default URL:
nodes2$URL <- "https://ninanor.github.io/IBECA/faktaark"

# Custum URLs
nodes2$URL[nodes2$nodes== "Bestandsnivå fjellrev"] <- "https://ninanor.github.io/IBECA/faktaark#bestandsnivå-fjellrev"
nodes2$URL[nodes2$nodes== "Bestandsnivå jerv"] <- "https://ninanor.github.io/IBECA/faktaark#bestandsnivå-jerv"
nodes2$URL[nodes2$nodes== "Kongeørn"] <- "https://ninanor.github.io/IBECA/faktaark#kongeoern"

# Påvirkninger
nodes2$URL[nodes2$nodes== "Beskatning"] <- 
  "https://ninanor.github.io/IBECA/beskatning-fjell.html"
nodes2$URL[nodes2$nodes== "Arealbruk/-inngrep"] <- 
  "https://ninanor.github.io/IBECA/arealbruk-fjell.html"
nodes2$URL[nodes2$nodes== "Forurensing"] <- 
  "https://ninanor.github.io/IBECA/forurensing-fjell.html"
nodes2$URL[nodes2$nodes== "Klima"] <- 
  "https://ninanor.github.io/IBECA/klima-fjell.html"
nodes2$URL[nodes2$nodes== "Fremmede arter"] <- 
  "https://ninanor.github.io/IBECA/fremmede-arter-fjell.html"

# DAG ---------------------------------------------------------------------


dag <- create_graph( 
  attr_theme = "lr"
) %>%   
  
  add_nodes_from_table(
    table = nodes2,
    type_col = type,
    label_col = nodes
  ) %>%
  
  # global styling of nodes
  set_node_attrs(node_attr = shape, values =  "box") %>%
  set_node_attrs(node_attr = shape, values =  "triangle", nodes = paaID) %>%

  set_node_attrs(node_attr = URL, values =  nodes2$URL) %>%
  
  set_node_attrs(node_attr = rank, values =  1, nodes = paaID) %>%
  set_node_attrs(node_attr = rank, values =  3, nodes = indID) %>%
  set_node_attrs(node_attr = rank, values =  5, nodes = egeID) %>%
  set_node_attrs(node_attr = rank, values =  2, nodes = spaceID) %>%
  set_node_attrs(node_attr = rank, values =  4, nodes = space2ID) %>%
  
  set_node_attrs(node_attr = fontcolor, values =  "black", nodes = paaID) %>%
  set_node_attrs(node_attr = fontcolor, values =  "black", nodes = indID) %>%
  set_node_attrs(node_attr = fontcolor, values =  "white", nodes = egeID) %>%
  
  set_node_attrs(node_attr = tooltip, values =  nodes2$tooltip) %>%
  
  set_node_attrs(node_attr = width, values =  1.5, nodes = egeID) %>%  # width of egenskaper
  set_node_attrs(node_attr = width, values =  1.8, nodes = indID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = spaceID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = space2ID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = paaID) %>% 
  set_node_attrs(node_attr = height, values =  1.5, nodes = paaID) %>% 
  set_node_attrs(node_attr = height, values =  1.2, nodes = egeID) %>% 
  
  
  set_node_attrs(node_attr = penwidth, value = 4) %>%
  
  set_node_attrs(node_attr = style, values =  'invisible', nodes = spaceID) %>%
  set_node_attrs(node_attr = style, values =  'invisible', nodes = space2ID) %>%
  
  
  
  
  # edges
  add_edges_from_table(
    table = edges2,
    rel_col = kategori,
    from_col = from,
    to_col = to,
    from_to_map = label    
  )  %>%
  
  
  # edge colour
  set_edge_attrs(edge_attr = color, values = "black") %>%
  set_edge_attrs(edge_attr = penwidth, values = 3) %>%
  set_edge_attrs(edge_attr = headport, values = "w") %>%
  set_edge_attrs(edge_attr = style, values =  'invisible',
                 from=fromID,
                 to =toID) %>%
  set_edge_attrs(edge_attr = arrowsize, values =  0,
                 from=fromID,
                 to =toID) %>%
  
  
  
  # colouring the nodes
  select_nodes(conditions = type == "ind") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "DarkKhaki") %>%
  clear_selection()%>%
  
  select_nodes(conditions = type == "paa") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "Goldenrod") %>%
  clear_selection() %>%
  
  select_nodes(conditions = type == "ege") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "grey40") %>%
  clear_selection()%>%
  
  set_node_attrs(node_attr = fillcolor, values =  "white", nodes = supID)%>%
  
  set_node_attrs(node_attr = label, values = nodes2$br)
