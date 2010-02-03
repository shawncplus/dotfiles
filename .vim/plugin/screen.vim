" Author: Eric Van Dewoestine <ervandew@gmail.com>
" Version: 0.8
"
" Description: {{{
"   This plugin aims to simulate an embedded shell in vim by allowing you to
"   easily convert your current vim session into one running in gnu screen
"   with a split gnu screen window containing a shell, and to quickly send
"   statements/code to whatever program is running in that shell (bash,
"   python, irb, etc.).  Spawning the shell in your favorite terminal emulator
"   is also supported for gvim users or anyone else that just prefers an
"   external shell.
"
"   Currently tested on Linux and Windows (win32 [g]vim and cygwin vim), but
"   should also work on any unix based platform where screen is supported
"   (OSX, BSD, Solaris, etc.).  Note that in my testing of cygwin, invocations
"   of screen were significantly slower and less fluid than on Linux.  The
"   Windows experience is better when using gvim to spawn a cygwin shell
"   running screen.
"
"   Windows Users: Whether you are using gvim or not, you will need cygwin
"   installed with cygwin's bin directory in your windows PATH.
"
"   Commands:
"     :ScreenShell [cmd] - Starts a screen hosted shell performing the
"       following steps depending on your environment.
"
"       When running a console vim on a unix based OS (Linux, BSD, OSX):
"         1. save a session file from your currently running vim instance
"            (current tab only)
"         2. start gnu screen with vim running in it
"         3. load your saved session file
"         4. create a lower gnu screen split window and start a shell, or if
"            g:ScreenShellExternal is set, start an external terminal with
"            screen running.
"         5. if a command was supplied to :ScreenShell, run it in the new
"            shell.
"            Ex. :ScreenShell ipython
"
"         Note: If you are already in a gnu screen session, then only steps
"               4 and 5 above will be run.
"
"       When running gvim:
"         1. start an external terminal with screen running.
"         2. if a command was supplied to :ScreenShell, run it in the new
"            shell.
"            Ex. :ScreenShell ipython
"
"     :ScreenSend - Send the visual selection or the entire buffer contents to
"       the running gnu screen shell window.
"
"     :ScreenQuit - Save all currently modified vim buffers and quit gnu
"       screen, returning you to your previous vim instance running outside of
"       gnu screen
"       Note: :ScreenQuit is not available if you where already in a gnu
"         screen session when you ran :ScreenShell.
"       Note: By default, if the gnu screen session was started by
"         :ScreenShell, then exiting vim will quit the gnu screen session as
"         well (configurable via g:ScreenShellQuitOnVimExit).
"
"     :ScreenShellAttach [session] - Sets the necessary internal variables to allow
"       :ScreenSend invocations to send to the specified screen session.  If
"       no session is provided, then the first session found is used.  If the
"       session is in the "Detached" state, then a new terminal is opened with
"       a new screen instance attached to the session. Attaching to a detached
"       session is not currently supported on windows due to deficiencies in
"       the cygwin version of gnu screen.  Also note, that for screen sessions
"       attached to via this mechanism, :ScreenSend invocations will send the
"       text to the active screen window instead of targeting the 'shell'
"       window when used from :ScreenShell.
"
"   An example workflow may be:
"     Open a python file to work on:
"       $ vim something.py
"
"     Decide you want to run all or pieces of the code in an interactive
"     python shell:
"       :ScreenShell python
"
"     Send code from a vim buffer to the shell:
"       :ScreenSend
"
"     Quit the screen session and return to your original vim session:
"       :ScreenQuit
"         or
"       :qa
"
"   Configuration:
"     - g:ScreenShellHeight (Default: 15): Sets the height of gnu screen
"       region used for the shell.
"     - g:ScreenShellQuitOnVimExit (Default: 1): When non-zero and the gnu
"       screen session was started by this script, the screen session will be
"       closed when vim exits.
"     - g:ScreenShellExternal (Default: 0): When non-zero and not already in a
"       screen session, an external shell will be spawned instead of using a
"       split region for the shell.  Note: when using gvim, an external shell
"       is always used.
"     - g:ScreenShellServerName: If the gnu screen session is started by this
"       plugin, then the value of this setting will be used for the servername
"       arg of the vim instance started in the new gnu screen session (not
"       applicable for gvim users).  The default is 'vim' unless you have
"       g:ScreenShellExternal enabled, in which case, if you still want to
"       restart vim in a screen session with a servername, then simply set
"       this variable in your vimrc.
"     - g:ScreenShellTerminal (Default: ''): When g:ScreenShellExternal is
"       enabled or you are running gvim, this value will be used as the name
"       of the terminal executable to be used.  If this value is empty, a list
"       of common terminals will be tried until one is found.
"
"   Script Integration:
"     To permit integration with your own, or 3rd party, scripts, a funcref is
"     made globally available while the screen shell mode is enabled, allowing
"     you to send your own strings to the attached shell.
"
"     Here are some examples of using this funcref to send some commands to
"     bash:
"       call ScreenShellSend("echo foo\necho bar")
"       call ScreenShellSend('echo -e "foo\nbar"')
"       call ScreenShellSend("echo -e \"foo\\nbar\"")
"
"     Sending a list of strings is also supported:
"       call ScreenShellSend(["echo foo", "echo bar"])
"
"     You can test that the funcref exists using:
"        exists('ScreenShellSend')
"
"   Gotchas:
"     - While running vim in gnu screen, if you detach the session instead of
"       quitting, then when returning to the non-screen vim, vim will complain
"       about swap files already existing.  So try to avoid detaching.
"     - Not all vim plugins support saving state to or loading from vim
"       session files, so when running :ScreenShell some buffers may not load
"       correctly if they are backed by such a plugin.
"
" }}}
"
" License: {{{
"   Software License Agreement (BSD License)
"
"   Copyright (c) 2009
"   All rights reserved.
"
"   Redistribution and use of this software in source and binary forms, with
"   or without modification, are permitted provided that the following
"   conditions are met:
"
"   * Redistributions of source code must retain the above
"     copyright notice, this list of conditions and the
"     following disclaimer.
"
"   * Redistributions in binary form must reproduce the above
"     copyright notice, this list of conditions and the
"     following disclaimer in the documentation and/or other
"     materials provided with the distribution.
"
"   * Neither the name of Eric Van Dewoestine nor the names of its
"     contributors may be used to endorse or promote products derived from
"     this software without specific prior written permission of
"     Eric Van Dewoestine.
"
"   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
"   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
"   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
"   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
"   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
"   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
"   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
"   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
"   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
"   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
"   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" }}}

