"my plainTeX filetype plugin
"Language: plain TeX(ft=plaintex)
"Maintainer: lanphon.<lanphon@gmail.com>
"Version: 0.2
"Last Change: 2012/11/10
"
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif

"plaintex.vim
"对于某些分离开来的tex文件，vim会认为其文件类型为plaintex，故需要设置自动
"换行功能，但这些文件不需要编译选项

setlocal textwidth=80 "设置30个字符就自动换行，仅对英文有效
setlocal fo+=Mm "设置这个之后对中文可以正确断行
"setlocal paste "设置粘贴，设置之后自动换行无效
"setlocal nopaste

"vim自带make所用命令的绑定，请help make查看更多说明
"setlocal makeprg=xelatex\ %<.tex
