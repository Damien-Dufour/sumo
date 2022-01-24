#' Comp2Moy
#'
#'
#' @name Comp2Moy
#'
#' @param Measure1 a measure from a dataset
#' @param Measure2 the same measure from a different dataset
#'

#' @description Compare 2 dataset using the right test according to normality and variances
#' @import rstatix
#' @import stats
#'
#' @examples
#'
#' Comp2Moy(iris$Sepal.Length,iris$Petal.Length)
#'
#' @export
Comp2Moy <- function(Measure1, Measure2)
{ ##compare 2 distributions
  ##homoscedasticity (if pval<0.05 then diff variances)

  Homoscedtest<-var.test(Measure1, Measure2)

  if (Homoscedtest$p.value>=0.05)
    (print("same variance")
    )else(print("different variances")
    )

   ##normality (if pval<0.05 then non normal)

  testnorm1<-ks.test(Measure1, pnorm)
  testnorm2<-ks.test(Measure2, pnorm)


  if (testnorm1$p.value>=0.05)
    (print("Measure 1 normally distributed")
    )else(print("Measure 1 non normal")
    )
  if (testnorm2$p.value>=0.05)
    (print("Measure 1 normally distributed")
    )else(print("Measure 1 non normal")
    )


  if(testnorm1$p.value<=0.05 | testnorm1$p.value<=0.05)
    (wilcox.test(Measure1,
                 Measure2,
                c("two.sided"),
                conf.int = FALSE,
                conf.level = 0.95)
  )else(if(Homoscedtest$p.value>=0.05)
           t.test(Measure1,
                   Measure2,
                   c("two.sided"),
                   paired = FALSE,
                   var.equal = TRUE)
           else t.test(Measure1,
                       Measure2,
                       c("two.sided"),
                       paired = FALSE,
                       var.equal = FALSE)
  )
  }
