rockspec_format = "3.0"
package = "lr-stack-manager"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "inspect >= 3.1",
   "luacov >= 0.15",
   "busted >= 2.2"
}
build = {
   type = "builtin",
   modules = {
      main = "src/main.lua"
   }
}