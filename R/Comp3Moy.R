#' Comp3Moy
#'
#'
#' @name Comp3Moy
#'
#' @param Condition the different conditions named in the same column
#'library
#' @param Measure the values measured for every sample
#' @param n is the number or replicates per condition
#'
#'
#' @description Compare 3 or more datasets using the right test according to normality and variances
#'
#'  @import rstatix
#'  @import dplyr
#'  @importFrom methods show
#'
#'  @examples
#'
#'    Comp3Moy(Dataset$sex, Dataset$size)
#'
#' @export
Comp3Moy <- function(Condition, Measure,n=3)
{ ##compare 3 or more distributions
  ###Condition and Measure should be different columns of the same dataset (Dataset$colA)
  # homoscedasticity (if pval<0.05 then diff variances)----------------

  x <- data.frame(Condition = Condition,
                  Measure = Measure)

  Barlett <- bartlett.test(Measure ~ Condition, x)
  Barlett$p.value

  if(Barlett$p.value>=0.05)
  {
    show("homoscedasticity")
  }else{
    show("different variances")
  }



  #normality (if pval<0.05 then non normal) ------------------------------------

  Np <- "normally distributed" #until challenged



  if (n >= 5000 | (n < 7 & n >= 5))
  {
    normalitytest <- "Kolmogorov-Smirnoff"
    Norm <- ks.test(Measure,
                    pnorm)
    if (Norm$p.value<0.05)
    {Np <- "non normal"}
  }

  if (n < 5000 && n >= 7)
  {normalitytest <- "Shapiro & Wilk"
   Norm <-  x %>%
    group_by(Condition) %>%
    shapiro_test(Measure)

   for(i in c(1:nrow(Norm)))
   {
     if (Norm[i,4] < 0.05)
       Np <- "non normal"
   }
  }



  if (n < 5)
  {
    normalitytest <- "Not enough samples for normality test"
    Np <- ""
  }
  show(c(normalitytest,
         Np))


  # anova with homoscedascity and normality -------------------------------

  if(Barlett$p.value>=0.05& Np == "normally distributed")
  {
    test <- aov(Measure ~ Condition, x)
    anova <- summary(test)
    show(anova)

    tt <- pairwise.t.test(x$Measure,
                          x$Condition,
                          p.adjust.method = "fdr")
    show("pairwise t.test :")
    return(tt)
  }else{

 # anova without homoscedascity but normal distribution (Welch anova) ------------

    if(Barlett$p.value<=0.05& Np == "normally distributed")
    {

      welch <- welch_anova_test(x,
                                Measure ~ Condition)

      show(welch)
      if(welch$p <= 0.05)
      {
        tt <- pairwise.t.test(x$Measure,
                              x$Condition,
                              p.adjust.method = "fdr",
                              pool.sd=FALSE)
        show("pairwise t.test :")
        return(tt)
      }


    }else{


 # anova without normality (kruskal wallis) ------------


      Krus <- kruskal.test(Measure ~ Condition, x)
      Krus$p.value

      effsiz <- kruskal_effsize(x, Measure ~ Condition)

      if(effsiz$effsize<=0.06)
        (show("small effect")
        )else(
          if(effsiz$effsize>=0.14)
            (show("large effect")
            )else(
              show("medium effect")
            )
        )
      show("Krus :")
      show(Krus$p.value)
      DT <- dunn_test(x, Measure ~ Condition, p.adjust.method = "fdr")
      return(DT)
    }
  }
}
