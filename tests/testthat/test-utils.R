test_that("test that get_network_path catches a path that is not set", {
  Sys.unsetenv(path_envvar_name()) ##unset the path
  expect_error(get_network_path(), "You need to set your network path. Use set_network_path()")
})

test_that("test that get_network_path fails when env var is set but no vpn", {
  Sys.setenv("SAFEPATHS_NETWORK_PATH" = "foo")
  Sys.getenv(path_envvar_name())
  expect_error(get_network_path(), "There has been a problem. Are you sure you are connected to the VPN?")
})
