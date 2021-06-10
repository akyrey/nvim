" Terminal commands
" ueoa is first through fourth finger left hand home row.
" This just means I can crush, with opposite hand, the 4 terminal positions
"
" These functions are stored in harpoon.  A plugn that I am developing
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <C-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-j> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-k> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-l> :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>ts :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>td :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>cs :lua require("harpoon.term").sendCommand(1, 1)<CR>
nnoremap <leader>cd :lua require("harpoon.term").sendCommand(1, 2)<CR>m