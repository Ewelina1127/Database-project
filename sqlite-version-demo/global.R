library(config)

cfg <- config::get()
if (cfg$db$type == "postgres") {
  source("../postgres-version/helper_functions.R")
} else {
  source("helper_functions_sqlite.R")
}
