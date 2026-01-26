dyn.load(paste("hello", .Platform$dynlib.ext, sep=""))
source("hello.R")
cacheMetaData(1)
Hello_GetMessage()
