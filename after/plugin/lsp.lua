local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local get_opts = function(desc)
    return { buffer = bufnr, remap = false, desc = desc }
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, get_opts('goto next'))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, get_opts('goto prev'))
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, get_opts('show error message popup'))
    vim.keymap.set('n', '<space>vq', function() vim.diagnostic.setloclist() end, get_opts('setloclist'))

    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, get_opts('[G] to [D]eclaration'))
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, get_opts('[G]o to [d]efinition'))
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, get_opts('Hover'))
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, get_opts('[G]o to [i]mplementation'))
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, get_opts('signature help'))

    vim.keymap.set('n', '<space>vwa', function() vim.lsp.buf.add_workspace_folder() end, get_opts('add workspace folder'))
    vim.keymap.set('n', '<space>vwr', function() vim.lsp.buf.remove_workspace_folder() end,
        get_opts('remove workspace folder'))
    vim.keymap.set('n', '<space>vwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, get_opts('list workspace folders'))

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, get_opts('workspace symbol'))
    vim.keymap.set("n", "<leader>vD", function() vim.lsp.buf.type_definition() end, get_opts('type [D]efinition'))
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, get_opts('rename'))
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, get_opts('show references'))
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, get_opts('code action'))
    vim.keymap.set('n', '<space>vf', function() vim.lsp.buf.format { async = true } end, get_opts('[F]ormat'))

    lsp.default_keymaps({ buffer = bufnr })
end)

vim.diagnostic.config({
    virtual_text = true
})

lsp.skip_server_setup({ 'jdtls' })

lsp.setup()
