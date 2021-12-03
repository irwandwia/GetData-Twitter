number = 1

demDr$navigate(ppkm$link[number])

source("*E:\\cuan\\UPN\\Twitter\\only many comment.R")

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
  
  as.character(dat2$vertex1) -> dat2$vertex1
  as.character(dat2$vertex2) -> dat2$vertex2
  as.character(dat2$replying) -> dat2$replying
  as.character(dat2$time) -> dat2$time
  
  dat = rbind(dat2,dat)
  
}, error = function(e) {message("done")},
warning = function(w) {message("done")},
message = function(m) {message("done")})


dat$urutan_ke = number
dataset = rbind(dataset,dat)