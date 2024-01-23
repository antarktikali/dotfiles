local ctrlp_map = "<c-p>"

return {
  "ctrlpvim/ctrlp.vim",
  init = function()
    vim.g.ctrlp_map = ctrlp_map
    vim.g.ctrlp_cmd = "CtrlPBuffer"
  end,
  keys = {
    { ctrlp_map, desc = "CtrlP" },
  },
  config = function()
    if vim.fn.executable "rg" == 1 then
      vim.g.ctrlp_use_caching = false
      vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    end
  end,
}

