local Remap = require('nelgau.keymap')
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap('<C-f>', ':NERDTreeFocus<CR>')
nnoremap('<C-n>', ':NERDTree<CR>')
nnoremap('<C-t>', ':NERDTreeToggle<CR>')
