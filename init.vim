"       _                                                  _       _ _               _           
"      | | ___ _ __ ___  _ __ ___   ___                   (_)_ __ (_) |_      __   _(_)_ __ ___  
"   _  | |/ _ \ '__/ _ \| '_ ` _ \ / _ \                  | | '_ \| | __|     \ \ / / | '_ ` _ \ 
"  | |_| |  __/ | | (_) | | | | | |  __/                  | | | | | | |_   _   \ V /| | | | | | |
"   \___/ \___|_|  \___/|_| |_| |_|\___|                  |_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|
" 
"                                                                               created with figlet
filetype indent on
syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set nohlsearch
set smartindent
set nowrap
set nobackup
set undodir=~/.config/nvim/undo_dir
set undofile
set guicursor=
set scrolloff=6
set incsearch
set laststatus=2
set background=dark
set encoding=UTF-8

let python_highlight_all = 1
" let g:python_host_prog = '/usr/bin/python'


" Everything that's in between the plug call will be used as a plug-in when calling the ~/.vimrc "
" ------------------------------------------------------------------
"  VIM-PLUG BEGIN
" ------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'jremmen/vim-ripgrep'                              " I do not even use this anymore
Plug 'tpope/vim-fugitive'                               " Git plugin, not github
"Plug 'vim-utils/vim-man'                                " View man pages in a vim-buffer. Grep for the man pages.
"Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " FuzzyFinder, works great!
Plug 'tmsvg/pear-tree'                                  " autcomplete pairs of brackets, quotes ...
Plug 'junegunn/fzf.vim'                                 " fzf, don't know why it's in here twice
Plug 'valloric/YouCompleteMe'                           " YouCompleteMe, autocomplete from buffer and programming lang
Plug 'mbbill/undotree'                                  " whenever you save something, it goes to the undo directory
Plug 'itchyny/lightline.vim'                            " Customize the status bar through this plugin
Plug 'morhetz/gruvbox'                                  " the best colorscheme in the world --ThePrimeagen
Plug 'ap/vim-css-color'                                 " whenever you use rgba or hexcode in your scripts, this highlights the colourcode as that colour
Plug 'preservim/nerdtree'                               " navigate with vim through your filetree
Plug 'ryanoasis/vim-devicons'                           " nerd fonts
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'          " used with devicons but I don't know what for
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'lervag/vimtex'                                    " Plugin to use latex in neovim; $ sudo apt install latexmk
Plug 'yuttie/comfortable-motion.vim'                    " Plugin to make scrolling smoother. Have not installed this yet, check their configs later before installing
"Plug 'jerome/mutineer'                                  " Our own plugin does not need to be PlugInstall, like this it runs off the bat no problem, assuming there is a /nvim/plugged/mutineer
Plug 'jrihon/mutineer.vim'                              " 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
" ------------------------------------------------------------------
"  VIM-PLUG END
" ------------------------------------------------------------------


" ------------------------------------------------------------------
" BUNCH OF REMAPS "
" ------------------------------------------------------------------
" INFO : <CR> means you enter the Return key when using the command, so it activates immediately
" INFO : <SPACE> is used so the command is unfinished and we can input what we need
" INFO : <bar> is the same as using a pipe symbol '|'

" New leader key, used later when remapping "
let mapleader = " "


" Whenever a new split is created
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25


" -----------------------------------
" WINDOW OR BUFFER RELATED REMAPS
" shift from left window to right window
nnoremap <leader>h :wincmd h<CR>
" shift from right window to left window
nnoremap <leader>l :wincmd l<CR>
" shift from bottom window to top window
nnoremap <leader>k :wincmd k<CR>
" shift from top window to bottom window
nnoremap <leader>j :wincmd j<CR>
" resize the window manually "
nnoremap <silent> <Leader>+ :vertical resize +15<CR>
nnoremap <silent> <Leader>- :vertical resize -15<CR>


" -----------------------------------
" Access specific files of my system
nnoremap <leader>bash :e $HOME/.bashrc<CR>
nnoremap <leader>nvim :e $HOME/.config/nvim/init.vim<CR>
nnoremap <leader>so :source $HOME/.config/nvim/init.vim<CR>


" -----------------------------------
" MISSCELANIOUS
" shows undo tree, whichs shows the history of what you've done
nnoremap <leader>u :UndotreeShow<CR>
" ripgrep to search for stuff"
nnoremap <leader>ps :Rg<SPACE>
" Toggle the quickfix list open and closed
nnoremap <leader>c :call QuickfixToggle()<cr>
" Go down visual lines when the :set wrap has been called, so mainly used in LaTex
autocmd BufNewFile,BufRead *.tex call SetMovementsInLatex()
" If the current file we are working is, is a *.tex filetype, then set the wrap function on
autocmd BufNewFile,BufRead *.tex set wrap


" Whenever I open a .tex filetype, remap the movement keys to jump visual lines
function! SetMovementsInLatex() abort
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
endfunction

" custom variable we make. This is to say that whenever the Quickfix list is open, we close it with the remap
let s:quickfix_is_open = 1
function! QuickfixToggle() abort
    if s:quickfix_is_open
        cclose
        let s:quickfix_is_open = 0
    else
        copen
        let s:quickfix_is_open = 1
    endif
