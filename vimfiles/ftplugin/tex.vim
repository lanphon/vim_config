"my TeX filetype plugin
"Language: TeX(ft=tex)
"Maintainer: lanphon.<lanphon@gmail.com>
"Version: 0.2
"Last Change: 2010/07/21
"
" Only do this when not done yet for this buffer

if exists("b:did_ftplugin")
	finish
endif

setlocal textwidth=80 "设置30个字符就自动换行，仅对英文有效
setlocal fo+=Mm "设置这个之后对中文可以正确断行
"setlocal paste "设置粘贴，设置之后自动换行无效
"setlocal nopaste

"vim自带make所用命令的绑定，请help make查看更多说明
"setlocal makeprg=xelatex\ %<.tex

"alt+f to create a figure environment
noremap <A-f> o\begin{figure}[htbp]<CR>\centering<CR>\includegraphics[width=\textwidth]{}<CR>\caption{}<CR>\label{fig::}<CR>\end{figure}<ESC>kkk$i

"alt+t to create a table environment
noremap <A-t> o\begin{table}[htbp]<CR>\centering<CR>\begin{tabular}{}<CR>\hline<CR>\hline<CR>\hline<CR>\end{tabular}<CR>\caption{}<CR>\label{tab::}<CR>\end{table}<ESC>7k$i

"alt+l to creating a lstlisting environment
noremap <A-l> o\begin{lstlisting}<CR>\end{lstlisting}<ESC>O

"alt+e to create a compactenum environment
noremap <A-e> o\begin{compactenum}<CR>\item <CR>\item <CR>\end{compactenum}<ESC>2k$a

"alt+i to create a compactitem environment
noremap <A-i> o\begin{compactitem}<CR>\item <CR>\item <CR>\end{compactitem}<ESC>2k$a

"alt+d to create a compactdesc environment
noremap <A-d> o\begin{compactdesc}<CR>\item[] <CR>\item[] <CR>\end{compactdesc}<ESC>2k$hi

