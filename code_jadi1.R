dat = NULL

link = data.frame(satu = rep("",101), dua = rep("",101), tiga = rep("",101))

link$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link$dua = seq(101) 
link$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/a[1]/div[1]/div[2]/div[1]/span[1]"

link2 = data.frame(satu = rep("",101), dua = rep("",101), tiga = rep("",101))

link2$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link2$dua = seq(101)
link2$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[2]"

link3 = data.frame(satu = rep("",101), dua = rep("",101), tiga = rep("",101))

link3$satu = "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div["
link3$dua = seq(101)
link3$tiga = "]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/a[1]/time[1]"

nama = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/a[1]/div[1]/div[2]/div[1]/span[1]")$getElementText()

text = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]")$getElementText()

waktu = demDr$findElement(
  "xpath",
  "/html[1]/body[1]/div[1]/div[1]/div[1]/div[2]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/article[1]/div[1]/div[1]/div[1]/div[3]/div[3]/div[1]/div[1]/a[1]/span[1]")$getElementText()




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

dat = as.data.frame(dat)
as.character(dat$vertex1) -> dat$vertex1
as.character(dat$vertex2) -> dat$vertex2
as.character(dat$replying) -> dat$replying
as.character(dat$time) -> dat$time


gsub("\\bReplying to\\b", "", dat$replying) -> dat$replying
dat$replying = trimws(dat$replying, which = "both")


by <- function(x) {
  if(str_detect(dat$replying[x], unlist(nama)) == TRUE) {
    return(dat$vertex2[x])
  } else if(str_detect(dat$replying[x], unlist(nama)) == FALSE) {
    return(dat$vertex1[x-1])
  }
}

try(silent = T,
sapply(2:nrow(dat), FUN = by) -> dat$vertex2[2:nrow(dat)]
)

try(silent = T,
dat <- dat %>%
  mutate(nomor = seq(nrow(dat))) %>%
  filter(nchar(vertex1)>1) %>%
  group_by(vertex1, replying) %>%
  slice(1) %>% 
  arrange(nomor) %>% 
  select(-nomor) 
)

tryCatch({
  
  dat2 = data.frame(vertex1 = nama,
                    vertex2 = nama,
                    replying = text,
                    time = waktu)
  
  names(dat2)[c(seq(4))] = c("vertex1","vertex2","replying","time")
  
  dat = rbind(dat2,dat)
  
}, error = function(e) {message("done")},
warning = function(w) {message("done")},
message = function(m) {message("done")})

dat$urutan_ke = pai


dataset = rbind(dataset,dat)