install.packages(c('Rserve','RAppArmor'), repos='http://cran.r-project.org')  

#First list of packages to install (2017-06-13)
install.packages(c('abc','acepack','actuar','adabag','ape','aplpack','approximator','arm','arules','assertthat','bclust','bit64','cclust','choroplethr','circlize','CLUSTER','coda','coin','corpcor','data.table','DBI','diffobj','dlm','dplyr','expm','forecast','gamlr','ggplot2','gmodels','highr','Iterators','janitor','jsonlite','labeling','lattice','Lazyeval','magrittr','markdown','MASS','metricsgraphics','monmlp','nnet','openxlsx','plotly','plyr','polynom','Psych','rpart','r-digest','r-evaluate','r-foreach','r-yaml','R.utils','randomForest','RColorBrewer','reshape','rJava','RJDBC','RODBC','sqldf','stringi','stringr','tibble','tidyr','tidytext'), repos='http://cran.r-project.org')  


# Second list of packages to install (2017-06-30)
install.packages(c('devtools','ggvis','googleVis','highcharter','plotly'), repos='http://cran.r-project.org')  
library(devtools)
devtools::install_github("ramnathv/rCharts")
