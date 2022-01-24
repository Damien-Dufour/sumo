#' graphsumo
#'
#'
#' @name graphsumo
#'
#' @param dataset dataset organised as col = c(condition, value) and 1 row = 1 sample
#' @param abs parameter to be plotted in x ex : genotype
#' @param ord parameter to be plotted in y ex : value
#' @param MFV can be vir for viridis scale, male for b&w or female for red&white
#' @param alphajitter transparence
#' @param n number of populations
#' @description plot a nice and consistent graph
#'
#' @import ggplot2
#'
#' @examples
#'
#'   graphsumo(iris, iris$Species, iris$Petal.Length, "vir")
#'
#' @export
graphsumo = function(dataset, abs, ord, MFV = "vir", alphajitter = 1 ,n)
  {




  if (MFV == "vir")
  {graph <-ggplot(dataset)+
    aes(abs,
        ord,
        fill = abs)+
    geom_jitter(size = 1.5,
                alpha = alphajitter,
                shape = 21)+
    geom_violin(alpha = 0.1,
                draw_quantiles = c(0.5))+
    scale_fill_viridis_d()+
    theme_classic(base_size = 6)+
    labs(x="",
         y="")+
    theme(legend.position="none",
          axis.text = element_text(size = 6))+
    stat_summary(fun=mean,
                 colour="black",
                 geom="point",
                 shape = 3)
  graph}else{

  if (MFV == "male")
    {
    palette <- data.frame(fill = rep(c("white",
                                        "black"),
                                      n/2),
                           col = rep(c("black",
                                       "black"),
                                     n/2))}
   {if (MFV == "female")
     {
    palette <- data.frame(fill = rep(c("white",
                                       "#a00000"),
                                     n/2),
                          col = rep(c("#a00000",
                                      "black"),
                                    n/2))}
  graph <-ggplot(dataset)+
    aes(abs,
        ord,
        fill = abs,
        color = abs)+
    geom_jitter(size = 1.5,
                alpha = alphajitter,
                shape = 21)+
    geom_violin(alpha = 0.1,
                draw_quantiles = c(0.5))+
    scale_fill_manual(values = palette$fill)+
    scale_color_manual(values = palette$col)+
    theme_classic(base_size = 6)+
    labs(x="",
         y="")+
    theme(legend.position="none",
          axis.text = element_text(size = 6))+
    stat_summary(fun=mean,
                 colour="black",
                 geom="point",
                 shape = 3)
  graph}
  }



  return(graph)
}
