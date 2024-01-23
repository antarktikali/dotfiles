return {
  "mhinz/vim-grepper",
  keys = {
    { "<leader>G", "<cmd>Grepper<cr>", desc = "Grepper" },
  },
  config = function()
    vim.g.grepper = {
      tools = { "rg", "grep", "git" }
    }
  end,
}

