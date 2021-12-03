
dat = NULL
link = data.frame(satu = rep("",51), dua = rep("",51), tiga = rep("",51))

link$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link$dua = seq(51) 
link$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/a[1]/div[1]/div[2]/div[1]/span[1]"

link2 = data.frame(satu = rep("",51), dua = rep("",51), tiga = rep("",51))

link2$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link2$dua = seq(51)
link2$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[2]"

link3 = data.frame(satu = rep("",51), dua = rep("",51), tiga = rep("",51))

link3$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link3$dua = seq(51)
link3$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/a[1]/time[1]"


############################################################################################

nama = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/a[1]/div[1]/div[2]/div[1]/span[1]")$getElementText()



text = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]")$getElementText()



waktu = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[3]/div[3]/div[1]/div[1]/a[1]/span[1]")$getElementText()


webElem <- demDr$findElement("css", "body")

while(length(link) > 1) {

for(i in seq(nrow(link))) {
  
  tryCatch({
    
    try(
      a <- demDr$findElement("xpath",
                             as.character(interaction(link[i,],sep="")))$getElementText()
    )
    a <- unlist(a)
    
    try(
      b <- demDr$findElement("xpath",
                             as.character(interaction(link2[i,],sep="")))$getElementText()
    )
    b <- unlist(b)
    
    try(
      c <- demDr$findElement("xpath",
                             as.character(interaction(link3[i,],sep="")))$getElementText()
    )
    c <- unlist(c)
    
    ab = data.frame(vertex1 = a, nama, replying = b,time = c)
    names(ab)[2] = "vertex2"
    dat = rbind(dat,ab)
    
    ab = NULL
  }, error = function(e) {message("done")},
  warning = function(w) {message("done")},
  message = function(m) {message("done")})
}


webElem$sendKeysToElement(list(key = "page_down"))
Sys.sleep(1)
webElem$sendKeysToElement(list(key = "page_down"))

    print(paste("berhasil mengambil",nrow(dat),"komentar"))

}
