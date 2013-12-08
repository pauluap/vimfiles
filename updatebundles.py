#!/usr/bin/env python

# adaption of the ruby version from https://gist.github.com/593551

import os
import argparse
import shutil
import sys

vim_command = '/usr/bin/vim'
git_command = 'git'
hg_command = 'hg'
svn_command = 'svn'

OS_ALL     = 1
OS_LINUX   = 2
OS_WINDOWS = 3

VC_KEEP    = 1
VC_KILL    = 2
VC_DEFAULT = 3

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
# lambda (optional): you can supply a lambda function at the end of any array
# to do any post cleanup/install action.. The directory you are currently in
# is the bundle/<name> (that you provided here).
#

bundles = [
        {'bundle':"git://github.com/mileszs/ack.vim.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/tpope/vim-pathogen.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/Rip-Rip/clang_complete.git"                               , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/ghewgill/vim-scmdiff.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/scrooloose/nerdtree.git"                                  , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/slack/vim-l9.git"                                         , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/tpope/vim-unimpaired.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/tsaleh/vim-align.git"                                     , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/DoxygenToolkit.vim.git"                       , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/FuzzyFinder.git"                              , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/Remove-Trailing-Spaces.git"                   , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/a.vim.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/bandit.vim.git"                               , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/occur.vim.git"                                , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/taglist.vim.git"                              , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/wgibbs/vim-irblack.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/AutoComplPop.git"                             , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/wincent/Command-T.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/kevinw/pyflakes-vim.git"                                  , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/vim-scripts/pep8.git"                                     , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/davidhalter/jedi-vim.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':True},
        {'bundle':"git://github.com/sontek/rope-vim.git"                                      , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/fs111/pydoc.vim.git"                                      , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/ervandew/supertab.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/Shougo/neocomplcache.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-fugitive.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-surround.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/EasyGrep.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/cmake.vim.git"                                , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/Raimondi/delimitMate.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/xolox/vim-pyref.git"                                      , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/timcharper/textile.vim.git"                               , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-cucumber.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-git.git"                                        , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-haml.git"                                       , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-markdown.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tpope/vim-repeat.git"                                     , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/tsaleh/vim-tcomment.git"                                  , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/CCTree.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/CTAGS-Highlighting.git"                       , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Conque-Shell.git"                             , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Decho.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Doxygen-via-Doxygen.git"                      , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Map-Tools.git"                                , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/OmniCppComplete.git"                          , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Project-Browser-or-File-explorer-for-vim.git" , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/Pydiction.git"                                , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/SudoEdit.vim.git"                             , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/TTrCodeAssistor.git"                          , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/The-NERD-Commenter.git"                       , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/autoproto.vim.git"                            , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/cecutil.git"                                  , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/cscope-menu.git"                              , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/exVim.git"                                    , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/findstr.vim.git"                              , 'keepvc':True , 'os':OS_WINDOWS , 'use':False},
        {'bundle':"git://github.com/vim-scripts/grep.vim.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/lh-cpp-ftplugins.git"                         , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/maximize.dll.git"                             , 'keepvc':True , 'os':OS_WINDOWS , 'use':False},
        {'bundle':"git://github.com/vim-scripts/python_ifold.git"                             , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/srecord.vim.git"                              , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/vim-scripts/tComment.git"                                 , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"git://github.com/xolox/vim-easytags.git"                                   , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"http://lh-vim.googlecode.com/svn/cpp"                                      , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"http://lh-vim.googlecode.com/svn/map-tools"                                , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"http://lh-vim.googlecode.com/svn/mu-template"                              , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"http://lh-vim.googlecode.com/svn/system-tools"                             , 'keepvc':True , 'os':OS_ALL     , 'use':False},
        {'bundle':"http://lh-vim.googlecode.com/svn/vim-lib"                                  , 'keepvc':True , 'os':OS_ALL     , 'use':False}
]

platformMap = {'win32':[OS_ALL, OS_WINDOWS], 'linux2':[OS_ALL, OS_LINUX]}

bundles_dir = os.path.join(os.path.split(os.path.abspath(__file__))[0], 'bundle')

def onerror(func, path, exc_info):
    """
    Error handler for ``shutil.rmtree``.

    If the error is due to an access error (read only file)
    it attempts to add write permission and then retries.

    If the error is for another reason it re-raises the error.

    Usage : ``shutil.rmtree(path, onerror=onerror)``
    """
    import stat
    if not os.access(path, os.W_OK):
        # Is the error an access error ?
        os.chmod(path, stat.S_IWUSR)
        func(path)
    else:
        raise

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Set up Vim plugins')
    parser.add_argument('-t', '--trash', dest='trash', action='store_true', default=False, help='if provided, the individual bundle directory will be deleted before performing further actions')
    parser.add_argument('--nuclear', dest='nuclear', action='store_true', default=False, help='if provided, the entire bundle directory will be deleted before performing further actions')
    parser.add_argument('-u', '--update', dest='update', action='store_true', default=True, help='If provided, all {d}vcs directories are updated.  If there is a change in the status, the directory will be deleted')
    parser.add_argument('-v', '--keepvc', dest='keepvc', action='store_true', default=False, help='if provided, the version control information (e.g. the .svn, .git, etc directories) will be kept regardless of the default behavior')
    parser.add_argument('-k', '--killvc', dest='killvc', action='store_true', default=False, help='if provided, the version control information (e.g. the .svn, .git, etc directories) will be deleted regardless of the default behavior')
    parser.add_argument('-o', '--os', dest='os', choices=['OS_ALL', 'OS_WINDOWS', 'OS_LINUX'], help='Override the OS detection to select which bundle to install')

    args = parser.parse_args()

    if args.keepvc and args.killvc:
        print ('The keepvc and killvc options are mutually exclusive')
        sys.exit(-1)
    else:
        if args.keepvc:
            vcaction = VC_KEEP
        elif args.killvc:
            vcaction = VC_KILL
        else:
            vcaction = VC_DEFAULT

    if args.os:
        platform = globals()[args.os]

        if OS_ALL == platform:
            platform = [OS_ALL, OS_WINDOWS, OS_LINUX]
        else:
            platform = [platform]
    else:
        try:
            platform = platformMap[sys.platform]
        except KeyError:
            print('{0} is an unsupported platform'.format(sys.platform))
            sys.exit(-1)

    if args.nuclear and os.path.exists(bundles_dir):
        shutil.rmtree(bundles_dir, onerror=onerror)

    if not os.path.exists(bundles_dir):
        os.mkdir(bundles_dir)

    for item in bundles:
        print(item['bundle'])
        if item['os'] not in platform:
            print('Not installed for this platform.  Skipping..\n')
        else:
            parts = item['bundle'].split('/')
            if 'git:' in parts[0]:
                dir = parts[-1].split('.git')[0]

                if args.trash and os.path.exists(os.path.join(bundles_dir, dir)):
                    shutil.rmtree(os.path.join(bundles_dir, dir), onerror=onerror)

                url = item['bundle']

                if args.update and os.path.exists(os.path.join(bundles_dir, dir)) and not item['use']:
                    print('Removing selection..\n')
                    shutil.rmtree(os.path.join(bundles_dir, dir), onerror=onerror)
                elif not item['use']:
                    print('Not selected. Skipping..\n')
                else:
                    if os.path.exists(os.path.join(bundles_dir, dir)):
                        command = '{0} pull'.format(git_command)
                        os.chdir(os.path.join(bundles_dir, dir))
                        os.system(command)
                        os.chdir(bundles_dir)
                    else:
                        command = '{0} clone {1} {2}'.format(git_command, url, os.path.relpath(os.path.join(bundles_dir, dir)))
                        os.system(command)


                    if vcaction == VC_KILL:
                        shutil.rmtree(os.path.join(bundles_dir, dir, '.git'), onerror=onerror)
                    elif vcaction == VC_DEFAULT:
                        try:
                            if not item['keepvc']:
                                shutil.rmtree(os.path.join(bundles_dir, dir, '.git'))
                        except KeyError:
                            pass
            elif 'hg:' in parts[0]:
                dir = parts[-1]
                if args.trash and os.path.exists(os.path.join(bundles_dir, dir)):
                    shutil.rmtree(os.path.join(bundles_dir, dir))

                if args.update and os.path.exists(os.path.join(bundles_dir, dir)) and not item['use']:
                    print('Removing selection..\n')
                    shutil.rmtree(os.path.join(bundles_dir, dir), onerror=onerror)
                elif not item['use']:
                    print('Not selected. Skipping..\n')
                else:
                    os.system('{0} clone {1} {2}'.format(hg_command, item['bundle'].replace('hg', 'http'), dir))

                    if vcaction == VC_KILL:
                        shutil.rmtree(os.path.join(bundles_dir, dir, '.hg'))
                    elif vcaction == VC_DEFAULT:
                        try:
                            if not item['keepvc']:
                                shutil.rmtree(os.path.join(bundles_dir, dir, '.hg'))
                        except KeyError:
                            pass
            elif 'http:' in parts[0]:
                if 'googlecode' in item['bundle']:
                    dir = parts[-1]

                    if args.update and os.path.exists(os.path.join(bundles_dir, dir)) and not item['use']:
                        print('Removing selection..\n')
                        shutil.rmtree(os.path.join(bundles_dir, dir), onerror=onerror)
                    elif not item['use']:
                        print('Not selected. Skipping..\n')
                    else:
                        url = item['bundle'] + '/trunk'

                        if os.path.exists(os.path.join(bundles_dir, dir)):
                            command = '{0} up'.format(svn_command)
                            os.chdir(os.path.join(bundles_dir, dir))
                            os.system(command)
                            os.chdir(bundles_dir)
                        else:
                            command = '{0} checkout {1} {2}'.format(svn_command, url, os.path.relpath(os.path.join(bundles_dir, dir)))
                            os.system(command);

                        if vcaction == VC_KILL:
                            shutil.rmtree(os.path.join(bundles_dir, dir, '.svn'), onerror=onerror)
                        elif vcaction == VC_DEFAULT:
                            try:
                                if not item['keepvc']:
                                    shutil.rmtree(os.path.join(bundles_dir, dir, '.svn'))
                            except KeyError:
                                pass
            elif 'vim:' in parts[0]:
                print('vim.org / vimball support not implemented yet')


# TODO XXX Finish implementation - add vim:// and vimball support
# bundles.each do |script|
# url = script[0]
# puts url
# if (url.start_with? 'vim')
# name = script[0].gsub(/^vim:\/\//,"")
# script_id = script[1]
#   if !trash && File.exists?(name)
# puts " Skipping"
#     next
#   end
#   puts "Setup & Download #{name}"
#   FileUtils.mkdir_p(name)
# FileUtils.cd(name)
# f = open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}")
# local_file = f.meta["content-disposition"].gsub(/attachment; filename=/,"")
# if local_file.end_with? 'vim'
# FileUtils.mkdir_p(File.dirname("plugin"))
# FileUtils.cd("plugin")
# end
#   puts " Writing #{local_file}"
#   File.open(local_file, "w") do |file|
#     file << f.read
#   end
# if local_file.end_with? 'zip'
# puts " Unzip"
#     %x(unzip #{local_file})
#   end
# if local_file.end_with? 'vba.gz'
# puts " Vimball Gzip"
#     %x(gunzip #{local_file})
# # launch vim and make it process the vimball the right way:
# local_folder = name
# unzipped_file = local_file.gsub(/.gz/,"")
# system("cd ../.. ; #{vim_command} +\"e bundle/#{local_folder}/#{unzipped_file}|UseVimball ~/.vim/bundle/#{local_folder}\"")
# elsif local_file.end_with? 'vba.tar.gz'
# puts " Vimball Tar Gzip"
#     %x(tar zxf #{local_file})
# # launch vim and make it process the vimball the right way:
# local_folder = name
# unzipped_file = local_file.gsub(/.tar.gz/,"")
# system("cd ../.. ; #{vim_command} +\"e bundle/#{local_folder}/#{unzipped_file}|UseVimball ~/.vim/bundle/#{local_folder}\"")
# elsif local_file.end_with? 'tar.gz'
# puts " Tar Gunzip"
#     %x(tar zxf #{local_file})
# elsif local_file.end_with? '.gz'
# puts " Gunzip"
#     %x(gunzip #{local_file})
#   end
# if local_file.end_with? 'vim'
# FileUtils.cd("..")
# end
# FileUtils.cd("..")
# end
#
# # TODO do any custom code.
# if script.size == 3
# puts " Custom setup"
# script[2].call
# end
# end
#

