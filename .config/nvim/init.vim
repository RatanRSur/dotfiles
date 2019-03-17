call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug 'prendradjaja/vim-vertigo'
Plug 'ciaranm/detectindent'
Plug 'chriskempson/base16-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'christoomey/vim-tmux-navigator'
Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'benekastah/neomake'
Plug 'reedes/vim-lexical'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'sjl/vitality.vim'
Plug 'wellle/targets.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'derekwyatt/vim-scala', { 'for' : 'scala'}
Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'moll/vim-bbye'
Plug 'ap/vim-css-color', { 'for' : 'css'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'craigemery/vim-autotag'
Plug 'fatih/vim-go'
"testing zone
Plug 'SirVer/ultisnips'
call plug#end()
let g:plug_threads = 16


set undofile
set undodir=~/.vim/undodir
set noswapfile
set splitbelow
set splitright
set number
set relativenumber
set cursorline
set ruler
set mouse=a
set expandtab
set shiftwidth=4
set softtabstop=4
set nosmd   " short for 'noshowmode'
set noerrorbells
set visualbell
set sidescroll=1
set sidescrolloff=3
set breakindent "better breaking
set ignorecase
set smartcase
set virtualedit=block
set inccommand=nosplit
set breakindentopt=shift:2
let &showbreak='⤷ '       " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
set list                  " show whitespace
set listchars=nbsp:⦸      " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷\     " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
set listchars+=extends:»  " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:« " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•    " BULLET (U+2022, UTF-8: E2 80 A2)
autocmd BufEnter *.go set listchars+=tab:\ \ 
autocmd BufLeave *.go set listchars+=tab:▷\ 
autocmd InsertEnter * set listchars-=trail:•
autocmd InsertLeave * set listchars+=trail:•
autocmd VimEnter,BufEnter,FocusGained,WinEnter * let &colorcolumn=join(range(101, 999), ',')
autocmd VimEnter,BufEnter,FocusGained,WinEnter *.py let &colorcolumn=join(range(80, 999), ',')
autocmd BufLeave,FocusLost,WinLeave * let &colorcolumn=join(range(1,999), ',')
highlight link EndOfBuffer ColorColumn
set formatoptions+=j "smart joining of comments
set nojoinspaces
set wildmode=longest:full,full
set hidden
set foldopen-=search
set foldmethod=syntax
set foldlevel=99
"set foldcolumn=1
""" autoread
set autoread
au FocusGained,BufEnter * :silent! !
"""
set foldtext=MyFoldText()
function! MyFoldText()
    return "▶ ". getline(v:foldstart)
endfunction

let mapleader = "\<Space>" " space leader
" remap stuff with leader
nnoremap <Leader>w :update<CR>
nnoremap <Leader><Leader>w :w!<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader><Leader>q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>d :Bdelete<CR>
nnoremap <Leader>p :bp<CR>

" comment and copy
nnoremap <Leader>cp :let @i=@0<CR>:call NERDComment('n', "yank")<CR>p:let @0=@i<CR>


"search for visually selected test
vnoremap // "iy/<C-R>i<CR>

"stop that stupid window from popping up
map q: :q

" other mappings
nmap Y y$
nmap <silent> <CR> :nohl<CR>
nmap <silent> <BS> 
nnoremap * *N
nnoremap c* *Ncgn

" auto horizontal or vertical help based on window dimensions
function! s:ShowHelp(tag) abort
    if (3*winheight('0')) < winwidth('0') " The 3 is a heuristic
        execute 'vertical help '.a:tag
    else
        execute 'help '.a:tag
    endif
endfunction

command! -nargs=1 H call s:ShowHelp(<f-args>)
cabbrev h H

"vim vertigo stuff
nnoremap <silent> <Leader>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <Leader>j :<C-U>VertigoDown v<CR>
onoremap <silent> <Leader>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <Leader>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <Leader>k :<C-U>VertigoUp v<CR>
onoremap <silent> <Leader>k :<C-U>VertigoUp o<CR>

"cursorline only if focused
augroup highlight_follows_focus
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END
augroup highlight_follows_vim
    autocmd!
    autocmd FocusGained * set cursorline
    autocmd FocusLost * set nocursorline
augroup END

let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml'

"make arrow keys do something useful
nnoremap <silent> <Left> :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>

inoremap <C-c> <Esc>
syntax enable
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
highlight Comment cterm=italic
highlight Search cterm=reverse,underline ctermbg=NONE ctermfg=NONE
highlight Error term=reverse cterm=bold ctermfg=Red ctermbg=None guifg=Red guibg=None
highlight Folded ctermbg=Black
highlight GitGutterChange ctermfg=yellow
highlight GitGutterChangeDelete ctermfg=DarkYellow
highlight! link SpellBad ErrorMsg
highlight! link SpellCap ErrorMsg
highlight! link Identifier Constant
highlight! Macro ctermfg=Green
"match Error /\%121v.\+/

"code beautification
noremap <Leader>a :Autoformat<CR>

" let g:autoformat_verbosemode=1
let g:formatdef_cust_cpp = '"astyle --mode=c --style=java --indent=spaces=4 -xGfpHUxek3W3jOocxyxC98"'
let g:formatters_cpp = ['cust_cpp']
let g:formatdef_cust_c = '"astyle --mode=c --style=java --indent=spaces=4 -fpHUxek3W3jOocxC98"'
let g:formatters_c = ['cust_c']
let g:formatdef_scalafmt = '"scalafmt --config ~/.scalafmt.conf --stdin"'
let g:formatters_scala = ['scalafmt']

let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++11", "-Wextra", "-Wall"]
autocmd! BufWritePost * Neomake "neomake stuff

"trying nice next and Next searching
""""""""""""""""''
function! s:nice_next(cmd)
    let view = winsaveview()
    execute "normal! " . a:cmd
    if view.topline != winsaveview().topline
        normal! zz
    endif
endfunction

nnoremap n :silent! :call <SID>nice_next('n')<cr>
nnoremap N :silent! :call <SID>nice_next('N')<cr>
"""""""""""""""""""''

" don't let Ctrl e scroll past end of file
nnoremap <expr> <c-e> (line('w$') != line('$'))? "\<c-e>" : ''

"go down visually if no count, by line number if count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"lexical stuff
augroup lexical
    autocmd!
    autocmd FileType md call lexical#init()
    autocmd FileType tex call lexical#init()
    autocmd FileType txt call lexical#init()
    autocmd FileType text call lexical#init({'spell':0})
augroup END
let g:lexical#spell_key = '<leader>s'


let g:deoplete#enable_at_startup = 1 " Use deoplete.
autocmd BufReadPost * inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'go': ['~/go/bin/go-langserver'],
    \ 'julia' : ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \   using LanguageServer;
    \   server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
    \   server.runlinter = true;
    \   run(server);
    \   '],
    \ }

let g:rustfmt_autosave = 1
let g:LanguageClient_useVirtualText = 0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>


"fzf
let g:fzf_colors = { 'fg':      ['fg', 'Normal'],
                   \ 'bg':      ['bg', 'Normal'],
                   \ 'hl':      ['fg', 'Comment'],
                   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                   \ 'hl+':     ['fg', 'Statement'],
                   \ 'info':    ['fg', 'PreProc'],
                   \ 'prompt':  ['fg', 'Conditional'],
                   \ 'pointer': ['fg', 'Exception'],
                   \ 'marker':  ['fg', 'Keyword'],
                   \ 'spinner': ['fg', 'Label'],
                   \ 'header':  ['fg', 'Comment'] }
map <Leader>e :FZF<CR>
map <Leader>f :FZF 
map <Leader>b :Buffers<CR>
map <Leader>t :Tags<CR>
set tags=./tags,./.tags,.tags,tag
map <Leader>l :Lines<CR>
map <Leader>` :FZF ~<CR>
map <Leader>% :FZF %:h<CR>
nnoremap <silent> <Leader>v :call fzf#run({'down': '50%', 'sink': 'botright split' })<CR>
nnoremap <silent> <Leader>h :call fzf#run({'right': winwidth('.') / 2, 'sink': 'vertical botright split'})<CR>

if executable('rg')
    nnoremap <Leader>g :Rg<CR>
    let $FZF_DEFAULT_COMMAND='rg
                \ --glob !.git
                \ --glob !undodir
                \ --glob !Library
                \ --glob !Applications
                \ --glob !macports
                \ --hidden -L -l "" 2>/dev/null'
elseif executable('ag')
    nnoremap <Leader>g :Ag<CR>
    let $FZF_DEFAULT_COMMAND='ag
                \ --ignore .git
                \ --ignore undodir
                \ --ignore Library
                \ --ignore Applications
                \ --ignore macports
                \ --hidden -f -g "" 2>/dev/null'
endif

"jump to last opened position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

autocmd! bufwritepost init.vim source % "auto source this file
