
# clean working space first
rm(list = ls())

# setwd() defines the working directory
setwd("~/Dropbox/II/projects/teaching/madrid_2017")
dir()

# installing packages
#install.packages("readxl")

# loading libaries
# library(readxl)
library(ggplot2)


################## STEP 1: read in file with occupations ##########################
df <- read.csv("./data/source/spanish_occupations_example.csv", stringsAsFactors = FALSE)
str(df)
names(df)[1] <- "mocc"
names(df)
head(df)
################## STEP 2: load HISCAM scores ##########################

# getting HISCAM scores online from HISCAM.ORG
hcamU1 <- read.table(
    "http://www.camsis.stir.ac.uk/hiscam/v1_3_1/hiscam_u1.dat", 
    sep = "\t", 
    header = TRUE, 
    stringsAsFactors = FALSE)

str(hcamU1)

################## STEP 3: merge occupations with HISCAM scores ##########################

mdf <- merge(df, hcamU1, 
              by.x = "hisco", by.y = "hisco",
              all.x = TRUE) # preserves all cases in the x-file (df).
names(mdf)
dim(mdf)
head(mdf) # tada!


#################################################################
# Let's do this again, now merging early and late hiscam scores #
#################################################################

# early hiscam
hcamE <- read.table(
    "http://www.camsis.stir.ac.uk/hiscam/v1_3_1/hiscam_e.dat", 
    sep = "\t", 
    header = TRUE, 
    stringsAsFactors = FALSE)
str(hcamE)

# NB: change name of the variable: all version are called 'hiscam'
names(hcamE)[2] <- "hiscam_early"
str(hcamE)

# late hiscam
hcamL <- read.table(
    "http://www.camsis.stir.ac.uk/hiscam/v1_3_1/hiscam_l.dat", 
    sep = "\t", 
    header = TRUE, 
    stringsAsFactors = FALSE)
str(hcamL)

# NB: change name of the variable: all version are called 'hiscam'
names(hcamL)[2] <- "hiscam_late"
str(hcamL)

# So we use our earlier file to merge the HISCAM scales in

mdf2 <- merge(mdf, hcamE, 
             by.x = "hisco", by.y = "hisco",
             all.x = TRUE) # preserves all cases in the x-file (df).
names(mdf2)
dim(mdf2)
head(mdf2) # fantastico!

# Again preserving our earlier file:
mdf3 <- merge(mdf2, hcamL, 
              by.x = "hisco", by.y = "hisco",
              all.x = TRUE) # preserves all cases in the x-file (df).
names(mdf3)
dim(mdf3)
head(mdf3) # fantastico!


p1 <- ggplot(mdf3, aes(x = hiscam_early,
                       y = hiscam_late, label = hisco)) + geom_point()
    theme_bw()
p1

# This is just for fun... but really practical

# install.packages("plotly")
library(plotly)
ggplotly(p1)