endfunction


" ------------------------------------------------------------------
" MUTINEER CONFIGURATION
" ------------------------------------------------------------------
" normal mode and visual mode remap to allow single and multiline commenting
nnoremap <leader>m :Mutineer<CR> 
vnoremap <leader>m :Mutineer<CR> 
vnoremap <leader>M :MutineerBlock<CR> 

let g:SpasticCursorMovementToggle = 1


" ------------------------------------------------------------------
" TREESITTER CONFIGURATION
" ------------------------------------------------------------------
" Treesitter is disabled, as I did not like the colourscheme with python, too  much highlighting
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"  ignore_install = { "javascript" }, -- List of parsers to ignore installing
"  highlight = {
"    enable = true,              -- false will disable the whole extension
"    disable = { "c", "rust" },  -- list of language that will be disabled
"    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"    -- Using this option may slow down your editor, and you may see some duplicate highlights.
"    -- Instead of true it can also be a list of languages
"    additional_vim_regex_highlighting = false,
"  },
"}
"EOF



" ------------------------------------------------------------------
" GRUVBOX CONFIGURATION
" ------------------------------------------------------------------
" Set your terminal's background to #1D2021 , to get the full gruvbox experience
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_hls_cursor='purple'
let g:gruvbox_invert_selection=0
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
let g:gruvbox_italicize_comments=1

colorscheme gruvbox

set guifont=Hack\ Nerd\ Font\ Complete\ 11



" ------------------------------------------------------------------
" RIPGREP CONFIGURATION
" ------------------------------------------------------------------
if executable('rg')
    let g:rg_derive_root='true'
endif



" ------------------------------------------------------------------
"  CTRL-P CONFIGURATION
" ------------------------------------------------------------------
" ignore searches in ctrlp "
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" ag is fast enough that CtrlP doesn't need to cach "
" let g:ctrlp_use_caching = 0



" -----------------------------------
" YOUCOMPLETEME CONFIGURATION
" -----------------------------------
" You can jump to functions or definitions that are located in different files by having your cursor over the called function
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>



" ------------------------------------------------------------------
" LIGHTLINE CONFIGURATION
" ------------------------------------------------------------------
" check this video https://dev.to/jhooq/how-to-fix-github-permission-denied-publickey-fatal-could-not-read-from-remote-repository-1l5i
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'helloworld' ] ]
      \ },
      \ 'component': {
      \   'helloworld': 'Hello, '. hostname() .'!'
      \ },
      \ }


" Removes the middle parts of the lightline, so it looks like it is see through;  https://github.com/itchyny/lightline.vim/issues/168
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle



" ------------------------------------------------------------------
" FZF CONFIGURATION
" ------------------------------------------------------------------
" remap fzf ':Files' to call the function :Files. FZF to search in cwd or child directories
nnoremap <C-p> :Files <CR>
" remap fzf ':Buffers' function so we can access whichever files are in our buffer
nnoremap <C-b> :Buffers <CR>



" ------------------------------------------------------------------
" NERDTree CONFIGURATION / VIM DEV-ICONS
" ------------------------------------------------------------------
" verticalsplit a window and open the NERDTree, then resize it
"nnoremap <leader>nw :vnew <bar> :Ex <bar> :vertical resize 90<CR> ----- " This line has been improved with the NERDTree plugin
nnoremap <leader>nw :NERDTree <bar> :vertical resize 90<CR>

" The icons do not have brackets around them anymore in NERDTree
let g:webdevicons_conceal_nerdtree_brackets = 1

" nerdtree-symbols
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ' '
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}  " initialise the dictionary here to then add the extensions
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = 'PDF'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['gz'] = ' '
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sh'] = ' '
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = 'TeX'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cpp'] = 'C'

" nerdtree-highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let s:VIMgreen = "8FAA54"
let s:PDFred = "FE405F"
let s:MDblue = "44788E"
let s:TEXlightGreen = "31B53E"
let g:NERDTreeExtensionHighlightColor['vim'] = s:VIMgreen
let g:NERDTreeExtensionHighlightColor['tex'] = s:TEXlightGreen
let g:NERDTreeExtensionHighlightColor['pdf'] = s:PDFred
let g:NERDTreeExtensionHighlightColor['md'] = s:MDblue



" ------------------------------------------------------------------
" VIMTEX CONFIGURATION
" ------------------------------------------------------------------
" Only this makes VimTex autocomplete. Found on ':help VimTex'
" Uses YouCompleteMe
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme



" ------------------------------------------------------------------
" COMFORTABLE MOTION CONFIGURATION
" ------------------------------------------------------------------
"  https://github.com/yuttie/comfortable-motion.vim ; check for default mappings
"  C-d and C-u are used for going up and down. 
"  C-f is for going a full page up, C-b has been remapped to :Buffers. But generally I don't even use these so it does not matter
"  Comfie motion is acive, but the default settings are in use and that's just fine
let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
"                                                                                      __ _       
"                                                                                     / _(_)_ __  
"                                                                                    | |_| | '_ \ 
"                                                                                    |  _| | | | |
"                                                                                    |_| |_|_| |_|

