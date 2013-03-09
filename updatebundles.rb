#!/usr/bin/env ruby

#!/usr/bin/env ruby

# from https://gist.github.com/593551

vim_command = '/usr/bin/vim'
git_command = 'git'
hg_command = '/usr/local/Cellar/python/2.7/bin/hg'

# Git Plugins
# Each plugin can be configured thusly:
#
# URL: The plugin location. This supports three types:
# - git : a git plugin. Mostly on github.com?
# Example: ["git://github.com/sjl/gundo.vim.git"],
# ---
# You can supply 'true' to instruct at the end of the array
# to leave the .git folder in place (to pull/commit things)
# - mercurial : an hg plugin. Probably bitbucket.org?
# Example: ["hg://bitbucket.org/ns9tks/vim-fuzzyfinder"],
# - vim : a vim.org hosted plugin.
# Example: ["vim://align-294", "10110"],
# ---
# The first string is the name of the plugin.
# The second string corresponds to the # (URL?src_id) you see
# for the specific version you wanna download. For instance:
#
# For the script: http://www.vim.org/scripts/script.php?script_id=30
# The latest version is 1.13, and the src_id of the link is
# http://www.vim.org/scripts/download_script.php?src_id=9196
# so 9196 is what I'd put here.
#
# lambda (optional): you can supply a lambda function at the end of any array
# to do any post cleanup/install action.. The directory you are currently in
# is the bundle/<name> (that you provided here).
#

