# sumo

This package contains various functions related to statistics, data visualisation, data organisation and image analysis.

Make_project() creates an environment with classical folder structures (Data, Figures, Docs, References, Sources, Gist) and a R script at its root.
If IHC = TRUE, it will create "czi" folder to store raw images, "jpg" folder and "QP_analysis" folder containing a QuPath project for further analyses.

SourceAll() detects all .R files located in the "Sources" folder and source them as functions.

Comp3Moy() is made to compare means of two or more distributions in a dataset. Based on normality and variance, it will pick the best tests to use and yield the result.

graphsumo() creates graphs with ggplot2 made from a scatter plot and violin plot where the median is representated by an horizontal line and the mean by a cross. 

save_pheatmap() is a small function to easily save heatmap made with pheatmap in .png or .pdf in a similar fashion to the ggsave() function.

sumo_pal() creates a colour palette based on Hokusai's great wave off Kanagawa (I might create new ones eventually), it only works for discrete variable at the moment
