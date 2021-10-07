library(DiagrammeR)

#https://stackoverflow.com/questions/3550341/gantt-charts-with-r/29999300#29999300
#https://mermaid-js.github.io/mermaid/#/gantt


mermaid("
gantt
dateFormat  MM-YY


section Data harvesting

Deciding search terms              :active,             03-22, 04-22
Finding litterature                :active,             04-22, 05-22
Automatic screening                :active,             05-22, 06-22
Critical appraisal                 :active,             06-22, 08-22

section Data curation

Setting up database                :active,             06-22, 09-22
API                                :active,             08-22, 09-22


section Data analyses

Data extraction                    :active,             07-22, 10-22
Cluster analysis                   :active,             09-22, 11-22
Shiny app                          :crit,               07-22, 12-22


section Norde Follo Pilot

Identyfing stakeholder needs       :active,             01-22, 06-22
Indicator development              :active,             02-22, 09-22
Test identified indicators         :active,             08-22, 12-22
ECA                                :crit,               09-22, 02-23

section Reporting

Peer review paper                  :crit,               01-23, 05-23
Kronikk                            :crit,               04-23, 05-23


        ")


