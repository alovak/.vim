set nocompatible
syntax on

"
" set synmaxcol=120

" Setup Vundle + plugins
source ~/.vim/.plugins

set encoding=utf-8
setglobal fileencoding=utf-8

" " Setup pathogen
" runtime bundle/vim-pathogen/autoload/pathogen.vim
" call pathogen#infect()

set belloff=all

" put unnamed register * to clipboard
set clipboard=unnamed

" Enable search-related options
set hlsearch is scs

" read file if it was changed outside Vim
set autoread

filetype on
filetype plugin on
filetype indent on

" autocmd Filetype sh setlocal ts=4 sts=4 sw=4 noexpandtab
" autocmd Filetype php setlocal ts=4 sts=4 sw=4
" autocmd Filetype html setlocal ts=4 sts=4 sw=4
" autocmd BufRead,BufNewFile *.erb set filetype=html

" Use 2 spaces for indentation and replace tabs with spaces in a smart way
" set sw=2 sts=2 et ai
" Show line number and cursor line
" set relativenumber

if !has('gui_running')
  set termguicolors
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  " set t_Co=256
  " let g:solarized_termcolors=256
  "" colorscheme rdark
  " set background=dark
  " colorscheme solarized
  " colorscheme lucius
  " let g:lucius_style = 'dark'
  " let g:lucius_contrast = 'high'
  " let g:lucius_contrast_bg = 'normal'

  " don't delay when you hit esc in terminal vim, this may make arrow keys not
  " work well when ssh'd in
  set ttimeoutlen=5

  " Changing cursor shape per mode
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  if exists('$TMUX')
      " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
      let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
      let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
      autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
  else
      let &t_SI .= "\<Esc>[4 q"
      let &t_EI .= "\<Esc>[2 q"
      autocmd VimLeave * silent !echo -ne "\033[0 q"
  endif
else
  " gui options
  set guioptions=
  " set lines=50 columns=800
  set lines=31 columns=110
  " set guifont=Monaco:h14
  " set guifont=Monaco\ for\ Powerline:h14
  set guifont=Monaco:h16
  " set guifont=Fira\ Code:h16
  " set cursorline
  "" color rdark
endif


" colorscheme onehalflight
colorscheme onehalfdark
" colorscheme tender
"

" highlight 80 column
" set colorcolumn=100
" set textwidth=81
set nowrap
set noswapfile
" set cursorline


" allow to hide modified buffers when open new file in window
set hidden

" let last window to always have a status line
set laststatus=2

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" use russian only in insert mode
" CTRL-^ to toggle between keymaps
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

let mapleader = ","


"nerd commenter
let NERDSpaceDelims = 1

"ctrlp settings
let g:ctrlp_custom_ignore = '\.git$\|\child\/node_modules\|\.hg$\|\.svn$|\.*\|tmp$\|solr$\|doc$'
let g:ctrlp_prompt_mappings = { 'AcceptSelection("h")': ['<c-o>'] }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_working_path_mode = ''
let g:ctrlp_working_path_mode = 'ra'

let g:vimwiki_list = [{'path': '~/Documents/vimwiki'}]

au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.md.erb set filetype=markdown.eruby
" au BufRead,BufNewFile * set relativenumber
" au BufRead,BufNewFile * set noballooneval

" create directory when saving new file
au BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')
au BufWinEnter * :hi LustySelected guifg=#fcaf3e ctermfg=208

" highlight whitespace
" au BufWinEnter * :match WhiteSpace /\s$/

" hl rabl as ruby
au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.todo set filetype=todo

" turn off cursor keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" mappings

" Delete buffer
map ,db :bdelete!<CR>

"F2 - qwick save
nmap <F2> :w!<cr>
vmap <F2> <esc>:w!<cr>v
imap <F2> <esc>:w!<cr>a

map <leader>s :w!<cr>

" yank all buffer
map <leader>ya :%y *<cr>

" edit and apply .vimrc
" nmap ,s :source ~/.vim/.vimrc
nmap ,vv :e ~/.vim/.vimrc<cr>
nmap ,vs :e ~/.vim/.vimrc<cr>

map <leader>n :nohlsearch<cr>
map <Leader>co :copen<CR>
map <leader>gs :Gstatus<cr>
map <leader>f :LustyFilesystemExplorer<cr>
map <leader>r :LustyFilesystemExplorerFromHere<cr>
map <leader>b :LustyBufferExplorer<cr>
map <leader>g :LustyBufferGrep<cr>
map <leader>e :Explore<cr>