bundles = [
  ["git://github.com/Rip-Rip/clang_complete.git", true],
  ["git://github.com/ghewgill/vim-scmdiff.git", true],
  ["git://github.com/kevinw/pyflakes-vim.git", true],
  ["git://github.com/msanders/snipmate.vim.git", true],
  ["git://github.com/scrooloose/nerdcommenter.git", true],
  ["git://github.com/scrooloose/nerdtree.git", true],
  ["git://github.com/timcharper/textile.vim.git", true],
  ["git://github.com/tpope/vim-cucumber.git", true],
  ["git://github.com/tpope/vim-fugitive.git", true],
  ["git://github.com/tpope/vim-git.git", true],
  ["git://github.com/tpope/vim-haml.git", true],
  ["git://github.com/tpope/vim-markdown.git", true],
  ["git://github.com/tpope/vim-repeat.git", true],
  ["git://github.com/tpope/vim-surround.git", true],
  ["git://github.com/tpope/vim-unimpaired.git", true],
  ["git://github.com/tpope/vim-vividchalk.git", true],
  ["git://github.com/tsaleh/vim-align.git", true],
  ["git://github.com/tsaleh/vim-shoulda.git", true],
  ["git://github.com/tsaleh/vim-tcomment.git", true],
  ["git://github.com/vim-scripts/CTAGS-Highlighting.git", true],
  ["git://github.com/vim-scripts/Command-T.git", true],
  ["git://github.com/vim-scripts/Conque-Shell.git", true],
  ["git://github.com/vim-scripts/CCTree.git", true],
  ["git://github.com/vim-scripts/Doxygen-via-Doxygen.git", true],
  ["git://github.com/vim-scripts/EasyGrep.git", true],
  ["git://github.com/vim-scripts/FuzzyFinder.git", true],
  ["git://github.com/vim-scripts/OmniCppComplete.git", true],
  ["git://github.com/vim-scripts/Project-Browser-or-File-explorer-for-vim.git", true],
  ["git://github.com/vim-scripts/Pydiction.git", true],
  ["git://github.com/vim-scripts/Remove-Trailing-Spaces.git", true],
  ["git://github.com/vim-scripts/SudoEdit.vim.git", true],
  ["git://github.com/vim-scripts/SuperTab-continued..git", true],
  ["git://github.com/vim-scripts/a.vim.git", true],
  ["git://github.com/vim-scripts/autoproto.vim.git", true],
  ["git://github.com/vim-scripts/bandit.vim.git", true],
  ["git://github.com/vim-scripts/cecutil.git", true],
  ["git://github.com/vim-scripts/cmake.vim.git", true],
  ["git://github.com/vim-scripts/cscope-menu.git", true],
  ["git://github.com/vim-scripts/exVim.git", true],
  ["git://github.com/vim-scripts/findstr.vim.git", true],
  ["git://github.com/vim-scripts/grep.vim.git", true],
  ["git://github.com/vim-scripts/maximize.dll.git", true],
  ["git://github.com/vim-scripts/occur.vim.git", true],
  ["git://github.com/vim-scripts/srecord.vim.git", true],
  ["git://github.com/vim-scripts/taglist.vim.git", true],
  ["git://github.com/wgibbs/vim-irblack.git", true],
  ["git://github.com/xolox/vim-easytags.git", true],
  ["git://github.com/xolox/vim-pyref.git", true],
  ["git://github.com/vim-scripts/tComment.git", true],
  ["git://github.com/slack/vim-l9.git", true],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

trash = ARGV.include?('--trash')

bundles.each do |script|
url = script[0]
puts url
if (url.start_with? 'git')
  dir = url.split('/').last.sub(/\.git$/, '')
if File.exists?(dir)
if !trash
puts " Skipping"
else
FileUtils.rm_rf dir
end
    next
  end
  puts " Unpacking #{url} into #{dir}"
`#{git_command} clone #{url} #{dir}`
if script.size < 2 or not script[1]
puts " Removing .git folder"
  FileUtils.rm_rf(File.join(dir, ".git"))
end
end
if (url.start_with? 'hg')
url = script[0].gsub(/^hg:/,"http:")
dir = url.split('/').last
if File.exists?(dir)
if !trash
puts " Skipping"
else
FileUtils.rm_rf dir
end
next
end
puts " Unpacking #{url} into #{dir}"
`#{hg_command} clone #{url} #{dir}`
if script.size < 2 or not script[1]
puts " Removing .hg folder"
FileUtils.rm_rf(File.join(dir, ".hg"))
end
end
if (url.start_with? 'vim')
name = script[0].gsub(/^vim:\/\//,"")
script_id = script[1]
  if !trash && File.exists?(name)
puts " Skipping"
    next
  end
  puts "Setup & Download #{name}"
  FileUtils.mkdir_p(name)
FileUtils.cd(name)
f = open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}")
local_file = f.meta["content-disposition"].gsub(/attachment; filename=/,"")
if local_file.end_with? 'vim'
FileUtils.mkdir_p(File.dirname("plugin"))
FileUtils.cd("plugin")
end
  puts " Writing #{local_file}"
  File.open(local_file, "w") do |file|
    file << f.read
  end
if local_file.end_with? 'zip'
puts " Unzip"
    %x(unzip #{local_file})
  end
if local_file.end_with? 'vba.gz'
puts " Vimball Gzip"
    %x(gunzip #{local_file})
# launch vim and make it process the vimball the right way:
local_folder = name
unzipped_file = local_file.gsub(/.gz/,"")
system("cd ../.. ; #{vim_command} +\"e bundle/#{local_folder}/#{unzipped_file}|UseVimball ~/.vim/bundle/#{local_folder}\"")
elsif local_file.end_with? 'vba.tar.gz'
puts " Vimball Tar Gzip"
    %x(tar zxf #{local_file})
# launch vim and make it process the vimball the right way:
local_folder = name
unzipped_file = local_file.gsub(/.tar.gz/,"")
system("cd ../.. ; #{vim_command} +\"e bundle/#{local_folder}/#{unzipped_file}|UseVimball ~/.vim/bundle/#{local_folder}\"")
elsif local_file.end_with? 'tar.gz'
puts " Tar Gunzip"
    %x(tar zxf #{local_file})
elsif local_file.end_with? '.gz'
puts " Gunzip"
    %x(gunzip #{local_file})
  end
if local_file.end_with? 'vim'
FileUtils.cd("..")
end
FileUtils.cd("..")
end

# TODO do any custom code.
if script.size == 3
puts " Custom setup"
script[2].call
end
end

# vim:ft=ruby:

