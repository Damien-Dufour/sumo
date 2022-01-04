#' triQP
#'
#'
#' @name triQP
#'
#' @param df dataset extracted from a QPath analysis and where annotation correspond to "Genotype Sex"
#' @description will create 2 columns containing respectively the genotype and the sex of the samples
#'
#' @examples
#'
#'
#' @export
triQP <- function(df)
{
  df$genotype <- ifelse(startsWith(df$Parent,
                                   "Senp2cKO"),
                        "Senp2cKO",
                        ifelse(startsWith(df$Parent,
                                          "R1acKO"),
                               "R1acKO",
                               ifelse(startsWith(df$Parent,
                                                 "WT"),
                                      "WT",
                                      ifelse(startsWith(df$Parent,
                                                        "dKO"),
                                             "dKO",
                                             "Unknown"))))
  df$sex <- ifelse(endsWith(df$Parent,
                            "M"),
                   "Male",
                   "Female")
  return(df)
}
