library(devtools)
library(sp)
detach("package:MatchIt", unload=TRUE)
load_all("/home/aid_data/Desktop/GitRepo/MatchIt/R")
library(MatchIt)

###
### An Example Script for Obtaining Matched Data when you have
### Spatial information
###
data(lalonde)

##Simulate Latitude and Longtiude information for each point
coords = cbind(runif(614,37.1708,37.3708), runif(614,76.6069,76.8069))

##Create a spatial points data frame
spdf_LL <- SpatialPointsDataFrame(coords, lalonde)

## perform nearest neighbor matching
m.out1 <- matchit(treat ~ re74 + re75 + age + educ, data = lalonde,
                  method = "nearest", distance = "mahalanobis", caliper=.25)

spatial_opts <- list(spatial.decay.model="threshold",  ignore.spatial=FALSE, spatial.thresholds=c(.15))
m.out2 <- matchit(treat ~ re74 + re75 + age + educ, data = spdf_LL,
                  method = "nearest", distance = "logit", distance.options=spatial_opts, caliper=0.25)