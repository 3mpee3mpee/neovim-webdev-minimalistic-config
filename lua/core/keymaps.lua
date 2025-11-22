-- Set leader key to space
vim.g.mapjeader = " "

local keymap = vim.keymap

-- Remove highlight on Escape pressed
keymap.set("n", "<Esc>", function() vim.cmd('noh') end)

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>x", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

-- Split window management
-- keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
-- keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
-- keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
-- keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
-- keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
-- keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger 
-- keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
-- keymap.set("n", "<Tab>", ":tabn<CR>") -- next tab
-- keymap.set("n", "<S-Tab>", ":tabp<CR>") -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Map Oil to <leader>e
keymap.set("n", "<leader>e", function()
  require("oil").toggle_float()
end)

-- Nvim-tree
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>nr", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {}) -- fuzzy find files in project
keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {}) -- grep file contents in project
keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, {}) -- fuzzy find open buffers
keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {}) -- fuzzy find help tags
keymap.set('n', '<leader>ss', require('telescope.builtin').current_buffer_fuzzy_find, {}) -- fuzzy find in current file buffer
keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, {}) -- fuzzy find LSP/class symbols
keymap.set('n', '<leader>si', require('telescope.builtin').lsp_incoming_calls, {}) -- fuzzy find LSP/incoming calls
keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = "[S]earch [S]pelling suggestions" })
keymap.set("n", "<leader>sa", require("telescope.builtin").git_status, { desc = "[S]earch Git [S]tatus" })
-- keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>ft', function() -- grep file contents in current nvim-tree node
  local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
  if not success or not node then return end;
  require('telescope.builtin').live_grep({search_dirs = {node.absolute_path}})
end)
keymap.set('n', "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })

-- GrugFar Search Engine
keymap.set('n', '<leader>s', function() require('grug-far').open({ prefills = { flags = "-i"} }) end) -- fuzzy find in current file buffer
keymap.set('n', '<leader>sw', function() require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>"), flags= "-i" } }) end) -- fuzzy find in current file buffer

-- Undoo Tree
keymap.set('n', '<leader>ut', ":UndotreeToggle<CR>") -- fuzzy find in current file buffer

-- Git
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame
keymap.set("n", "<leader>hn", function() require("gitsigns").next_hunk() end)
keymap.set("n", "<leader>hh", function() require("gitsigns").preview_hunk() end)

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>ho", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)

-- Don't yank on delete char
keymap.set("n", "x", '"_x', { silent = false })
keymap.set("n", "X", '"_X', { silent = false })
keymap.set("v", "x", '"_x', { silent = false })
keymap.set("v", "X", '"_X', { silent = false })
keymap.set("v", "p", '"_dP', { silent = false })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
keymap.set("n", "L", "$")
keymap.set("n", "H", "^")
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
keymap.set("v", "L", "$<left>")
keymap.set("v", "H", "^")
-- Highlight whole file
keymap.set("n", "<c-a>", "0ggVG")

-- Moving while in insert mode
keymap.set("i", "<c-h>", "<Left>")
keymap.set("i", "<c-j>", "<Down>")
keymap.set("i", "<c-k>", "<Up>")
keymap.set("i", "<c-l>", "<Right>")
