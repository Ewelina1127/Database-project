
library(config)

cfg <- config::get()
if (cfg$db$type == "postgres") {
  
  source("helper_functions.R")
} else {

  source("../sqlite-version-demo/helper_functions_sqlite.R")
}
