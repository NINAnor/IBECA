library(readxl)
library(DiagrammeR)
library(dplyr)
# Import nodes ------------------------------------------------------------


ind <- read_excel("data/indData.xlsx", 
                  sheet = "tilstandsindikatorer")

paa <- read_excel("data/indData.xlsx", 
                  sheet = "paavirkninger")

ege <- read_excel("data/indData.xlsx", 
                  sheet = "egenskaper")

dat <- read_excel("data/indData.xlsx", 
                  sheet = "datasett")



# Import edges ------------------------------------------------------------

edges <- read_excel("data/indData.xlsx", 
                    sheet = "relasjoner")

#names(edges)
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
                                       nrow(dat))))  # har kan vi også legge til en kolonne for tooltips etc




# add space-nodes ---------------------------------------------------------

#colnames(nodes)
space <- data.frame(nodes = c("spacenode", "spacenode2"),
                    tooltip= c("", ""),
                    type = c("space", "space2"))
nodes <- rbind(nodes, space)








# subsett -----------------------------------------------------------------


nodes2 <- nodes[nodes$type!="dat",]
edges2 <- edges[edges$kategori!="dat-ind",]

row.names(nodes2) <- seq(1:nrow(nodes2))


indID <- row.names(nodes2)[nodes2$type=="ind"]
paaID <- row.names(nodes2)[nodes2$type=="paa"]
egeID <- row.names(nodes2)[nodes2$type=="ege"]
datID <- row.names(nodes2)[nodes2$type=="dat"]
spaceID <- row.names(nodes2)[nodes2$type=="space"]
space2ID <- row.names(nodes2)[nodes2$type=="space2"]

table(edges2$from %in% nodes2$nodes)
table(edges2$to %in% nodes2$nodes)
# all edges to's and from's are identical to node names

# the dag craches if there's a column called tooltip
edges2 <- rename(edges2, tooltip_edge = tooltip)

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
  
  set_node_attrs(node_attr = URL, values =  "https://www.nrk.no") %>%
  
  set_node_attrs(node_attr = rank, values =  1, nodes = paaID) %>%
  set_node_attrs(node_attr = rank, values =  3, nodes = indID) %>%
  set_node_attrs(node_attr = rank, values =  5, nodes = egeID) %>%
  set_node_attrs(node_attr = rank, values =  2, nodes = spaceID) %>%
  set_node_attrs(node_attr = rank, values =  4, nodes = space2ID) %>%
  
  set_node_attrs(node_attr = fontcolor, values =  "black", nodes = paaID) %>%
  set_node_attrs(node_attr = fontcolor, values =  "white", nodes = indID) %>%
  set_node_attrs(node_attr = fontcolor, values =  "white", nodes = egeID) %>%
  
  set_node_attrs(node_attr = tooltip, values =  nodes2$tooltip) %>%
  
  set_node_attrs(node_attr = width, values =  3.1, nodes = egeID) %>%  # width of egenskaper
  set_node_attrs(node_attr = width, values =  1.5, nodes = indID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = spaceID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = space2ID) %>% 
  set_node_attrs(node_attr = width, values =  1.5, nodes = paaID) %>% 
  set_node_attrs(node_attr = height, values =  1.5, nodes = paaID) %>% 
  
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
  
 # select_edges(conditions = rel == "A") %>%
 # rev_edge_dir_ws() %>%
 # clear_selection() %>%
  
  
  # edge colour
  set_edge_attrs(edge_attr = color, values = "black") %>%
  set_edge_attrs(edge_attr = penwidth, values = 3) %>%
  set_edge_attrs(edge_attr = headport, values = "w") %>%
  
  
  # colouring the nodes
  select_nodes(conditions = type == "ind") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "DarkOliveGreen") %>%
  clear_selection()%>%
  
  select_nodes(conditions = type == "paa") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "Goldenrod") %>%
  clear_selection() %>%
  
  select_nodes(conditions = type == "ege") %>%
  set_node_attrs_ws(node_attr = fillcolor, value = "grey40") %>%
  clear_selection()
  

render_graph(dag)

get_node_df(dag) 
get_edge_df(dag)
# # break names
 # select_nodes(conditions = label == "Areal uten fremmede plantearter") %>%
 # set_node_attrs_ws(node_attr = label, value = "Areal uten\nfremmede plantearter") %>%
 # clear_selection() %>%
 # 
 # select_nodes(conditions = label == "Areal uten tekniske inngrep") %>%
 # set_node_attrs_ws(node_attr = label, value = "Areal uten\ntekniske inngrep") %>%
 # clear_selection()

