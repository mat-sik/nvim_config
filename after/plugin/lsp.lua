-- ───────── Completion ─────────
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
    },
    -- preset.insert does not map Tab / S-Tab
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
})

-- ───────── Diagnostics ─────────
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN]  = 'W',
            [vim.diagnostic.severity.HINT]  = 'H',
            [vim.diagnostic.severity.INFO]  = 'I',
        },
    },
})

-- ───────── Servers ─────────
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Fix Undefined global 'vim'
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'lua_ls', 'gopls', 'jdtls' },
    -- nvim-jdtls starts its own client (same as lsp.skip_server_setup)
    automatic_enable = { exclude = { 'jdtls' } },
})

-- ───────── Keymaps (on attach) ─────────
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local function opts(desc)
            return { buffer = bufnr, remap = false, desc = desc }
        end

        -- diagnostics
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts('goto next'))
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts('goto prev'))
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts('show error message popup'))
        vim.keymap.set('n', '<space>vq', vim.diagnostic.setloclist, opts('setloclist'))

        -- navigation
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('[G]o to [D]eclaration'))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('[G]o to [d]efinition'))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('[G]o to [i]mplementation'))
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts('signature help'))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('show references'))

        -- workspace
        vim.keymap.set('n', '<space>vwa', vim.lsp.buf.add_workspace_folder, opts('add workspace folder'))
        vim.keymap.set('n', '<space>vwr', vim.lsp.buf.remove_workspace_folder, opts('remove workspace folder'))
        vim.keymap.set('n', '<space>vwl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts('list workspace folders'))
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts('workspace symbol'))

        -- actions
        vim.keymap.set('n', '<leader>vD', vim.lsp.buf.type_definition, opts('type [D]efinition'))
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts('rename'))
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts('code action'))
        vim.keymap.set('n', '<space>vf', function() vim.lsp.buf.format({ async = true }) end, opts('[F]ormat'))
    end,
})
