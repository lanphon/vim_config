""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim plugin for lanphon
"Maintainter: lanphon.<lanphon@gmail.com>
"Last Change: 2010/12/26
"License: GPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件名称：lanphon.vim
" 文件内容：我自己的vim配置列表
" 作为一个插件放入vimfiles/plugin/目录下即可，不需要对vimrc文件进行任何改动
" linux下可以创建$HOME/.vim/，其下创建plugin文件等
" 创建日期：2010年07月17日		
" License:GPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changelog:	
" 		2010/07/17	first version
" 		2010/12/06	added default filetype setted to txt
" 		2012/11/13	增加一些常用的插件，如csupport, NERDTree，以及加入了单个
" 					C语言编译运行的支持。最重要的是，更新了Monaco字体！选项
" 					选择cMAC而不是cANSI，中文字体就正常多了。另外，增加了一些
" 					比较好看的 配色方案，如solarized, desertEx。加入折行的保
" 					存和恢复支持。
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"防止脚本重复载入
if exists("loaded_lanphon")
	finish
endif
let loaded_lanphon = 1

set nocompatible "非兼容模式
set ruler "设置标尺
set number "设置显示行号
"set vb t_vb = "消除响铃
set nobackup "无备份
set cursorline "高亮显示当前行
"set paste "设置粘贴，设置之后自动换行无效
"set nopaste
"set autoindent cindent cinoptions=g0
"set backspace=indent,eo1,start
set display=lastline
set incsearch "increment search
set tabstop=4 "set how many spaces a tab use, not used to indent
set shiftwidth=4 "set indent shift width
set showmatch
set showcmd "一个完整的命令结束前，在右下角显示这个命令
set hls "高亮显示所有与最后一次搜索目标串相匹配的文本
set autowrite "自动保存，特别是在如next或者make命令之前
set whichwrap=b,s,<,>,[,] "消除vim畏首畏尾的特性
"set list "查看制表符
"set listchars=tab:>-,trail:- "设置制表符显示格式

set lines=40 "初始化时行数
set columns=88 "初始化是列数

set background=dark
"set background=light
"几种我喜欢的配色方案
"colorscheme murphy
"colorscheme koehler
"colorscheme torte
"colorscheme ron
"colo desertEx
colo solarized

"另外一个关于文件编码的设置，从网上抄下来的
"基本完美解决问题了，其他问题尚未发现
set encoding=utf-8
set termencoding=utf-8
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,chinese,cp936
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_cn.utf-8
language messages zh_cn.utf-8

" 新找的500多kB的Monaco字体，特点是窄版，占的行空间减少了。另一个就是字体
" 有cMAC选项，用这个显示中文正常多了。而之前的没有，只能用cANSI，中文显示
" 扁平的，看起来很不舒服。
if has('mac')
	"in MAC, we will use the Manaco directly, and set the size to 12 on RMBP
	set guifont=Monaco:h12 "设置英文字体
elseif has('win32')
	"set guifont=Monaco:h10:cMAC "设置英文字体
	set guifont=Consolas:h11:cANSI
elseif has('win64')
	set guifont=Consolas:h11:cANSI
else
	set guifont=Monaco:h10:cMAC "设置英文字体
endif
"set gfw=幼圆:h10.5:cGB2312 
"
"set spell "设置拼写检查，会在错误单词下游波浪线，将光标放到单词下
"z=就可以得到建议拼写，]s下一个。仅对英文有效。

" Vundle should be used in .vimrc file, or it cannot autoload the vim_scripts
" installed

filetype plugin indent on "打开自动识别文件类型，使用文件类型plugin以及使用缩进定义文本三项智能

"Toggle Menu and Toolbar
"隐藏任务栏
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

"set filetype for .txt
au BufEnter *.txt setlocal ft=txt

"default filetype
let g:do_filetype = 0
au GUIEnter,BufAdd * if expand('<afile>') == "" | let g:do_filetype = 1 | endif
au BufEnter * if g:do_filetype | setf txt | let g:do_filetype = 0 | endif


"inoremap ( ()<ESC>i
"inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {<CR>}<ESC>O
"inoremap } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
"inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i

" refer to ../doc/matlab.txt
source $VIMRUNTIME/macros/matchit.vim

autocmd BufEnter,BufRead,BufNewFile *.m compiler mlint
autocmd BufEnter,BufRead,BufNewFile *.tex compiler xelatex


" set default filetype
" if has no filetype, set filetype to txt
if !did_filetype()
	setlocal ft=txt
endif

set foldmethod=syntax
"manual           手工定义折叠
"indent             更多的缩进表示更高级别的折叠
"expr                用表达式来定义折叠
"syntax             用语法高亮来定义折叠
"diff                  对没有更改的文本进行折叠
"marker            对文中的标志折叠
"
"set vdir=~\view
"au BufWinLeave * silent mkview
"au BufWinEnter {*.*,.*,_vimrc} silent! loadview
"au BufWinEnter *.* silent! loadview
"autocmd BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
"autocmd BufRead     * if expand('%') != '' && &buftype == '' | silent loadview | syntax on | endif

"打开doxygen的高亮
let g:load_doxygen_syntax=1

let g:doxygenToolkit_authorName="ZHU Xinzhao"
let g:doxygenToolkit_briefTag_funcName="yes"
map <F3>a :DoxAuthor
map <F3>f :Dox
map <F3>b :DoxBlock
map <F3>c O/*<ESC>xxi* @brief 

noremap \t :NERDTree<CR><C-W>l


nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
nmap <C-n> :tabnew<CR>
"insert mode, <C-n> is used to complete the words
"imap <C-n> <Esc>:tabnew<CR>

"nmap <C-t> :browse tabnew<CR>
"imap <C-t> <Esc>:browse tabnew<CR>

" search in virtual mode select part
vnoremap <M-/> <Esc>/\%V

map <S-F4> :VimwikiAll2HTML<cr>
map <F4> :Vimwiki2HTML<cr>

