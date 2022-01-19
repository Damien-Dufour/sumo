#' make_project
#'
#'
#' @name make_project
#'
#' @param path = path
#' @param IHC true if it's an IHC and I want jpg, czi and QP folders
#' @description Strongly inspired by "https://github.com/nibortolum/manageproject". but more specific to my style of coding
#'
#' @examples
#'
#'
#' @export
make_project <- function (path,
                          ref = TRUE,
                          IHC =FALSE)
{
  if (!dir.exists(path))
    dir.create(path)
  setwd(path)
  pathf <- getwd()
  nameMain <- paste(gsub("[[:space:]]", "_", basename(path)),
                    "_MainScript.R", sep = "")
  nameDoc <- paste("Docs/", gsub("[[:space:]]", "_", basename(path)),
                   "_docs.Rmd", sep = "")
  configFile <- paste(basename(path), ".config", sep = "")
  dir.create("Data")
  dir.create("Sources")
  dir.create("Figures")
  dir.create("Docs")
  dir.create("Gist")
  if(IHC == TRUE)
    {
  dir.create("QP_analysis")
  dir.create("czi")
  dir.create("jpg")
  }
  if (ref) {
    dir.create("References")
  }
  file.create(nameMain)
  file.create(nameDoc)
  file.create(configFile)
  sink(nameMain)
  cat("\n# Clean up ----------------------------------------------------------------\nrm(list = ls())\n\n# Load Packages and Sources -----------------------------------------------\nlibrary(sumo)\nSourceAll()\n\n# Load Data ---------------------------------------------------------------\nsetwd(dirname(rstudioapi::getActiveDocumentContext()$path))\n\n")
  cat("# Clean -------------------------------------------------------------------\n\n\n# Start working -----------------------------------------------------------\n\n\n# DEBUG ZONE --------------------------------------------------------------\n\n# END DEBUG ZONE ----------------------------------------------------------\n")
  sink()
  sink(nameDoc)
  cat(paste("---\ntitle: ", "\"Working notes for ", basename(path),
            " project\"\nauthor:\n - First Name, Last Name\noutput: pdf_document\nfontsize: 12pt\n---\n   \n# My first Idea\nwhat it is\n",
            sep = ""))
  sink()
}
