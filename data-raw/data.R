# rds
saveRDS(iris, "data/iris.rds")

# csv
write.csv(iris, "data/iris.csv")

# xlsx
openxlsx::write.xlsx(
  x = list(
    "iris" = iris,
    "mtcars" = mtcars
  ),
  file = "data/iris_mtcars.xlsx"
)
