"my Markdown filetype plugin
"Language: Markdown(ft=markdown)
"Maintainer: lanphon.<lanphon@gmail.com>
"Version: 0.1
"Last Change: 2010/07/21
"
" Only do this when not done yet for this buffer

if exists("b:did_ftplugin")
	finish
endif

setlocal textwidth=80 "设置30个字符就自动换行，仅对英文有效
setlocal fo+=Mm "设置这个之后对中文可以正确断行

"noremap <F8> :!cmd /c c:\Python27\python c:\Python27\scripts\markdown.py %:t -e chinese > %:r.html<CR>
noremap <F8> :!cmd /c c:\Python27\python c:\Python27\scripts\markdown_py %:t -e chinese > %:r.html<CR>
noremap \e  :!cmd /c start ./%:r.html<CR>
