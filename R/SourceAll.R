#' SourceAll
#'
#'
#' @name SourceAll
#'
#' @description will source every functions located in the Sources folder if it contains functions
#'
#' @examples
#'
#'
#' @export
SourceAll <- function()
  {if(nrow(data.frame(list.files("Sources/"))) != 0)
    {
  files.sources = list.files("Sources/") #get all the files in Sources folder 
  
  sapply(paste0("Sources/",
                files.sources), 
         source)                      #sources the functions
    }
  }