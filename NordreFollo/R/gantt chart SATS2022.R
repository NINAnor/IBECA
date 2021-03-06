library(DiagrammeR)

#https://stackoverflow.com/questions/3550341/gantt-charts-with-r/29999300#29999300
#https://mermaid-js.github.io/mermaid/#/gantt



gantt <- mermaid("
gantt
dateFormat  MM-YYYY


section Data harvesting

Deciding search terms              :active,             03-2022, 04-2022
Finding litterature                :active,             04-2022, 05-2022
Automatic screening                :active,             05-2022, 06-2022
Critical appraisal                 :active,             06-2022, 08-2022

section Data curation

Creating data plan                 :active,             03-2022, 04-2022
Setting up database                :active,             04-2022, 06-2022

section Data analyses

Data extraction                    :active,             07-2022, 10-2022
Multivariate analysis              :active,             09-2022, 11-2022
Shiny app                          :crit,               07-2022, 12-2022


section Norde Follo Pilot

Identyfing stakeholder needs       :done,               01-2022, 06-2022
Indicator development              :done,               02-2022, 02-2023
Test identified indicators         :active,             10-2022, 02-2023
ECA                                :crit,done,           01-2023, 12-2023

section Reporting

Peer review paper                  :crit,               05-2023, 01-2024
Kronikk                            :crit,               01-2024, 02-2024


        ")
gantt