" Global Variables {{{

  " Sets the height of the gnu screen window used for the shell.
  if !exists('g:ScreenShellHeight')
    let g:ScreenShellHeight = 15
  endif

  " Specifies whether or not to quit gnu screen when vim is closed and the
  " screen session was started via :ScreenShell.
  if !exists('g:ScreenShellQuitOnVimExit')
    let g:ScreenShellQuitOnVimExit = 1
  endif

  " When not 0, open the spawned shell in an external window (not currently
  " supported when running in cygwin).
  if !exists('g:ScreenShellExternal')
    let g:ScreenShellExternal = 0
  endif

  " Specifies a name to be supplied to vim's --servername arg when invoked in
  " a new screen session.
  if !exists('g:ScreenShellServerName')
    let g:ScreenShellServerName = g:ScreenShellExternal ? '' : 'vim'
  endif

  " When g:ScreenShellExternal is set, this variable specifies the prefered
  " shell to use.  If not set, some common terminals will be tried.
  if !exists('g:ScreenShellTerminal')
    let g:ScreenShellTerminal = ''
  endif

" }}}

" Script Variables {{{

  if has('win32') || has('win64') || has('win32unix')
    let s:terminals = ['bash']
  else
    let s:terminals = [
        \ 'gnome-terminal', 'konsole',
        \ 'urxvt', 'multi-aterm', 'aterm', 'mrxvt', 'rxvt',
        \ 'xterm',
      \ ]
  endif

" }}}

" Commands {{{

  if !exists(':ScreenShell')
    command -nargs=? ScreenShell :call <SID>ScreenShell('<args>')
  endif

  if !exists(':ScreenShellAttach')
    command -nargs=? -complete=customlist,s:CommandCompleteScreenSessions
      \ ScreenShellAttach :call <SID>ScreenShellAttach('<args>')
  endif

" }}}

" Autocmds {{{

  " while nice for vim screen window titles, this can kind of screw things up
  " since when exiting vim there could now be more than one screen window with
  " the title 'shell'.
  "if expand('$TERM') =~ '^screen'
  "  augroup vim_screen
  "    autocmd!
  "    autocmd VimEnter,BufWinEnter,WinEnter *
  "      \ exec "silent! !echo -ne '\\ek" . expand('%:t') . "\\e\\\\'"
  "    autocmd VimLeave * exec "silent! !echo -ne '\\ekshell\\e\\\\'"
  "  augroup END
  "endif

