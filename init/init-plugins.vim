"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['tags', 'airline', 'nerdtree', 'ale', 'echodoc']
	let g:bundle_group += ['vim-trailing-whitespace', 'defx']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------
Plug 'Yggdroot/indentLine'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/a.vim'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'lambdalisue/fern.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'p00f/clangd_extensions.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in you"r statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'arkav/lualine-lsp-progress'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lewis6991/spellsitter.nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'tanvirtin/monokai.nvim'
Plug 'marko-cerovac/material.nvim'
" 全文快速移动，<leader><leader>f{char} 即可触发
"Plug 'easymotion/vim-easymotion'

" 文件浏览器，代替 netrw
"Plug 'justinmk/vim-dirvish'
" 表格对齐，使用命令 Tabularize
"Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'
Plug 'sbdchd/neoformat'
Plug 'haringsrob/nvim_context_vt'

"let g:neoformat_cpp_clangformat = {
"  \ 'exe': 'clang-format',
"  \ 'args': ['--style="{
"  \           BasedOnStyle: LLVM,
"  \           AccessModifierOffset: -2,
"  \           AlignEscapedNewlines: Left,
"  \           AlignOperands : true,
"  \           AlwaysBreakTemplateDeclarations: true,
"  \           BinPackArguments: true,
"  \           BinPackParameters: false,
"  \           BreakBeforeBinaryOperators: NonAssignment,
"  \           Standard: Auto,
"  \           IndentWidth: 2,
"  \           BreakBeforeBraces: Custom,
"  \           BraceWrapping:
"  \              {AfterClass:      false,
"  \              AfterControlStatement: false,
"  \              AfterEnum:       false,
"  \              AfterFunction:   true,
"  \              AfterNamespace:  false,
"  \              AfterObjCDeclaration: false,
"  \              AfterStruct:     false,
"  \              AfterUnion:      false,
"  \              AfterExternBlock: false,
"  \              BeforeCatch:     false,
"  \              BeforeElse:      false,
"  \              IndentBraces:    false,
"  \              SplitEmptyFunction: false,
"  \              SplitEmptyRecord: false,
"  \              SplitEmptyNamespace: false},
"  \           ColumnLimit: 100,
"  \           AllowAllParametersOfDeclarationOnNextLine: false,
"  \           AlignAfterOpenBracket: true}"'],
"  \ 'stdin' : 1,
"  \ 'stderr' : 1,
"\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
"----------------------------------------------------------------------
" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
" 比默认的纯按照字母排序更友好点。
"----------------------------------------------------------------------
function! s:setup_dirvish()
	if &buftype != 'nofile' && &filetype != 'dirvish'
		return
	endif
	if has('nvim')
		return
	endif
	" 取得光标所在行的文本（当前选中的文件名）
	let text = getline('.')
	if ! get(g:, 'dirvish_hide_visible', 0)
		exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
	endif
	" 排序文件名
	exec 'sort ,^.*[\/],'
	let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
	" 定位到之前光标处的文件
	call search(name, 'wc')
	noremap <silent><buffer> ~ :Dirvish ~<cr>
	noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
	autocmd!
	autocmd FileType dirvish call s:setup_dirvish()
augroup END


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 展示开始画面，显示最近编辑过的文件
	" Plug 'mhinz/vim-startify'

	" 一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	" Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	" Plug 't9md/vim-choosewin'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	" Plug 'skywind3000/vim-preview'

	" Git 支持
	Plug 'tpope/vim-fugitive'

	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	" 默认不显示 startify
	" let g:startify_disable_at_vimenter = 1
	" let g:startify_session_dir = '~/.vim/session'

	" 使用 <space>ha 清除 errormarker 标注的错误
	" noremap <silent><space>ha :RemoveErrorMarkers<cr>

	" signify 调优
	let g:signify_vcs_list = ['git', 'svn']
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = g:signify_sign_change

	" git 仓库使用 histogram 算法进行 diff
	" let g:signify_vcs_cmds = {
	"		\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
	""		\}

	" tagbar设置
	let g:tagbar_width=30
	let g:tagbar_ctags_bin="/home/zjf225077/ctags-5.8/bin/ctags"
	nmap <silent> <C-T> :TagbarToggle<CR>
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 快速文件搜索
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  "Plug 'junegunn/fzf.vim'

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	"Plug 'asins/vim-dict'

	" 使用 :FlyGrep 命令进行实时 grep
	"Plug 'wsdjeg/FlyGrep.vim'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	"Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

  " 搜索替换
  "Plug 'brooth/far.vim'
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)
endif

"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
"if index(g:bundle_group, 'airline') >= 0
"	Plug 'vim-airline/vim-airline'
"	Plug 'vim-airline/vim-airline-themes'
"	let g:airline_left_sep = ''
"	let g:airline_left_alt_sep = ''
"	let g:airline_right_sep = ''
"	let g:airline_right_alt_sep = ''
"	let g:airline_powerline_fonts = 0
"	let g:airline_exclude_preview = 1
"	let g:airline_section_b = '%n'
"	let g:airline_theme='deus'
"	let g:airline#extensions#branch#enabled = 0
"	let g:airline#extensions#syntastic#enabled = 0
"	let g:airline#extensions#fugitiveline#enabled = 0
"	let g:airline#extensions#csv#enabled = 0
"	let g:airline#extensions#vimagit#enabled = 0
"endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeDirArrows = 1
	let g:NERDTreeHijackNetrw = 0
	noremap <space>nn :NERDTree<cr>
	noremap <space>no :NERDTreeFocus<cr>
	noremap <space>nm :NERDTreeMirror<cr>
	noremap <space>nt :NERDTreeToggle<cr>
endif

if index(g:bundle_group, 'vim-trailing-whitespace') >= 0
	" vim trailing whitespace
	map <leader><space> :FixWhitespace<cr>
	autocmd BufWritePre *.c :%s/\s\+$//e
	autocmd BufWritePre *.h :%s/\s\+$//e
	autocmd BufWritePre *.cpp :%s/\s\+$//e
endif
"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
