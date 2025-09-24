local toggleterm = require("toggleterm")

toggleterm.setup {


}

vim.keymap.set("n", "<leader>a", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { desc = "Toggle A Terminal" })


