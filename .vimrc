"Pathogen
call pathogen#runtime_append_all_bundles()

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup


"============== Custom scripts ===============
source ~/.vim/after/syntaxcheck.vim


"============== Filetype stuff ===============
filetype plugin on
filetype indent on

"============== Script configs ===============
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Load custom settings
source ~/.vim/startup/color.vim
source ~/.vim/startup/commands.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/settings.vim

" Syntax-specific settings
source ~/.vim/startup/js.vim
source ~/.vim/startup/php.vim
source ~/.vim/startup/vim.vim
source ~/.vim/startup/yaml.vim
source ~/.vim/startup/html.vim
