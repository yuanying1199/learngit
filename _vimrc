".vimrc配置文件
" Author: YPY
" Source: https://github.com/yuanying1199/lightning
" Date: 2017-10-05,2019-07-21
" 参考链接:  https://github.com/chxuan/vimplus
"            https://github.com/amix/vimrc
"            https://github.com/yangyangwithgnu/use_vim_as_ide
"            https://github.com/wklken/vim-for-server


" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" leader
let mapleader = ","
let g:mapleader = ","

" base 通用设置
set nocompatible " 不兼容vi
set autoread " 文件在vim之外修改过，自动重新读入
set autowrite " 设置自动保存
set shortmess=atI
set history=1000
set magic

" syntax
syntax on

" filetype
filetype on " 开启文件类型侦测
filetype plugin on " 根据侦测到的不同类型加载对应的插件
filetype indent on " 自适应不同语言的智能缩进

set noerrorbells " 不让vim发出讨厌的滴滴声noeb
set novisualbell " 去掉输入错误的提示
set visualbell t_vb=
set t_vb=
set tm=500

set backspace=2 " 使用回格键正常处理indent,eol,start等
set whichwrap+=<,>,h,l " 允许backspace和光标键跨越行边界

set report=0 " 告诉我们文件的哪一行被改变过
set autochdir " 自动切换目录到当前文件
set confirm " 在处理未保存或只读文件的时候，弹出确认

set mouse=a " 可以在buffer的任何地方使用鼠标
"set selection=exclusive
set selectmode=mouse,key

" 代码补全
set completeopt=longest,menu
set wildmenu " vim自身命名行模式智能补全
set wildignore=*.o,*~,*.pyc,*.class

" search
set incsearch " 递进搜索
set hlsearch " 高亮搜索结果hls
set ignorecase " 搜索时大小写不敏感
set smartcase

" fold 折叠
"set nofoldenable " 启动vim时关闭折叠代码
"set foldmethod=syntax " 基于缩进或语法进行代码折叠

" Tab键设置
set expandtab " 将制表符扩展为空格
set smarttab " 在行和段开始处使用制表符
set shiftround " Use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4 " 设置编辑时制表符占用空格数
set shiftwidth=4 " 设置格式化时制表符占用空格数
set softtabstop=4 " 让vim把连续数量的空格视为一个制表符

" indent 代码缩进和排版
set autoindent " 设置自动缩进ai
set smartindent " 智能的选择对其方式si


" 临时文件设置
set nobackup " 禁止生成临时文件
set noswapfile
" viminfo files
"set viminfo     ='100,n$HOME/.viminfo


" encoding 编码设置
set ffs=unix,dos,mac
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
set formatoptions+=mB

set langmenu=en_US.UTF-8
set helplang=en " 帮助系统设置为中文
let $LANG='en'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" show
set number " 显示行号nu
set nowrap " 不自动折行
set showcmd " 命令行显示输入的命令         
set showmode " 命令行显示vim当前模式
set cursorline " 高亮显示当前行/列
"set cursorcolumn

set gcr=a:block-blinkon0 " 禁止光标闪烁
set t_ti= t_te= " 退出vim后,内容显示在终端屏幕,可以用于查看和复制
"set t_Co=256 " 开启256色支持,默认是8色

set scrolloff=7 " 至少有7行在光标所在行上下
set showmatch " 高亮显示匹配的括号
set matchtime=2 " 匹配括号高亮的时间（单位是十分之一秒）

set laststatus=2 " 总是显示状态栏
"set ruler " 在状态栏显示行号ru
set statusline=%<[%{S_buf()}B%n]%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
function! S_buf()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

if has('gui_running')
    set guioptions-=T " 禁止显示菜单和工具条           
    set guioptions-=m           
    set guioptions-=l " 禁止显示滚动条
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
endif

" theme 配色方案
try
    colorscheme herald 
catch
    colorscheme desert
endtry
"colorscheme solarized
set background=dark
" 字体设置
if has("win32")
    set guifont=Consolas:h12:cANSI
else
    set guifont=DejaVu\ Sans\ Mono\ 12
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" key map 快捷键设置(无插件)
"""""""""""""""""""""""""""""""""""""""""""""""""""

" 将选中文本块复制至系统剪贴板(selectmode不能开)
vnoremap <leader>y "+y
" 将系统剪贴板内容粘贴至vim
nnoremap <leader>p "+p

" ex mode commands made easy 用于快速进入命令行
nnoremap ; :
" 连续按jk退出插入/命令行/可视模式 jk 替换 Esc
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap jk <Esc>

" select all
map <Leader>sa ggVG
" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]
" select block
nnoremap <leader>v V`}

" Fast saving
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q!<cr>
" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

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
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Close the current buffer
map <leader>bd :bdelete<cr>

" => windows
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" => tabs
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>tt :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>vs :vsplit <c-r>=expand("%:p:h")<cr>/

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

