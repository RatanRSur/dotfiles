call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug 'prendradjaja/vim-vertigo'
Plug 'ciaranm/detectindent'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'reedes/vim-lexical'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'sjl/vitality.vim'
Plug 'wellle/targets.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'derekwyatt/vim-scala'
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'moll/vim-bbye'
Plug 'ap/vim-css-color', { 'for' : 'css'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ianding1/leetcode.vim'
call plug#end()
let g:plug_threads = 16


set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
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
au BufRead,BufNewFile *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+
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

" Formatting selected code.
xmap <leader>a  <Plug>(coc-format-selected)
nmap <leader>a  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" let g:autoformat_verbosemode=1
let g:formatdef_cust_cpp = '"astyle --mode=c --style=java --indent=spaces=4 -xGfpHUxek3W3jOocxyxC98"'
let g:formatters_cpp = ['cust_cpp']
let g:formatdef_cust_c = '"astyle --mode=c --style=java --indent=spaces=4 -fpHUxek3W3jOocxC98"'
let g:formatters_c = ['cust_c']
let g:formatdef_scalafmt = '"scalafmt --config ~/.scalafmt.conf --stdin"'
let g:formatters_scala = ['scalafmt']


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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"let g:LanguageClient_autoStart = 1
"let g:LanguageClient_serverCommands = {
    "\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    "\ 'go': ['~/go/bin/go-langserver'],
    "\ 'java': ['/usr/bin/jdtls'],
    "\ 'julia' : ['julia', '--startup-file=no', '--history-file=no', '-e', '
    "\   using LanguageServer;
    "\   server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
    "\   server.runlinter = true;
    "\   run(server);
    "\   '],
    "\ }

autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
autocmd FileType haskell let b:autoformat_autoindent=0

let g:rustfmt_autosave = 1
let g:LanguageClient_useVirtualText = 0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call <SID>show_documentation()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


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
" Search workspace symbols.
nnoremap <silent> <Leader>t  :<C-u>CocList -I symbols<cr>
set tags=./tags,./.tags,.tags,tag,tags
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

let g:leetcode_username='ratan.r.sur@gmail.com'

"jump to last opened position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

autocmd! bufwritepost init.vim source % "auto source this file
