-- ===========================
--  Autocompletion (nvim-cmp) 
-- ===========================
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Key mappings for completion
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-j-k>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion.
    -- Use Tab to navigate through suggestions
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  -- Sources for completion
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- ===========================
--  LSP (lspconfig and mason)
-- ===========================

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local default_on_attach = function(client, bufnr)
  -- Enable completion triggered by characters
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set keymaps for LSP functionality
  vim.keymap.set('n', 'K',          vim.lsp.buf.hover,          { buffer = bufnr, desc = 'LSP Hover' })
  vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,     { buffer = bufnr, desc = 'Go to Definition' })
  vim.keymap.set('n', 'gr',         vim.lsp.buf.references,     { buffer = bufnr, desc = 'Go to References' })
  vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to Implementation' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,    { buffer = bufnr, desc = 'Code Actions' })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,         { buffer = bufnr, desc = 'Rename Symbol' })
  vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,   { buffer = bufnr, desc = 'Previous Diagnostic' })
  vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,   { buffer = bufnr, desc = 'Next Diagnostic' })
end

-- Get the capabilities from nvim-cmp
local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup mason
mason.setup()

-- Setup mason-lspconfig to automatically setup servers
mason_lspconfig.setup({
  ensure_installed = {
    'lua_ls',
    'pyright',
    'ts_ls',
    'emmet_ls',
    'cssls',
    'tailwindcss',
    'jsonls'
  },
  handlers = {
    function(server_name)
        local opts = {
            on_attach = default_on_attach,
            capabilities = default_capabilities
        }

        local require_path = "McKearnyPlum.lsp_settings." .. server_name
        local has_custom_opts, custom_opts = pcall(require, require_path)

        if has_custom_opts then
            if custom_opts.on_attach then
                local specific_on_attach = custom_opts.on_attach
                opts.on_attach = function (client, bufnr)
                    specific_on_attach(client, bufnr)
                    default_on_attach(client, bufnr)
                end
                custom_opts.on_attach = nil
            end
            opts = vim.tbl_deep_extend("force", opts, custom_opts)
        end

        vim.lsp.config(server_name, opts)
        vim.lsp.enable(server_name)

    end
  }
})

-- ===========================
-- Making vim. commands Global
-- ===========================

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } }
        }
    }
})
