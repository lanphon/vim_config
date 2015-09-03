" ------------------------------------------------------------------------------
"
" Vim filetype plugin file
"
"   Language :  C / C++
"     Plugin :  c_singleCompile.vim 
" Maintainer :  lanphon<lanphon@gmail.com>
" Description:	For single C/C++ file compile and run
" Date		 :	2012.11.11
"
" ------------------------------------------------------------------------------
"
" Only do this when not done yet for this buffer
"

if exists("b:did_Csinglecomile_ftplugin")
  finish
endif
let b:did_Csinglecomile_ftplugin = 1

if(has("win32") || has("win95") || has("win64") || has("win16"))
	let g:iswindows=1
else
	let g:iswindows=0
endif

"单个文件编译
map <F5> :call Do_OneFileMake()<CR>
function! Do_OneFileMake()
	if expand("%:p:h")!=getcwd()
		echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
		return
	endif
	let sourcefileename=expand("%:t")
	if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
		echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
		return
	endif
	let deletedspacefilename=substitute(sourcefileename,' ','','g')
	if strlen(deletedspacefilename)!=strlen(sourcefileename)
		echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
		return
	endif
	if &filetype=="c"
		if g:iswindows==1
			set makeprg=gcc\ -o\ %<.exe\ %\ --std=c99
		else
			set makeprg=gcc\ -o\ %<\ %\ --std=c99
		endif
	elseif &filetype=="cpp"
		if g:iswindows==1
			set makeprg=g++\ -o\ %<.exe\ %\ --std=c++0x
		else
			set makeprg=g++\ -o\ %<\ %\ --std=c++0x
		endif
		"elseif &filetype=="cs"
		"set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
	endif
	if(g:iswindows==1)
		let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
		let toexename=outfilename
	else
		let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
		let toexename=outfilename
	endif
	if filereadable(outfilename)
		if(g:iswindows==1)
			let outdeletedsuccess=delete(getcwd()."\\".outfilename)
		else
			let outdeletedsuccess=delete("./".outfilename)
		endif
		if(outdeletedsuccess!=0)
			set makeprg=make
			echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
			return
		endif
	endif
	execute "silent make"
	set makeprg=make
	execute "normal :"
	if filereadable(outfilename)
		if(g:iswindows==1)
			execute "!".toexename
		else
			execute "!./".toexename
		endif
	endif
	execute "copen"
endfunction

"进行make的设置
map <F6> :call Do_make()<CR>
map <c-F6> :silent make clean<CR>

function! Do_make()
	set makeprg=make
	execute "silent make"
	execute "copen"
endfunction

"-------------------------------------------------------------------------------
" additional mapping : {<CR> always opens a block
"-------------------------------------------------------------------------------
inoremap  <buffer>  {<CR>    {<CR>}<Esc>O
vnoremap  <buffer>  {<CR>   S{<CR>}<Esc>Pk=iB

"-------------------------------------------------------------------------------
" exchange between cpp file and .h file
"-------------------------------------------------------------------------------
noremap <F8> :e %<.cpp<CR>
noremap <F9> :e %<.h<CR>

noremap \r :!cmd -c %<.exe
noremap \m :e Makefile<CR>
