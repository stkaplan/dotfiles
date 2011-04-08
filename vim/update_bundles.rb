#!/usr/bin/env ruby

git_bundles = [
# Easy commenting file many file types
  "git://github.com/scrooloose/nerdcommenter.git",
# File explorer tree view
  "git://github.com/scrooloose/nerdtree.git",
# Support Textmate-style snippets
  "git://github.com/garbas/vim-snipmate.git",
# Dependency for vim-snipmate
  "git://github.com/tomtom/tlib_vim.git",
# Dependency for vim-snipmate
  "git://github.com/MarcWeber/vim-addon-mw-utils.git",
# Wrapper for git commands
  "git://github.com/tpope/vim-fugitive.git",
# Syntax highlighting for Markdown
  "git://github.com/tpope/vim-markdown.git",
# Easy manipulation of parentheses, brackets, etc.
  "git://github.com/tpope/vim-surround.git",
# Allow repeating of commands from vim-surround with .
  "git://github.com/tpope/vim-repeat.git",
# Easily switch between source and header files
  "git://github.com/vim-scripts/a.vim.git",
# Add motion to move between words in CamelCaseIdentifiers
  "git://github.com/vim-scripts/camelcasemotion.git",
# Tasklist to display TODOs, FIXMEs, etc in current file
  "git://github.com/vim-scripts/TaskList.vim.git",
# Custom motion for function arguments
  "git://github.com/vim-scripts/argtextobj.vim.git",
]

vim_org_scripts = [
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")
if !File.directory?(bundles_dir)
  FileUtils.mkdir(bundles_dir)
end

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end
