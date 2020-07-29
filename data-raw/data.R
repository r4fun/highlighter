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

# demo
neg_txt_files <- list.files(
  path = "inst/extdata/imdb/neg/",
  full.names = TRUE
)

pos_txt_files <- list.files(
  path = "inst/extdata/imdb/pos/",
  full.names = TRUE
)

neg <- lapply(neg_txt_files, readr::read_file)
pos <- lapply(pos_txt_files, readr::read_file)
imdb <- tibble::tibble(
  "Negative Reviews" = gsub("<br />", "\n", unlist(neg)),
  "Positive Reviews" = gsub("<br />", "\n", unlist(pos))
)
saveRDS(imdb, "data/imdb.rds")
