VIM-TODO
========
A simple syntax file for the manipulation of TODO lists.

This project was originally forked from [TaskPaper.VIM](https://github.com/davidoc/taskpaper.vim).

Installation
=============
Unpack the package into your .vim directory.

Or unpack into ~/.vim/bundles if using Pathogen.

Syntax
=======
	# Comment
	- Example Project
		- Sub item 1
		- Sub item 2 @with_tag
		- Sub item 3 [with time]
		- Sub item 4a with deadline @1/1/2030
		- Sub item 4b with Soft deadline S@1/1/2030
		- Sub item 4c with Hard deadline H@1/1/2030
		- Sub item 4d with all types of deadlines @1/1/2030 S@1/1/2030 H@1/1/2030
		! Urgent item
	- Morning meeting
		- Email Joan about project @email [10am]
		# Comment
		- Sub Project [1/2/2014]
			- Sub task
	Another project (this time without a -)
		- Sub item 1
		- Sub item 2


File-type Plugin
=================
The file-type plugin tries to make editing TODO lists in Vim more comfortable.

Vim can complete context names after the '@' using the keyword completion
commands (e.g. Ctrl-X Ctrl-N).

The plugin defines some new mappings:

    \td     Mark task as done
    \tx     Mark task as cancelled
    \tt     Mark task as today
    \tD     Archive @done items
    \tX     Show tasks marked as cancelled
    \tT     Show tasks marked as today
    \t/     Search for items including keyword
    \ts     Search for items including tag
    \tp     Fold all projects
    \t.     Fold all notes
    \tP     Focus on the current project
    \tj     Go to next project
    \tk     Go to previous project
    \tg     Go to specified project
    \tm     Move task to specified project

Note: if `<Leader>` has been changed (e.g. `:let mapleader=",,"`) then its value should be used instead of `\` in the mappings.

Marking a task as done will add the "@done" context tag to the end of the task, and it will be greyed out by the syntax file.

To show all tasks with a particular context tag, type `\ts` and a tag name to search.  If you use the `\ts` command over the desired context tag, the tag name is set as default value.  This will fold all the irrelevant tasks leaving only the tasks in the current context visible.

To fold all top-level projects leaving only the headings visible use the `\tp` command. Standard fold commands can be used to open (`zo`) and close (`zc`) individual projects.

To show all projects and tasks use the `zR` command. This disables folding so that the entire file is expanded.

To go to next or previous project use the `\tj` command or `\tk` command.  To go to a project you specify use the `\tg` command.  You can complete project names with <Tab> on prompt.


Configuration
==============
The plugin supports a number of configuration variables, which can be set in
your .vimrc file.

To change the default date format string used when marking a task complete,
define the `todo_date_format` variable. The format matches your system's
`strftime()` function.

For example, to include the date and time in ISO8601 format:

    let g:todo_date_format = "%Y-%m-%dT%H:%M:%S%z"

To change the default archive project name, define the
`todo_archive_project` variable.  The default value is "Archive".

    let g:todo_archive_project = "Archive"

By default, when you move a task, the cursor will follow that task to its new
location.  To make the cursor stay in it's current location, change the
`todo_follow_move` variable.

    let g:todo_follow_move = 0

If you want to hide done tasks when searching you can change the
`todo_search_hide_done` variable.

    let g:todo_search_hide_done = 1

To set a custom style (colour, bold, etc.) for tags todo_styles variable,
which is a dictionary.

    let g:todo_styles={'wait': 'ctermfg=Blue guifg=Blue', 'FAIL':
'ctermbg=Red guibg=Red'}

See |highlight-args| for a full description of the syntax.


File-type Detection
====================
This package also contains a script to automatically use the TaskPaper file type for all files with the ".todo" extension.


Customize
==========
You can create your own shortcut for tagging.  To define your own shortcut, write settings in ~/.vim/ftplugin/taskpaper.vim or ~/.vimrc.  If you use the .vimrc file, define settings like:

    function! s:todo_setup()
    " Your settings
    nnoremap <buffer> <silent> <Leader>tn
    \    :<C-u>call todo#toggle_tag('next', '')<CR>
    endfunction

    augroup vimrc-todo
    autocmd!
    autocmd FileType todo call s:todo_setup()
    augroup END

To add a tag without argument:

    nnoremap <buffer> <silent> <Leader>tn
    \    :<C-u>call todo#add_tag('next', '')<CR>

To delete a tag:

    nnoremap <buffer> <silent> <Leader>tN
    \    :<C-u>call todo#delete_tag('next', '')<CR>

To toggle a tag:

    nnoremap <buffer> <silent> <Leader>tn
    \    :<C-u>call todo#toggle_tag('next', '')<CR>

To add a tag with an argument:

    nnoremap <buffer> <silent> <Leader>tq
    \    :<C-u>call todo#add_tag('priority')<CR>

You can specify the priority value on prompt.

To delete the priority tag with any argument:

    nnoremap <buffer> <silent> <Leader>tQ
    \    :<C-u>call todo#delete_tag('priority', '')<CR>

To delete only the level 1 of priority tag:

    nnoremap <buffer> <silent> <Leader>tQ
    \    :<C-u>call todo#delete_tag('priority', '1')<CR>

To toggle a tag with an argument:

    nnoremap <buffer> <silent> <Leader>tq
    \    :<C-u>call todo#toggle_tag('priority')<CR>

To update a tag (not delete if the tag exists):

    nnoremap <buffer> <silent> <Leader>tq
    \    :<C-u>call todo#update_tag('priority')<CR>


Licence
========

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


Acknowledgements
=================
Original fork:
Copyright (C) 2007--2012 by David O'Callaghan <david.ocallaghan@cs.tcd.ie>

The initial version of the ToggleDone() function was based on SwitchBox()
from the VimOutliner Checkboxes script written by Noel Henson (available
from <http://www.vimoutliner.org>).

Context folding expression was based on a snippet from Vim Tip 282
(<http://vim.sourceforge.net/tips/tip.php?tip_id=282>).

Thanks are due to a number of contributors who have supplied suggestions
or patches to improve TaskPaper.vim:

 * Alexander Wodniok
   - hint to allow this file to be used as a help file
 * Ben Armstron 
   - various fixes that make the scripts more robust
   - fix to show only complete tag matches
   - include `_` in contexts
 * Huahai Yang 
   - fixed handling of indented tasks
 * Steve Audette
   - suggested change to folding
 * Andreas Kühntopf 
   - display non-tasks as comments
 * Julien Blanchard (https://github.com/julienXX)
   - added ToggleCancelled
 * Robert James Kaes (https://github.com/rjkaes)
   - added todo_date_format
 * Adriano Castro (https://github.com/adrianocastro)
   - use tabs not spaces (noexpandtab)
 * Morgan Sutherland (https://github.com/msutherl)
   - Use <Leader> rather than <LocalLeader>
   - Start new task after <CR>
 * Matt Sacks (https://github.com/mattsa)
   - Optional (date) syntax for @done tasks
   - Add Tag command for add/removing tag
   - Fix lagging space after removing a tag
   - Better syntax 
 * Anyakichi (https://github.com/anyakichi)
   - Add useful functions for users to define his own mappings easily
    - Add, delete, toggle, and update tags
    - Go previous or next project
    - Move projects, tasks and notes to another project
    - Search for keywords or tags with regexp
   - More compatible with HogBaySoftware's TaskPaper
    - Tag to projects and notes not only tasks
    - Shortcut to @today tag
    - Archiving done support
   - Multi-level folding of projects work perfectly
   - Add a new feature to fold only notes
