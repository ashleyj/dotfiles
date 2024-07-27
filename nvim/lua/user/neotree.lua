  require("neo-tree").setup({
        event_handlers = {

          {
            event = "file_opened",
            handler = function(file_path)
              require("neo-tree.command").execute({ action = "close" })
            end
          },

        }
   })
