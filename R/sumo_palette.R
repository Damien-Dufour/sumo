#' sumo_palette
#'
#'
#' @name sumo_palette
#'
#' @param x number of colour to display, by default 6
#'
#' @description create a palette of colours based on Hokusai wave
#'
#'
#' @examples
#'
#'ggplot(iris)+
#'  aes(x = Species,
#'      y = Sepal.Length,
#'      colour = Species)+
#'  geom_jitter()+
#'  scale_color_manual(values = sumo_pal())+
#'  theme_classic()
#'
#' @export
sumo_pal <- function(x = 6)
{
  #create the basis of colours, this one is based on Hokusai's wave
  if(x == 2)
  {
    pal <- c("#011640",
             "#BF9663")

  }else{
    if(x == 3)
    {
      pal <- c("#011640",
               "#7BA696",
               "#BF9663")
    }else{

    pal <- c("#011640",
             "#2D5873",
             "#7BA696",
             "#BFBA9F",
             "#BF9663")


    # convert hex to RGB

    rgb_col <- col2rgb(pal)

    # we will soon need to go from RGB to col

    rgb2col <- function(rgbinput){

      convertrgb <- function(col){
        rgb(rgbinput[1, col],
            rgbinput[2, col],
            rgbinput[3, col],
            maxColorValue = 255)
      }
      # Apply the function
      sapply(1:ncol(rgbinput), convertrgb)
    }




    # Create intermediate colours as long as it has not reach x colours

    while(ncol(rgb_col) < x)
    {

      # generate odd number of column

      odd <- seq(1,
                 by=2,
                 len=ncol(rgb_col))

      # loop that create intermediate colours, since it create a new column between two, i only takes odd values

      for(i in odd)
      {
        if(i != ncol(rgb_col))
        {
          tmp <- (rgb_col[,i] + rgb_col[,i+1])/2

          rgb_col <- cbind(rgb_col[,1:i],
                           tmp,
                           rgb_col[,(i+1):ncol(rgb_col)])
        }
      }

    }
    pal <- rgb2col(rgb_col)

  }}
  return(pal)
}






