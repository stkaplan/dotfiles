#!/usr/bin/env python
# Downloaded from http://gist.github.com/490016

"""Script that I keep in a Git repository along with my dotfiles. In the
repository, the files don't have the dot prefix so I can see them more easily.
Running the script symlinks all the files to ~/.<filename>, checking allowing
you to cancel if the file exists.
"""

import os
import glob

EXCLUDE = ['install.py', 'dotfile-sync.py']
NO_DOT_PREFIX = ['bin']

def force_remove(path):
    if os.path.isdir(path) and not os.path.islink(path):
        shutil.rmtree(path, False, on_error)
    else:
        os.unlink(path)

def is_link_to(link, dest):
    is_link = os.path.islink(link)
    is_link = is_link and os.readlink(link).rstrip('/') == dest.rstrip('/')
    return is_link

def main():
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    for filename in [file for file in glob.glob('*') if file not in EXCLUDE]:
        dotfile = filename
        if filename not in NO_DOT_PREFIX:
            dotfile = '.' + dotfile
        dotfile = os.path.join(os.path.expanduser('~'), dotfile)
        source = os.path.relpath(filename, os.path.dirname(dotfile))

        # Check that we aren't overwriting anything
        if os.path.exists(dotfile):
            if is_link_to(dotfile, source):
                continue

            response = raw_input("Overwrite file `%s'? [y/N] " % dotfile)
            if not response.lower().startswith('y'):
                print "Skipping `%s'..." % dotfile
                continue

            force_remove(dotfile)

        os.symlink(source, dotfile)
        print "%s => %s" % (dotfile, source)

if __name__ == '__main__':
    main()
