VCS ROOT
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin determines the root directory of the project that the current
buffer belongs to by querying the version control system (VCS). Git,
Mercurial, and Subversion are supported as well as manually registered
directories. Customizations and other plugins can then access this information
via VcsRoot#Root().

SEE ALSO                                                                     \*

USAGE
------------------------------------------------------------------------------

    :VcsRoot                Print the root of the repository the current buffer is
                            in.

    :RootSet {dir}          Set the repository root for the current buffer to
                            {dir}, and also apply this to any new or existing
                            buffer that is below {dir}.

    :RootStore {dir}
                            Like :RootSet, but additionally store the root {dir}
                            permanently (in g:VcsRoot_RootStoreFilespec).

    :RootUnstore {dir}      Remove {dir} from the persistently stored roots.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at https://github.com/inkarkat/vim-VcsRoot
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim VcsRoot*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.042 or
  higher.
- Requires the vcscommand.vim plugin ([vimscript #90](http://www.vim.org/scripts/script.php?script_id=90)), version 1.99 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

To change the default location where :RootStore persists the manually set
roots:

    let g:VcsRoot_RootStoreFilespec = $HOME . '/.vimroots'

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-VcsRoot/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### GOAL
First published version.

##### 0.01    21-May-2018
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2018-2025 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
