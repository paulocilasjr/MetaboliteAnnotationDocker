#flexible install of stringi
f = list.files(".", pattern = ".tar.gz")
install.packages(f, repos = NULL, type = "source")