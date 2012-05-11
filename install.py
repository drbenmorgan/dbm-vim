#!/usr/bin/env python

"""install user vimrc file, forwarding to the vimrc for dbm-vim
"""

import subprocess
import platform
import os.path
import time
import shutil


vimrc_template="""\" Minimal vimrc, forwarding to dbm-vim vimrc
\" Generated on : {date}
\" Git commit   : {git_log}
\"
let dbm_vimrc_impl = \"{vimrc_impl}\"
if filereadable( dbm_vimrc_impl )
  exec 'source '.dbm_vimrc_impl
endif
"""


def dbm_check_output(*popenargs, **kwargs):
    """Run command with arguments and return its output as a byte string
    """
    process = subprocess.Popen(stdout=subprocess.PIPE, *popenargs, **kwargs)
    output, unused_err = process.communicate()
    retcode = process.poll()

    if retcode:
        cmd = kwargs.get("args")
        if cmd is None:
            cmd = popenargs[0]
        raise subprocess.CalledProcessError(retcode, cmd)
    
    return output


def vimrc_path():
    """return path to .vimrc file appropriate for running platform
    """
    if platform.system() == 'Windows':
        raise OSError("dbm-vim not currently supported on Windows")

    return os.path.expandvars('$HOME/.vimrc')


def git_log(format_string):
    """return output of git log -n 1 --format:<format_string>
    """
    git_cmd = ['git', 'log', '-n 1']
    git_cmd.append('--format=format:'+format_string)
    return dbm_check_output(git_cmd)


def vimrc_impl():
    """return path to vimrc implementation file

    This should be the base of the source tree.
    """
    dbm_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(dbm_path, 'vimrc')


def make_tempvimrc():
    """create a temporary vimrc for dbm
    """
    template_values = {}
    template_values['date'] = time.strftime('%c')
    template_values['git_log'] = git_log('%H')
    template_values['vimrc_impl'] = vimrc_impl()
    file_content = vimrc_template.format(**template_values)
    
    fname = 'test.vimrc'
    f = open(fname,'w')
    f.write(file_content)
    f.close()
    return fname


def make_backupvimrc():
    """backup user's current vimrc file
    """
    current_vimrc = vimrc_path()
    vimrc_dir = os.path.dirname(current_vimrc)
    vimrc_file = os.path.basename(current_vimrc)
    vimrc_backup = vimrc_file+time.strftime('%d%m%y%H%M%S')+".dbmbak"
    shutil.copy(current_vimrc, os.path.join(vimrc_dir, vimrc_backup))


def main_impl():
    """install a vimrc file pointing to the dbm vim setup.

    Create the actual file contents from a template string.
    Write that content string to a temporary file.
    Backup any existing [._]vimrc file.
    Move the new file into place
    """
    file_to_install = make_tempvimrc()
    make_backupvimrc()
    shutil.copy(file_to_install, vimrc_path())


if __name__ == '__main__':
    main_impl()

