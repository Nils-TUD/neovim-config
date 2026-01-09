-- save on ctrl+s
vim.cmd([[:nmap <c-s> :w<CR>]])
vim.cmd([[:imap <c-s> <Esc>:w<CR>a]])

-- remap redo (so that we can use c-r for document symbols)
vim.cmd([[:nnoremap U <c-r>]])

-- reflow paragraph
vim.cmd([[:nmap <a-q> {V}gw]])

-- select all
vim.cmd([[:nmap <c-a> ggVG]])

-- prev/next paragraph
vim.cmd([[:nmap - }]])
vim.cmd([[:vmap - }]])
vim.cmd([[:nmap + {]])
vim.cmd([[:vmap + {]])

-- delete prev/next word
vim.cmd([[:imap <c-del> <C-o>de]])
vim.cmd([[inoremap <C-H> <c-w>]])

-- change page up/down behavior
vim.cmd([[nnoremap <silent> <PageUp> <C-U><C-U>]])
vim.cmd([[vnoremap <silent> <PageUp> <C-U><C-U>]])
vim.cmd([[inoremap <silent> <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>]])
vim.cmd([[nnoremap <silent> <PageDown> <C-D><C-D>]])
vim.cmd([[vnoremap <silent> <PageDown> <C-D><C-D>]])
vim.cmd([[inoremap <silent> <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>]])

-- disable shift+up/down
vim.cmd([[nmap <s-up> <Nop>]])
vim.cmd([[vmap <s-up> <Nop>]])
vim.cmd([[imap <s-up> <Nop>]])
vim.cmd([[nmap <s-down> <Nop>]])
vim.cmd([[vmap <s-down> <Nop>]])
vim.cmd([[imap <s-down> <Nop>]])

-- use shift+up/down for prev/next hunk
vim.cmd([[:nmap <s-up> [c]])
vim.cmd([[:nmap <s-down> ]c]])

-- spell checking
vim.cmd([[nnoremap <silent> <F11> :set spell!<cr>]])
vim.cmd([[inoremap <silent> <F11> <C-O>:set spell!<cr>]])
