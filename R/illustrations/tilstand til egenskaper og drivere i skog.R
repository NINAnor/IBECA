


egenskaper <- c(
  "Primærproduksjon",
  "Fordeling av biomasse mellom trofiske nivå",
  "Funksjonell sammensetning innen trofiske nivå",
  "Funksjonelt viktige arter og biofysiske strukturer",
  "Landskapsøkologiske mønstre",
  "Biologisk mangfold",
  "Abiotiske forhold"
  )

verdier <- c(0.7,
             0.38,
             0,
             0.34,
             0.21,
             0.41,
             0.64
             )

dat <- data.frame(
  egenskaper,
  verdier
  
)
png("figures/økologisk tilstand  per egenskap i skog.png", width = 800, height = 800, units = "px")
par(mar=c(5,40,1,2))
barplot(dat$verdier,
        names.arg  = dat$egenskaper,
        las=1,
        cex.axis=2,
        cex.names=2,
        
        horiz = T,
        col="skyblue",
        xlim = c(0,1))
abline(v=0.6, lty=2, lwd=2)
dev.off()



#************************************
  
  
  var <- c(
    "Arealbruk/inngrep",
    "Klimaendringer",
    "Forurensinger",
    "Beskatning",
    "Fremmede arter"
  )

verdier2 <- c(0.39,
             0.67,
             0.62,
             0.38,
             1
)
dat2 <- data.frame(
  var,
  verdier2
  
)
png("figures/økologisk tilstand  per påvirkningsfaktor i skog.png", width = 800, height = 800, units = "px")
par(mar=c(5,40,1,2))
barplot(dat2$verdier2,
        names.arg  = dat2$var,
        las=1,
        cex.axis=2,
        cex.names=2,
        
        horiz = T,
        col="skyblue",
        xlim = c(0,1))
abline(v=0.6, lty=2, lwd=2)
dev.off()

