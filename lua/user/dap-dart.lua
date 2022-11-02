local dap = require('dap')
dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { os.getenv('HOME') .. "/.config/nvim/dap/Dart-Code/out/dist/debug.js", "flutter" }
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/opt/homebrew/Caskroom/flutter/3.3.2/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = "/opt/homebrew/Caskroom/flutter/3.3.2/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
    toolArgs = {"-d", "macos"},
  }
}
