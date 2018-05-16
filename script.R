# Cargar paquetes
library(ggplot2)
library(data.table)
library(igraph)
library(DT)

# Creación de la red (nodos = países, enlaces = conexiones entre países)
red.refugiados <- graph.formula(UK-FR, FR-NL, FR-GER, FR-SP, NL-GER,
                  GER-DEN,GER-IT, SP-MAROC, SP-IT, IT-TUN, IT-GR,
                  GR-EGY, TUN-EGY, GR-TUR, TUR-SYR)

# Ancho de todos los enlaces igual a 5 
E(red.refugiados)$width <- 5

# Visualiza los enlaces de la red
E(red.refugiados)
plot(red.refugiados)

# La closeness centrality nos da una idea de qué tan central es un nodo en la red
# La betweenness centrality
data.table(Node=c("UK", "FR", "NL", "GER", "SP", "DEN",
                  "IT", "MAROC", "TUN", "GR", "EGY",
                  "TUR", "SYR"),
           Closeness = round(closeness(red.refugiados), 3),
           Betweenness = betweenness(red.refugiados))

# Italia y Alemania tiene los valores más altos

# Veamos ahora qué sucede si incluimos un pequeño cambio en la red.
# Pensemos en que se "cierra" la frontera Grecia - Italia

red.refugiados.dos <- graph.formula(UK-FR, FR-NL, FR-GER, FR-SP, NL-GER,
                                GER-DEN,GER-IT, SP-MAROC, SP-IT, IT-TUN,
                                GR-EGY, TUN-EGY, GR-TUR, TUR-SYR)

plot(red.refugiados.dos)

data.table(Node=c("UK", "FR", "NL", "GER", "SP", "DEN",
                  "IT", "MAROC", "TUN", "GR", "EGY",
                  "TUR", "SYR"),
           Closeness = round(closeness(red.refugiados.dos), 3),
           Betweenness = betweenness(red.refugiados.dos))

tabla <- data.table(Node=c("UK", "FR", "NL", "GER", "SP", "DEN",
                           "IT", "MAROC", "TUN", "GR", "EGY",
                           "TUR", "SYR"),
                    Closeness = round(closeness(red.refugiados), 3),
                    Betweenness = betweenness(red.refugiados),
                    Closeness = round(closeness(red.refugiados.dos), 3),
                    Betweenness = betweenness(red.refugiados.dos))

datatable(tabla)