" }}}

" s:ScreenShell(cmd) {{{
" Open a split shell.
function! s:ScreenShell(cmd)
  if !executable('screen')
    echoerr 'gnu screen not found'
    return
  endif

  try
    let bootstrap = !has('gui_running') && expand('$TERM') !~ '^screen'

    " if using an external shell without the need to set the vim servername,
    " then don't bootstrap
    if bootstrap
      if g:ScreenShellExternal &&
       \ (g:ScreenShellServerName == '' ||
       \  !has('clientserver') || has('win32') || has('win64'))
        let bootstrap = 0
      endif
    endif

    if bootstrap
      call s:ScreenBootstrap(a:cmd)
    else
      call s:ScreenInit(a:cmd)
    endif
  finally
    " wrapping in a try without catching anything just cleans up the vim error
    " produced by an exception thrown from one of the above functions.
  endtry
endfunction " }}}

" s:ScreenShellAttach(session) {{{
" Attach to an existing screen session.
function! s:ScreenShellAttach(session)
  if !executable('screen')
    echoerr 'gnu screen not found'
    return
  endif

  let sessions = s:GetScreenSessions()
  if a:session != ''
    let session = []
    for s in sessions
      if s[0] == a:session
        let session = s
        break
      endif
    endfor

    if len(session) == 0
      echoerr 'unable to find the gnu screen session "' . a:session . '"'
      return
    endif
  elseif len(sessions) > 0
    if has('win32') || has('win64') || has('win32unix')
      call filter(sessions, 'v:val[1] != "detached"')
    endif
    let session = sessions[0]
  else
    echoerr 'unable to find any gnu screen sessions'
    return
  endif

  if session[1] == 'detached'
    if has('win32') || has('win64') || has('win32unix')
      echoerr 'attaching to a session in the "Detached" state is not ' .
        \ 'supported on windows due to deficiencies in the cygwin version ' .
        \ 'of gnu screen.'
      return
    endif
    let result = s:StartScreenTerminal('-r ' . g:ScreenShellSession)
    if result == '0'
      return
    endif
    if v:shell_error
      echoerr result
    endif
  endif

  let g:ScreenShellSession = session[0]
  if !exists(':ScreenSend')
    command -nargs=0 -range=% ScreenSend :call <SID>ScreenSend(<line1>, <line2>)
    let g:ScreenShellSend = s:ScreenSendFuncRef()
  endif
endfunction " }}}

