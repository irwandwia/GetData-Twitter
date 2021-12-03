library(RSelenium)
library(tidyverse)
library(readxl)


ppkm <- read_excel("E:/cuan/UPN/Twitter/jokowi.xlsx")
dataset = NULL
no = 1


zoom_firefox <- function(demDr, percent)
{
  store_page <- demDr$getCurrentUrl()[[1]]
  demDr$navigate("about:preferences")
  webElem <- demDr$findElement("css", "#defaultZoom")
  webElem$clickElement()
  webElem$sendKeysToElement(list(as.character(percent)))
  webElem$sendKeysToElement(list(key = "return"))
  demDr$navigate(store_page)
}


driver = rsDriver(port = 440L, 
                  browser = "firefox")

demDr = driver$client


Sys.sleep(2)

zoom_firefox(demDr,30)
Sys.sleep(2)
zoom_firefox(demDr,30)

############################################################

for(pai in seq(nrow(ppkm))) {
      
        if (pai %in% seq(40,99999,40) == TRUE) {
        
        driver = rsDriver(port = as.integer(paste0(16+no)), 
                          browser = "firefox")
        
        demDr = driver$client
        
        no <- no + 1
        
        demDr$navigate(ppkm$link[pai])
        Sys.sleep(2)
        
        zoom_firefox(demDr,30)
        Sys.sleep(2)
        zoom_firefox(demDr,30)
        
        Sys.sleep(2)
        
        source("C:\\Users\\ADAM\\Documents\\R working\\UPN\\Twitter\\code_jadi1.R")
        
        View(dataset)

      } else if(pai %in% seq(40-1,99999,40) == TRUE) {
        
        demDr$navigate(ppkm$link[pai])
        Sys.sleep(2)
        
        source("C:\\Users\\ADAM\\Documents\\R working\\UPN\\Twitter\\code_jadi1.R")
        
        Sys.sleep(1)
        driver$server$process$kill_tree()

      } else if(pai %in% seq(99999)[-c(seq(40-1,99999,40),seq(40,99999,40))] == TRUE) {
        
        demDr$navigate(ppkm$link[pai])
        Sys.sleep(2)
        
        source("C:\\Users\\ADAM\\Documents\\R working\\UPN\\Twitter\\code_jadi1.R")

      }
}