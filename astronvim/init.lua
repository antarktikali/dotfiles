local config = {
  updater = {
    channel = "stable",
  },

  options = {
    opt = {
      colorcolumn = "120",
      foldlevelstart = 30,
      cmdheight = 1,
      tabstop = 2,
      shiftwidth = 2,
    },
    g = {
      xml_syntax_folding = true,
    },
  },

  lsp = {
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    config = {
      clangd = {
        capabilities = { offsetEncoding = "utf-8" },
      },
    },
    on_attach = function(client, bufnr)
      if "clangd" == client.name then
        vim.keymap.set("n",
                       "<leader><TAB>",
                       "<cmd>ClangdSwitchSourceHeader<cr>",
                       { desc = "Switch Header/Source", buffer = bufnr })

        require "lsp_signature".on_attach({
              hint_enable = false,
            }, bufnr)
      end
    end,
  },

  polish = function()
    setup_tmux_integration()
    modify_default_foldmethod_for_some_files()
    set_filetype_for_jenkinsfiles()
  end,
}

modify_default_foldmethod_for_some_files = function()
  vim.api.nvim_create_augroup("foldmethod", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable syntax folding for certain filetypes.",
    group = "foldmethod",
    pattern = "xml",
    command = "setlocal foldmethod=syntax",
  })
end

setup_tmux_integration = function()
  vim.api.nvim_create_augroup("tmux_integration", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Set the tmux window name to match the opened buffer.",
    group = "tmux_integration",
    pattern = "*",
    command = 'call system("tmux rename-window \'" . expand("%:t") . "\'")',
  })
  vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Reset the tmux window name when exiting.",
    group = "tmux_integration",
    pattern = "*",
    command = 'call system("tmux setw automatic-rename")',
  })
end

set_filetype_for_jenkinsfiles = function()
  vim.filetype.add {
    filename = {
      [ "Jenkinsfile" ] = "groovy",
    },
  }
end

set_clipboard_if_on_wsl = function()
  if vim.fn.executable("clip.exe") == 1 then
    -- Taken from :h clipboard-wsl
    vim.g.clipboard = {
      name = 'WslClipboard',
      copy = {
        ["+"] = 'clip.exe',
        ["*"] = 'clip.exe',
      },
      paste = {
        ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      },
      cache_enabled = 0,
    }
  end
end

return config

