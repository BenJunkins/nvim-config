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

local on_attach = function(client, bufnr)
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup mason
require('mason').setup()

-- Setup mason-lspconfig to automatically setup servers
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls', -- Example: ensure lua_ls is installed
    'pyright' -- Example: ensure pyright for Python is installed
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
	on_attach = on_attach,
	capabilities = capabilities
      })
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
