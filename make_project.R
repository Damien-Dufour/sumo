#' make_project
#'
#'
#' @name make_project
#'
#' @param path path where to create project
#' @param IHC true if it's an IHC and I want jpg, czi and QP folders
#' @param path_to_QuPath the path where the QuPath (console).exe is located, should look like this on windows "C:/Users/user_name/AppData/Local/QuPath-0.4.1/"
#'
#' @description Strongly inspired by "https://github.com/nibortolum/manageproject". but contains extra specific features
#' IHC=T provides folder to store raw and cropped pictures and create a QuPath project for further analyses
#' Detection of current directory enables more flexibility
#' SourceAll function makes things easier when a lot of external functions are used
#'
#' @import stringr
#'
#' @examples
#'
#'
#' @export
make_project <- function (path,
                          IHC = FALSE,
                          path_to_QuPath)
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
  dir.create("References")
  if(IHC == TRUE)
    {if (missing(path_to_QuPath)) {
      stop("Path argument is required")}

    QuPath_version <- str_sub(path_to_QuPath, start = -6, end = -2)

  dir.create("QP_analysis")
  dir.create("czi")
  dir.create("jpg")
  file.create("test.groovy")

  sink(file = "test.groovy")

  cat('import java.awt.image.BufferedImage
import qupath.lib.images.servers.ImageServerProvider

// Paths
def directory = new File("./QP_analysis/project.qpproj")

// Create project
def project = Projects.createProject(directory , BufferedImage.class)

// Changes should now be reflected in the project directory
project.syncChanges()

print("Project created")')

  sink()

  system(paste0(path_to_QuPath,
                '"QuPath-',
                QuPath_version,
                ' (console).exe" script "',
                pathf,
                '/test.groovy"'),
         intern = T)
  file.remove("test.groovy")
  }

  file.create(nameMain)
  file.create(nameDoc)
  file.create(configFile)
  sink(nameMain)
  cat("\n# Clean up ----------------------------------------------------------------\nrm(list = ls())\n")
  cat("\n# Load Packages and Sources -----------------------------------------------\n\nsetwd(dirname(rstudioapi::getActiveDocumentContext()$path))\n\nlibrary(sumo)")
  cat("\n\nSourceAll()\n")
  cat("\n# Load Data ---------------------------------------------------------------\n\n")
  cat("# Clean -------------------------------------------------------------------\n\n\n# Start working -----------------------------------------------------------\n\n")
  cat("\n# DEBUG ZONE --------------------------------------------------------------\n\n# END DEBUG ZONE ----------------------------------------------------------\n")
  sink()
  sink(nameDoc)
  cat(paste("---\ntitle: ", "\"Working notes for ", basename(path),
            " project\"\nauthor:\n - First Name, Last Name\noutput: pdf_document\nfontsize: 12pt\n---\n   \n# My first Idea\nwhat it is\n",
            sep = ""))
  sink()
}
