return
{
    'Loki-Astari/cursor',
    config = function()
        require('cursor').setup({
            width = 50,                 -- Width of the cursor window (default: 50)
            auto_open = false,          -- Auto-open on startup (default: false)
            command = 'cursor-agent',
        })
    end,
    whichkey = function(wk)
        wk.add({
            {'<leader>c', group = 'Cursor'},
             vim.keymap.set("n", "<leader>ca", ":CursorOpen<CR>", { noremap = true, silent = true, desc = "Open Cursor Window" })

                {'<leader>cc', ':CursorClose<CR>',  desc = 'Close Cursor Window'},
            {'<leader>ct', ':CursorToggle<CR>', desc = 'Toggle Cursor Window'},
        })
    end,
}



