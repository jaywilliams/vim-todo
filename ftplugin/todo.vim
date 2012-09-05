" plugin to handle the TaskPaper to-do list format
" Language:	Taskpaper (http://hogbaysoftware.com/projects/taskpaper)
" Maintainer:	David O'Callaghan <david.ocallaghan@cs.tcd.ie>
" URL:		https://github.com/davidoc/taskpaper.vim
" Last Change:  2012-02-20

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

" Define a default date format
if !exists('g:todo_date_format')
    let g:todo_date_format = "%Y-%m-%d"
endif

" Define a default archive project name
if !exists('g:todo_archive_project')
    let g:todo_archive_project = "Archive"
endif

" When moving a task, should the cursor follow or stay in the same place
" (default: follow)
if !exists('g:todo_follow_move')
    let g:todo_follow_move = 1 
endif

" Hide @done tasks when searching tags
if !exists('g:todo_search_hide_done')
    let g:todo_search_hide_done = 0 
endif

" Add '@' to keyword character set so that we can complete contexts as keywords
setlocal iskeyword+=@-@

" Tab character has special meaning on TaskPaper
" setlocal noexpandtab

" Change 'comments' and 'formatoptions' to continue to write a task item
setlocal comments=b:-
setlocal fo-=c fo+=rol

" Set 'autoindent' to maintain indent level
setlocal autoindent

" Set up mappings
if !exists("no_plugin_maps") && !exists("no_todo_maps")
    nnoremap <silent> <buffer> <Plug>todoFoldProjects
    \       :<C-u>call todo#fold_projects()<CR>
    nnoremap <silent> <buffer> <Plug>todoFoldNotes
    \       :<C-u>call todo#search('\v^(\s*\|\t+-\s+.*\|.+:)$')<CR>
    nnoremap <silent> <buffer> <Plug>todoFocusProject
    \       :<C-u>call todo#focus_project()<CR>

    nnoremap <silent> <buffer> <Plug>todoSearchKeyword
    \       :<C-u>call todo#search()<CR>
    nnoremap <silent> <buffer> <Plug>todoSearchTag
    \       :<C-u>call todo#search_tag()<CR>

    nnoremap <silent> <buffer> <Plug>todoGoToProject
    \       :<C-u>call todo#go_to_project()<CR>
    nnoremap <silent> <buffer> <Plug>todoNextProject
    \       :<C-u>call todo#next_project()<CR>
    nnoremap <silent> <buffer> <Plug>todoPreviousProject
    \       :<C-u>call todo#previous_project()<CR>

    nnoremap <silent> <buffer> <Plug>todoArchiveDone
    \       :<C-u>call todo#archive_done()<CR>
    nnoremap <silent> <buffer> <Plug>todoShowToday
    \       :<C-u>call todo#search_tag('today')<CR>
    nnoremap <silent> <buffer> <Plug>todoShowCancelled
    \       :<C-u>call todo#search_tag('cancelled')<CR>
    nnoremap <silent> <buffer> <Plug>todoToggleCancelled
    \       :call todo#toggle_tag('cancelled', todo#date())<CR>
    nnoremap <silent> <buffer> <Plug>todoToggleDone
    \       :call todo#toggle_tag('done', todo#date())<CR>
    nnoremap <silent> <buffer> <Plug>todoToggleToday
    \       :call todo#toggle_tag('today', '')<CR>
    nnoremap <silent> <buffer> <Plug>todoMoveToProject
    \       :call todo#move_to_project()<CR>

    nnoremap <silent> <buffer> <Plug>todoNewline
    \       o<C-r>=todo#newline()<CR>
    inoremap <silent> <buffer> <Plug>todoNewline
    \       <CR><C-r>=todo#newline()<CR>

    nmap <buffer> <Leader>tp <Plug>todoFoldProjects
    nmap <buffer> <Leader>t. <Plug>todoFoldNotes
    nmap <buffer> <Leader>tP <Plug>todoFocusProject

    nmap <buffer> <Leader>t/ <Plug>todoSearchKeyword
    nmap <buffer> <Leader>ts <Plug>todoSearchTag

    nmap <buffer> <Leader>tg <Plug>todoGoToProject
    nmap <buffer> <Leader>tj <Plug>todoNextProject
    nmap <buffer> <Leader>tk <Plug>todoPreviousProject

    nmap <buffer> <Leader>tD <Plug>todoArchiveDone
    nmap <buffer> <Leader>tT <Plug>todoShowToday
    nmap <buffer> <Leader>tX <Plug>todoShowCancelled
    nmap <buffer> <Leader>td <Plug>todoToggleDone
    nmap <buffer> <Leader>tt <Plug>todoToggleToday
    nmap <buffer> <Leader>tx <Plug>todoToggleCancelled
    nmap <buffer> <Leader>tm <Plug>todoMoveToProject

    if mapcheck("o", "n") == ''
        nmap <buffer> o <Plug>todoNewline
    endif
    if mapcheck("\<CR>", "i") == ''
        imap <buffer> <CR> <Plug>todoNewline
    endif
endif

let &cpo = s:save_cpo
