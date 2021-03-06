#------------------------------------------------------------------------------#
# Description: Driver program for ProSepsis data processing	  	               #
# Author:      hpy1                                                            #
# Created:     April 4, 2022                                                #
#------------------------------------------------------------------------------#
library(tidyverse)
library(lubridate)
library(DBI)
library(odbc)
library(haven)

## Set folders -----------------------------------------------------------------
code_folder <- paste0(getwd(), "/Code")
data_folder <- paste0(getwd(), "/Data")

## Get data from SQL Server ----------------------------------------------------
dbConnector <- function(server, database, uid, pwd) {
  DBI::dbConnect(odbc::odbc(),
                 Driver   = "SQL Server",
                 Server   = server,
                 Database = database,
                 Uid      = uid,
                 Pwd      = pwd)
}

server = "1.20.151.54,11433"
database = "ProSepsis"
uid = "hqa3"
pwd = "T@M!2564"
#uid = rstudioapi::askForPassword("Database user")
#pwd = rstudioapi::askForPassword("Database password")
dbConn <- dbConnector(server, database, uid, pwd)
tblpart1  <- dbGetQuery(dbConn,'select * from "tblpart1"')
tblLabVItalS  <- dbGetQuery(dbConn,'select * from "tblLabVItalS"')

## Data wrangling for each data frame ------------------------------------------
 source(paste0(code_folder, "/tblpart1.R"))
 source(paste0(code_folder, "/tblLabVItalS.R"))
# #source(paste0(code_folder, "/PSMast.R"))

#--- Import from SAS ----
# tblpart1 <- read_sas("C:/MyD/Sepsis_Pro/MF/tblpart1.sas7bdat", NULL)
# tblLabVItalS <- read_sas("C:/MyD/Sepsis_Pro/MF/tbllabvitals.sas7bdat", NULL)

psmast <- read_sas("C:/MyD/Sepsis_Pro/MF/psmast.sas7bdat", NULL)
#source(paste0(code_folder, "/PSMast.R"))
#source(paste0(code_folder, "/Flowchart.R"))
#source(paste0(code_folder, "/PSDashboard.R"))

