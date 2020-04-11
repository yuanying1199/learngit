"==========================================
" vimrc basic (no plugin)
" Author: YPY
" Source: https://github.com/yuanying1199/lightning
" Date: 2017-10-05,2019-07-21,2020-04-10
" Ref:  https://github.com/chxuan/vimplus
"            https://github.com/amix/vimrc
"            https://github.com/yangyangwithgnu/use_vim_as_ide
"            https://github.com/wklken/vim-for-server
"==========================================

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" leader
let mapleader = ","
let g:mapleader = ","

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
filetype plugin on " 根据侦测到的不同类型加载对应的插件
filetype indent on " 自适应不同语言的智能缩进

" base 通用设置
set nocompatible " 不兼容vi
set autoread " 文件在vim之外修改过，自动重新读入
set shortmess=atI

set magic
set nobackup " 禁止生成临时文件
set noswapfile
set noerrorbells " 不让vim发出讨厌的滴滴声noeb
set novisualbell " 去掉输入错误的提示
set visualbell t_vb=

set backspace=2 " 使用回格键正常处理indent,eol,start等
set whichwrap+=<,>,h,l " 允许backspace和光标键跨越行边界

set autochdir " 自动切换目录到当前文件
set confirm " 在处理未保存或只读文件的时候，弹出确认
set report=0

set selectmode=key
set keymodel=startsel

" 代码补全
set completeopt=menu,preview
set wildmenu " vim自身命名行模式智能补全
set wildignore=*.o,*~,*.pyc,*.class

" search
set incsearch " 递进搜索
set hlsearch " 高亮搜索结果hls
set ignorecase " 搜索时大小写不敏感
set smartcase

" indent 代码缩进和排版
set autoindent " 设置自动缩进ai
set smartindent " 智能的选择对其方式si

" fold
set nofoldenable " 启动vim时关闭折叠代码
set foldmethod=syntax " 基于缩进或语法进行代码折叠

" Tab键设置
set expandtab " 将制表符扩展为空格
set smarttab " 在行和段开始处使用制表符
set shiftround " Use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4 " 设置编辑时制表符占用空格数
set shiftwidth=4 " 设置格式化时制表符占用空格数
set softtabstop=4 " 让vim把连续数量的空格视为一个制表符

" encoding 编码设置
set ffs=unix,dos,mac
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
set formatoptions+=mB

" show
set number " 显示行号nu
set nowrap " 不自动折行
set showcmd " 命令行显示输入的命令
set showmode " 命令行显示vim当前模式
set t_ti= t_te= " 退出vim后,内容显示在终端屏幕,可以用于查看和复制

set scrolloff=5 " 至少有7行在光标所在行上下
set showmatch " 高亮显示匹配的括号
set matchtime=2 " 匹配括号高亮的时间（单位是十分之一秒）

set ruler " 在状态栏显示行号ru
set laststatus=2 " 总是显示状态栏
set statusline=%<[%{S_buf()}B%n]%f\ %h%m%r%=%k[%{&ff}][%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
function! S_buf()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

" theme 配色方案
try
    colorscheme ron 
catch
    colorscheme default
endtry
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""
" key map 快捷键设置(无插件)
"""""""""""""""""""""""""""""""""""""""""""""""""""

nmap Y y$
set clipboard+=unnamed
" 将选中文本块复制至系统剪贴板(selectmode不能开)
vnoremap <leader>y "+y
" 将系统剪贴板内容粘贴至vim
nnoremap <leader>p "+p

" ex mode commands made easy
nnoremap ; :
" 连续按jk退出插入/命令行/可视模式 jk 替换 Esc
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap jk <Esc>

" select all
map <leader>sa ggVG
" select block
nnoremap <leader>v V`}

" Fast saving
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><leader> :q!<CR>
" :W sudo saves the file (useful for handling the permission-denied error)
cmap W w !sudo tee % > /dev/null

" Disable highlight when <leader><CR> is pressed
map <silent> <leader>/ :nohls<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

" => buffer
map <leader>l :bnext<CR>
map <leader>h :bprevious<CR>
" Close the current buffer
map <leader>bd :bdelete<CR>

" => windows
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" => tabs
" Useful mappings for managing tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>th :tabp<CR>
map <leader>tl :tabn<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<CR>/
map <leader>vs :vsplit <C-r>=expand("%:p:h")<CR>/

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
nnoremap <F6> :set nu! nu?<CR>
nnoremap <F7> :set list! list?<CR>
nnoremap <F8> :set wrap! wrap?<CR>
" Toggle paste mode on and off
set pastetoggle=<F9>
autocmd InsertLeave * set nopaste

