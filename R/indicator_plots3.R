# Indicator plots

# Plot time series of raw indicators without errorbars





indicator_plot3 <- function(
  dataset = NULL,
  yAxisTitle = "DEFULT Y AXIS TEXT",
  lowYlimit = -100,
  upperYlimit = 100,
  yStep = 20,
  minyear = 1958,
  maxyear = 2021,
  colours = c("#FFB25B", "#2DCCD3", "#004F71", "#7A9A01", "#93328E", "dark grey"),
  legendPosition = "top",
  legendInset = 0,
  horizontal = TRUE,
  legendTextSize = 1.25,
  move = 0.1 # Move parameter (to avoid overlapping)
  
){
  
  dat <- dataset
  
  # test data
  #  yAxisTitle = "DEFULT Y AXIS TEXT"
  #  lowYlimit = 0
  #  upperYlimit = 1
  #  yStep = .2
  # minyear = 1980
  #  maxyear = 2021
  #  colours = c("#FFB25B", "#2DCCD3", "#004F71", "#7A9A01", "#93328E", "dark grey")
  #  legendPosition = "top"
  #  legendInset = 0
  #  horizontal = TRUE
  #  legendTextSize = 1.25
  #  move = 0 # Move parameter (to avoid overlapping)
  
  
  
  
  # The dataset should have a column names 'reg' with the regions as a single letter. The whole of Norway is coded as 'Norge'.
  dat$reg <- as.character(dat$reg)
  dat$reg[dat$reg=="C"] <- "Midt-Norge"
  dat$reg[dat$reg=="N"] <- "Nord-Norge"
  dat$reg[dat$reg=="E"] <- "Østlandet"
  dat$reg[dat$reg=="S"] <- "Sørlandet"
  dat$reg[dat$reg=="W"] <- "Vestlandet"  
  
  dat$year <- as.numeric(dat$year)
  # Order data
  regOrder = c("Østlandet","Sørlandet","Vestlandet","Midt-Norge","Nord-Norge","Norge")
  dat <- dat[order(match(dat$reg,regOrder),dat$year),]
  
  
  # Create loop factors
  uniq1 <- unique(unlist(dat$year))
  uniq2 <- unique(unlist(dat$reg))
  
  
  ### PLOT first Norway
  
  # Subset for region 'Norge'
  Norge <- subset(dat, reg=="Norge")
  
  
  
  
  
  # Plot for region = 'Norge'
  plot(
    Norge$med~Norge$year, 
    ylab=yAxisTitle,
    xlab="",
    main="",
    xlim=c(minyear, maxyear),
    ylim=c(lowYlimit, upperYlimit),
    cex.main=1,
    cex.lab=1.5,
    cex.axis=1.5,
    type="n", 
    frame.plot=FALSE,
    axes=FALSE
  )
  
  # Axis 1 options
  axis(side=1, at=c(minyear, Norge$year, maxyear), labels=c("",Norge$year, ""), cex.axis=1.5) 
  
  
  # Axis 2 options
  axis(side=2, at=seq(lowYlimit, upperYlimit, yStep), 
       labels=seq(lowYlimit, upperYlimit, yStep), 
       cex.axis=1.5)
  
  
  # Add lines
  lines(Norge$year+(move*(-2.5)), Norge$med, col=colours[6], lwd=2, lty=3) 
  
  # Save temp points for later addition to plot
  temppoints <- data.frame(year = Norge$year, med = Norge$med)
  
  
  
  
  
  
  
  # Add quantiles to plot
  
  for(i in 1:nrow(Norge)){
    arrows(Norge$year[i]+(move*(-2.5)),Norge$med[i],Norge$year[i]+(move*(-2.5)),Norge$upp[i], angle=90, length=0.05, col=colours[6], lwd=1)
    arrows(Norge$year[i]+(move*(-2.5)),Norge$med[i],Norge$year[i]+(move*(-2.5)),Norge$low[i], angle=90, length=0.05, col=colours[6], lwd=1)
    
  }   
  
  # Empty temporary points data frame
  temppoints3 <- data.frame()
  
  
  
  ### Then plot loop per region
  for(n in 1:(length(uniq2)-1)){
    
    # Subset for region i
    quants <- subset(dat, reg==uniq2[n])
    
    # Add lines
    lines(quants$year+move*(n-2.5), quants$med, col=colours[n], lwd=2, lty=3) 
    
    # Save temp points for later addition to plot
    temppoints2 <- data.frame(year = quants$year, med = quants$med, reg = uniq2[n])
    temppoints3 <- rbind(temppoints3, temppoints2)
    
    # Add quantiles to plot
    for(i in 1:nrow(quants)){
      arrows(quants$year[i]+move*(n-2.5),quants$med[i],quants$year[i]+move*(n-2.5),quants$upp[i], angle=90, length=0.05, col=colours[n], lwd=1)
      arrows(quants$year[i]+move*(n-2.5),quants$med[i],quants$year[i]+move*(n-2.5),quants$low[i], angle=90, length=0.05, col=colours[n], lwd=1)
    }
  }
  
  # Add points for regions
  for(n in 1:(length(uniq2)-1)){
    temppoints4 <- temppoints3[temppoints3$reg==uniq2[n],]
    points(temppoints4$year+move*(n-2.5),temppoints4$med, pch=21, bg=colours[n], cex=1.5)
  }
  
  # Add points for Norge
  points(temppoints$year+(move*(-2.5)),temppoints$med, pch=21, bg=colours[6], cex=1.5)
  
  # Add legend to plot
  legend(legendPosition, legendPositionY, legend = c(regOrder[6], regOrder[1:5]), col = c(colours[6], colours[1:5]), 
         #bg = c(colours), 
         pch=16, lty=2,
         lwd=1.5, bty="n", inset=legendInset, title="", horiz = horizontal,
         cex=legendTextSize)
  
  
  
}
