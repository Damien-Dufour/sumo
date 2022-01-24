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
#' @description Compare 2 or more datasets using the right test according to normality and variances
#' Condition and Measure should be different columns of the same dataset (Dataset$colA)
#'  @import rstatix
#'  @import dplyr
#'  @examples
#'
#'    Comp3Moy(iris$Species, iris$Sepal.Length, n=150)
#'
#' @export
Comp3Moy <- function(Condition, Measure,n=3)
{

  # homoscedasticity (if P-val<0.05 then diff variances)------------------------

  x <- data.frame(Condition = Condition,
                  Measure = Measure)

  Barlett <- bartlett.test(Measure ~ Condition, x)
  Barlett$p.value

  if(Barlett$p.value>=0.05)
  {
    print("homoscedasticity")
  }else{
    print("different variances")
  }


  #normality (if P-val<0.05 then non normal) -----------------------------------

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
       Np <- "non normal"    #create a table for every populations, if one of them is not normal, then non normality of the whole dataset is assumed
   }
  }



  if (n < 5)
  {
    normalitytest <- "Not enough samples for normality test"
    Np <- ""
  }
  print(c(normalitytest,
         Np))


  # anova with homoscedascity and normality ------------------------------------

  if(Barlett$p.value>=0.05& Np == "normally distributed")
  {
    test <- aov(Measure ~ Condition, x)
    anova <- summary(test)
    print(anova)

    tt <- pairwise.t.test(x$Measure,
                          x$Condition,
                          p.adjust.method = "fdr")
    print("pairwise t.test :")
    return(tt)
  }else{

 # anova without homoscedascity but normal distribution (Welch anova) ----------

    if(Barlett$p.value<=0.05& Np == "normally distributed")
    {

      welch <- welch_anova_test(x,
                                Measure ~ Condition)

      print(welch)
      if(welch$p <= 0.05)
      {
        tt <- pairwise.t.test(x$Measure,
                              x$Condition,
                              p.adjust.method = "fdr",
                              pool.sd=FALSE)
        print("pairwise t.test :")
        return(tt)
      }


    }else{


 # anova without normality (kruskal wallis) ------------------------------------


      Krus <- kruskal.test(Measure ~ Condition, x)
      Krus$p.value

      effsiz <- kruskal_effsize(x, Measure ~ Condition)

      if(effsiz$effsize<=0.06)
        (print("small effect")
        )else(
          if(effsiz$effsize>=0.14)
            (print("large effect")
            )else(
              print("medium effect")
            )
        )
      print("Krus :")
      print(Krus$p.value)
      DT <- dunn_test(x, Measure ~ Condition, p.adjust.method = "fdr")
      return(DT)
    }
  }
}
