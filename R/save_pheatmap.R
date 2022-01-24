#' save_pheatmap
#'
#'
#' @name save_pheatmap
#'
#' @param x heatmap name
#' @param filename directory and name with extension (pdf or png)
#' @param width,height the width and height of the graphics region in inches
#'
#'
#' @description save pheatmap
#' @import rstatix
#' @import pheatmap
#' @importFrom grDevices dev.off pdf png
#'
#' @examples
#'
#'
#' @export
save_pheatmap <- function(x, filename, width=480, height=960) {
  stopifnot(!missing(x))
  stopifnot(!missing(filename))

  if(endsWith(filename,
              "pdf")){
    pdf(filename,width = width, height=height)
    grid::grid.newpage()
    grid::grid.draw(x$gtable)
    dev.off()
  } else {
    png(filename,width = width, height=height)
    grid::grid.newpage()
    grid::grid.draw(x$gtable)
    dev.off()
  }
}
