library(ggplot2)
dat <- read.csv(file.choose(), header=TRUE)

# For HHS Region 1
p <- ggplot(data=subset(dat, location=="HHS Region 1" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 2
p <- ggplot(data=subset(dat, location=="HHS Region 2" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 3
p <- ggplot(data=subset(dat, location=="HHS Region 3" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 4
p <- ggplot(data=subset(dat, location=="HHS Region 4" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 5
p <- ggplot(data=subset(dat, location=="HHS Region 5" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 6
p <- ggplot(data=subset(dat, location=="HHS Region 6" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 7
p <- ggplot(data=subset(dat, location=="HHS Region 7" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 8
p <- ggplot(data=subset(dat, location=="HHS Region 8" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For HHS Region 9
p <- ggplot(data=subset(dat, location=="HHS Region 9" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For US Nat Data
p <- ggplot(data=subset(dat, location=="US National" & type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(~target)

# For all regions
p <- ggplot(data=subset(dat, type=="Bin"), aes(x=bin_start_incl, y=value)) + geom_point()
p + facet_grid(location~target)


