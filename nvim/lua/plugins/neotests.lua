return
{
  "nvim-neotest/neotest",
  dependencies = {
    "nsidorenco/neotest-vstest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vstest")({
          dap_settings = {
            type = "coreclr",
          },
          -- If multiple solutions exists the adapter will ask you to choose one.
          -- If you have a different heuristic for choosing a solution you can provide a function here.
          solution_selector = function(solutions)
              print("Multiple solutions found, please select one:")
              for i, solution in ipairs(solutions) do
                  print(i .. ": " .. solution)
              end
            return nil -- return the solution you want to use or nil to let the adapter choose.
          end,
          -- If multiple .runsettings/testconfig.json files are present in the test project directory
          -- you will be given the choice of file to use when setting up the adapter.
          -- Or you can provide a function here
          -- default nil to select from all files in project directory
          settings_selector = function(project_dir)
            return nil -- return the .runsettings/testconfig.json file you want to use or let the adapter choose
          end,
          build_opts = {
            -- Arguments that will be added to all `dotnet build` and `dotnet msbuild` commands
            additional_args = {}
          },
          -- If project contains directories which are not supposed to be searched for solution files
          discovery_directory_filter = function(search_path)
            -- ignore hidden directories
            return search_path:match("/%.")
          end,
          -- if no obvious parent solution is found, broadly scan downward for solution files from current path. This can freeze Neovim when started from broad directories.
          broad_recursive_discovery = true,
          timeout_ms = 30 * 5 *
          1000               -- number of milliseconds to wait before timeout while communicating with adapter client

        })
      }
    })
  end
}
