#' SourceAll
#'
#'
#' @name SourceAll
#'
#' @description will source every functions located in the Sources folder if it contains functions
#' will better work with a project created with make_project function
#'
#' @examples
#'
#'
#' @export
SourceAll <- function()
  {if(nrow(data.frame(list.files("Sources/"))) != 0)
    {

#get all the files in Sources folder that finishes in .R

  files.sources = list.files("Sources/")  %>%
    subset(endsWith(files.sources,
                    ".R") == T)

  sapply(paste0("Sources/",
                files.sources),
         source)                      #sources the functions
    }
  }
