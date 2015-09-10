" Vim compiler file
" Compiler:         xelatex
" Maintainer:       lanphon <lanphon@gmail.com>
" Latest Revision:  2012.11.10
" Comment:          


if exists("current_compiler")
  finish
endif
let current_compiler = "xelatex"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=xelatex\ %<.tex