" s:ScreenBootstrap(cmd) {{{
" Bootstrap a new screen session.
function! s:ScreenBootstrap(cmd)
  try
    let g:ScreenShellBootstrapped = 1
    let g:ScreenShellSession = substitute(tempname(), '\W', '', 'g')

    wa
    let save_sessionoptions = &sessionoptions
    set sessionoptions+=globals
    set sessionoptions-=tabpages
    let sessionfile = substitute(tempname(), '\', '/', 'g')
    exec 'mksession ' . sessionfile

    " when transitioning from windows vim to cygwin vim, the session file
    " needs to be purged of windows line endings.
    if has('win32') || has('win64')
      let winrestcmd = winrestcmd()
      try
        exec '1split ' . sessionfile
        set ff=unix
        exec "%s/\<c-m>$//g"
        wq
      finally
        exec winrestcmd
      endtry
    endif

    " support for taglist
    if exists(':TlistSessionSave') &&
     \ exists('g:TagList_title') &&
     \ bufwinnr(g:TagList_title)
      let g:ScreenShellTaglistSession = sessionfile . '.taglist'
      exec 'TlistSessionSave ' . g:ScreenShellTaglistSession
      exec 'silent! !echo "Tlist | TlistSessionLoad ' .
        \ g:ScreenShellTaglistSession . '" >> "' . sessionfile . '"'
    endif

    let bufend = bufnr('$')
    let bufnum = 1
    while bufnum <= bufend
      if bufnr(bufnum) != -1
        call setbufvar(bufnum, 'save_swapfile', getbufvar(bufnum, '&swapfile'))
        call setbufvar(bufnum, '&swapfile', 0)

        " suppress prompt and auto reload changed files for the user when
        " returning to this vim session
        augroup screenshell_filechanged
          exec 'autocmd! FileChangedShell <buffer=' . bufnum . '>'
          exec 'autocmd FileChangedShell <buffer=' . bufnum . '> ' .
            \ 'let v:fcs_choice = (v:fcs_reason == "changed" ? "reload" : "ask") | ' .
            \ 'autocmd! screenshell_filechanged FileChangedShell <buffer=' . bufnum . '>'
        augroup END
      endif
      let bufnum = bufnum + 1
    endwhile

    " supply a servername when starting vim if supported
    let server = ''
    if has('clientserver') && g:ScreenShellServerName != ''
      let server = '--servername "' . g:ScreenShellServerName . '" '
    endif

    " when transitioning from windows console vim to cygwin vim, we don't know
    " if the cygwin version support clientserver, so error on the safe side
    " (in my environment the cygwin vim doesn't support client server).
    if has('win32') || has('win64')
      let server = ''
    endif

    exec 'silent! !screen -S ' . g:ScreenShellSession .
      \ ' vim ' . server .
      \ '-c "silent source ' . escape(sessionfile, ' ') . '" ' .
      \ '-c "ScreenShell ' . a:cmd . '"'
  finally
    unlet g:ScreenShellBootstrapped

    " if there was an error writing files, then we didn't get far enough to
    " need this cleanup.
    if exists('save_sessionoptions')
      let &sessionoptions = save_sessionoptions
      call delete(sessionfile)

      " remove taglist session file
      if exists('g:ScreenShellTaglistSession')
        call delete(g:ScreenShellTaglistSession)
      endif

      redraw!

      let bufnum = 1
      while bufnum <= bufend
        if bufnr(bufnum) != -1
          call setbufvar(bufnum, '&swapfile', getbufvar(bufnum, 'save_swapfile'))
        endif
        let bufnum = bufnum + 1
      endwhile
    endif
  endtry
endfunction " }}}

" s:ScreenInit(cmd) {{{
" Initialize the current screen session.
function! s:ScreenInit(cmd)
  let g:ScreenShellWindow = 'shell'
  " use a portion of the command as the title, if supplied
  if a:cmd != '' && a:cmd !~ '^\s*vim\>'
    let g:ScreenShellWindow = s:ScreenCmdName(a:cmd)[:15]
  endif

  " when already running in a screen session, never use an external shell
  let external = !exists('g:ScreenShellBootstrapped') &&
        \ expand('$TERM') =~ '^screen' ? 0 : g:ScreenShellExternal
  " w/ gvim always use an external shell
  let external = has('gui_running') ? 1 : external

  if exists('g:ScreenShellBootstrapped') || external
    command -nargs=0 ScreenQuit :call <SID>ScreenQuit(0)
    if g:ScreenShellQuitOnVimExit
      augroup screen_shell
        autocmd!
        autocmd VimLeave * call <SID>ScreenQuit(1)
      augroup END
    endif
  endif

  if !exists(':ScreenSend')
    command -nargs=0 -range=% ScreenSend :call <SID>ScreenSend(<line1>, <line2>)
    let g:ScreenShellSend = s:ScreenSendFuncRef()
    " remove :ScreenShell command to avoid accidentally calling it again.
    delcommand ScreenShell
    delcommand ScreenShellAttach
  endif

  " use screen regions
  if !external
    let result = s:ScreenExec('-X eval ' .
      \ '"split" ' .
      \ '"focus down" ' .
      \ '"resize ' . g:ScreenShellHeight . '" ' .
      \ '"screen -t ' . g:ScreenShellWindow . '" ')

    if !v:shell_error && a:cmd != ''
      let cmd = a:cmd . "\<cr>"
      let result = s:ScreenExec(
        \ '-p ' . g:ScreenShellWindow . ' -X stuff "' . cmd . '"')
    endif

  " use an external terminal
  else
    let g:ScreenShellSession = exists('g:ScreenShellSession') ?
      \ g:ScreenShellSession : substitute(tempname(), '\W', '', 'g')

    if !has('gui_running') && exists('g:ScreenShellBootstrapped')
      let result = s:ScreenExec('-X eval ' .
        \ '"screen -t ' . g:ScreenShellWindow . '" ' . '"other"')

      if !v:shell_error
        let result = s:StartScreenTerminal('-S ' . g:ScreenShellSession . ' -x')

        if !v:shell_error && result != '0' && a:cmd != ''
          let cmd = a:cmd . "\<cr>"
          let result = s:ScreenExec(
            \ '-p ' . g:ScreenShellWindow . ' -X stuff "' . cmd . '"')
        endif
      endif

    else
      if has('win32') || has('win64') || has('win32unix')
        let result = s:StartScreenTerminal('-S ' . g:ScreenShellSession)
        " like, the sleep hack below, but longer for windows.
        sleep 1000m
      else
        let result = s:ScreenExec('-d -m')
        if !v:shell_error && result != '0'
          let result = s:StartScreenTerminal('-r ' . g:ScreenShellSession)
        endif
      endif

      if !v:shell_error && result != '0'
        " Hack, but should be plenty of time to let screen get to a state
        " where it will apply the title command.
        sleep 500m
        let result = s:ScreenExec('-X title ' . g:ScreenShellWindow)

        " execute the supplied command if any
        if !v:shell_error && a:cmd != ''
          let cmd = a:cmd . "\<cr>"
          let result = s:ScreenExec(
            \ '-p ' . g:ScreenShellWindow . ' -X stuff "' . cmd . '"')
        endif
      endif
    endif
  endif

  if v:shell_error
    echoerr result
  endif
endfunction " }}}

" s:ScreenSend(string or list<string> or line1, line2) {{{
" Send lines to the screen shell.
function! s:ScreenSend(...)
  if a:0 == 1
    let argtype = type(a:1)
    if argtype == 1
      let lines = split(a:1, "\n")
    elseif argtype == 3
      let lines = a:1
    else
      echoe 'ScreenShell: Argument must be a string or list.'
      return
    endif
  elseif a:0 == 2
    if type(a:1) != 0 || type(a:2) != 0
      echoe 'ScreenShell: Arguments must be positive integer line numbers.'
      return
    endif

    let lines = getline(a:1, a:2)
    let mode = visualmode(1)
    if mode != '' && line("'<") == a:1
      if mode == "v"
        let start = col("'<") - 1
        let end = col("'>") - 1
        " slice in end before start in case the selection is only one line
        let lines[-1] = lines[-1][: end]
        let lines[0] = lines[0][start :]
      elseif mode == "\<c-v>"
        let start = col("'<")
        if col("'>") < start
          let start = col("'>")
        endif
        let start = start - 1
        call map(lines, 'v:val[start :]')
      endif
    endif
  else
    echoe 'ScreenShell: Invalid number of arguments for ScreenSend.'
    return
  endif

  let tmp = tempname()
  call writefile(lines, tmp)
  try
    if exists('g:ScreenShellWindow')
      let result = s:ScreenExec(
        \ '-p ' . g:ScreenShellWindow .  ' -X eval ' .
        \ '"msgminwait 0" ' .
        \ '"readbuf ' . tmp . '" ' .
        \ '"at ' . g:ScreenShellWindow . ' paste ." ' .
        \ '"msgminwait 1"')
    else
      let result = s:ScreenExec(
        \ '-X eval ' .
        \ '"msgminwait 0" ' .
        \ '"readbuf ' . tmp . '" ' .
        \ '"paste ." ' .
        \ '"msgminwait 1"')
    endif
  finally
    call delete(tmp)
  endtry

  if v:shell_error
    echoerr result
  endif
endfunction " }}}

" s:ScreenSendFuncRef() {{{
function s:ScreenSendFuncRef()
  let sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_ScreenSendFuncRef$')
  return function(printf('<SNR>%s_ScreenSend', sid))
endfun " }}}

" s:ScreenQuit(onleave) {{{
" Quit the current screen session (short cut to manually quiting vim and
" closing all screen windows.
function! s:ScreenQuit(onleave)
  if exists('g:ScreenShellBootstrapped')
    if !a:onleave
      wa
    endif

    let bufend = bufnr('$')
    let bufnum = 1
    while bufnum <= bufend
      if bufnr(bufnum) != -1
        call setbufvar(bufnum, '&swapfile', 0)
      endif
      let bufnum = bufnum + 1
    endwhile
  else
    command -nargs=? ScreenShell :call <SID>ScreenShell('<args>')
    command -nargs=? -complete=customlist,s:CommandCompleteScreenSessions
      \ ScreenShellAttach :call <SID>ScreenShellAttach('<args>')
    delcommand ScreenQuit
    delcommand ScreenSend
    unlet g:ScreenShellSend
    augroup screen_shell
      autocmd!
    augroup END
  endif

  let result = s:ScreenExec('-X quit')

  if v:shell_error
    if result !~ 'No screen session found'
      echoerr result
    endif
  endif
endfunction " }}}

" s:ScreenExec(cmd) {{{
" Execute a screen command, handling execution difference between cygwin and a
" real unix system.
function! s:ScreenExec(cmd)
  let cmd = 'screen '
  if exists('g:ScreenShellSession')
    let cmd .= '-S ' . g:ScreenShellSession . ' '
  endif
  let cmd .= a:cmd

  if has('win32unix')
    let result = ''
    exec 'silent! !' . cmd
    redraw!
  else " system() works for windows gvim too
    let result = system(cmd)
  endif
  return result
endfunction " }}}

" s:ScreenCmdName(cmd) {{{
" Generate a name for the given command.
function! s:ScreenCmdName(cmd)
  let cmd = substitute(a:cmd, '^\s*\(\S\+\)\s.*', '\1', '')
  " if the command is a path to one, use the tail of the path
  if cmd =~ '/'
    let cmd = fnamemodify(cmd, ':t')
  endif
  return cmd
endfunction " }}}

" s:StartScreenTerminal(screen_args) {{{
function! s:StartScreenTerminal(screen_args)
  let terminal = s:GetTerminal()
  if !s:ValidTerminal(terminal)
    echoerr 'Unable to find a terminal, please set g:ScreenShellTerminal'
    return
  endif

  let screen_cmd = 'screen ' . a:screen_args

  " handle using cygwin bash
  if has('win32') || has('win64') || has('win32unix')
    let result = ''
    let command = 'start "' . terminal . '"'
    if has('win32unix')
      let command = substitute(command, '\', '/', 'g')
      let command = 'cmd /c ' . command
    endif
    let command .= ' --login -c "' . screen_cmd . '"'
    exec 'silent !' . command
    redraw!

  " gnome-terminal needs quotes around the screen call, but konsole and
  " rxvt based terms (urxvt, aterm, mrxvt, etc.) don't work properly with
  " quotes.  xterm seems content either way, so we'll treat gnome-terminal
  " as the odd ball here.
  elseif terminal == 'gnome-terminal'
    let result = system(terminal . ' -e "' . screen_cmd . '" &')

  else
    let result = system(terminal . ' -e ' . screen_cmd . ' -T xterm-256color &')
  endif
  return result
endfunction " }}}

" s:GetScreenSessions() {{{
" Gets a list of screen [session, state] pairs.
function! s:GetScreenSessions()
  let results = split(system('screen -wipe'), "\n")
  call filter(results, 'v:val =~ "(\\w\\+)"')
  call map(results, '[' .
    \ 'substitute(v:val, "^\\s*\\(\\S*\\)\\s\\+(\\w\\+).*", "\\1", ""), ' .
    \ 'tolower(substitute(v:val, "^\\s*\\S*\\s\\+(\\(\\w\\+\\)).*", "\\1", ""))]')
  return results
endfunction " }}}

" s:GetTerminal() {{{
" Generate a name for the given command.
function! s:GetTerminal()
  if g:ScreenShellTerminal == ''
    for term in s:terminals
      if s:ValidTerminal(term)
        let g:ScreenShellTerminal = term
        break
      endif
    endfor
  endif
  return g:ScreenShellTerminal
endfunction " }}}

" s:ValidTerminal(term) {{{
function! s:ValidTerminal(term)
  if a:term == ''
    return 0
  endif

  if has('win32unix')
    if !executable(a:term)
      let term = substitute(a:term, '\', '/', 'g')
      let term = substitute(system('cygpath "' . term . '"'), '\n', '', 'g')
      return executable(term)
    endif
  endif

  return executable(a:term)
endfunction " }}}

" s:CommandCompleteScreenSessions(argLead, cmdLine, cursorPos) {{{
function! s:CommandCompleteScreenSessions(argLead, cmdLine, cursorPos)
  let cmdLine = strpart(a:cmdLine, 0, a:cursorPos)
  let cmdTail = strpart(a:cmdLine, a:cursorPos)
  let argLead = substitute(a:argLead, cmdTail . '$', '', '')

  let sessions = s:GetScreenSessions()
  if has('win32') || has('win64') || has('win32unix')
    call filter(sessions, 'v:val[1] != "detached"')
  endif
  call map(sessions, 'v:val[0]')
  if cmdLine !~ '[^\\]\s$'
    call filter(sessions, 'v:val =~ "^' . argLead . '"')
  endif

  return sessions
endfunction " }}}

" vim:ft=vim:fdm=marker