function! GemHome()
  let result = system("gem environment | grep -m 1 -e '- /.*/gems/' | awk '{printf \"%s\", $2}'")
  return result
endfunction

function! CurrentPath()
  let result = system("pwd")
  return result
endfunction

map <leader>gg :execute "LustyFilesystemExplorer" . GemHome() . "/gems" <CR>
map <leader>gt :execute "!ctags -f .tags --languages=-javascript -R " . CurrentPath() <CR>

set tags=.tags;/

" tagbar
nmap <leader>t :TagbarToggle<CR>

vmap <F2> <esc>:w!<cr>v
imap <F2> <esc>:w!<cr>a

" use leader instead ctrl to work with windows
map <leader>w <C-W>
nmap <S-F2> <esc>:W<cr>

" stop auto indenting
set pastetoggle=<F3>

" Tabular patterns
" for Cucumber features
" nmap <Leader>a  :Tabularize /^[ ]*[^ ]*\zs /r0c0l0<CR>
" vmap <Leader>a  :Tabularize /^[ ]*[^ ]*\zs /r0c0l0<CR>
" nmap <Leader>a= :Tabularize /=/l1c1l0<CR>
" vmap <Leader>a= :Tabularize /=/l1c1l0<CR>
" nmap <Leader>ah :Tabularize /=><CR>
" vmap <Leader>ah :Tabularize /=><CR>
" map <Leader>an :Tabularize/\w:\zs/l0l1<CR>

" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

" redraw window when gain access to get rid of text artifacts
" :au FocusGained * :redraw!
au FocusGained,BufEnter * :redraw!

" set nolazyredraw
set lazyredraw
" set lazyredraw
" set scrolloff=3 " show context above/below cursorline
set scrolloff=3 " show context above/below cursorline

vmap <Leader>cc  <Plug>Commentary
nmap <Leader>cc  <Plug>CommentaryLine
nmap <Leader>cu <Plug>CommentaryUndo

nmap <Leader>yf :let @f = expand("%:t")<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap <expr> ]p 'p' . '`[' . strpart(getregtype(), 0, 1) . '`]' . '=' . '<CR>'

" map <F9>    :Dispatch<CR>
" map <F10>    :Start<CR>
map <F1> <Esc>
map! <F1> <Esc>

let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-snippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:rspec_command = "Dispatch rspec {spec}"
map <F9> :call RunCurrentSpecFile()<CR>
map <F8> :call RunNearestSpec()<CR>
" map <Leader>rl :call RunLastSpec()<CR>
map <F7>ra :call RunAllSpecs()<CR>

" set wrap for location list
autocmd FileType qf setlocal wrap
let g:vroom_use_dispatch = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_test_unit_command = 'rake '


" folding
" do not fold anything by default
" set foldlevelstart=99
" set foldmethod=manual
" set foldmethod=syntax
  
" fix background color issue in tmux
set t_ut=


" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" let NERDTreeAutoDeleteBuffer = 1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" map <Leader>qo :NERDTreeToggle<CR>
" map <Leader>qf :NERDTreeFocus<CR>

" show row,col
" set ruler
set number

nmap cp :let @" = expand("%")

" let ruby_fold = 1
" let ruby_foldable_groups = 'def class do'

" autocmd BufWritePost * GitGutter
" nmap <leader>tt <Plug>VimwikiToggleListItem
" nmap <leader>to :new ~/Documents/vimwiki/todo.wiki<cr>

map <Leader>ts :call RunNearestSpec()<CR>
map <Leader>tl :call RunLastSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>
set noshowmatch

autocmd FileType go map <leader>tf  <Plug>(go-test)
autocmd FileType ruby map <leader>tf  :call RunCurrentSpecFile()<CR>

set wildignore+=.DS_Store

let g:netrw_altv=1
let g:netrw_winsize = 80

let g:go_fmt_command = "goimports"
map <C-n> :NERDTreeToggle<CR>

" let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

set noshowmode

let g:deoplete#enable_at_startup = 1

map <Leader>ts :call RunNearestSpec()<CR>

imap <C-x><C-s> <esc>:GoInfo<cr>a

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/bundle/vim-go/gosnippets/UltiSnips']

let g:go_addtags_transform = 'camelcase'
let g:go_debug = ['shell-commands']
