import os

def make_link(source, link_name):
    if not os.path.lexists(link_name):
        os.symlink(source, link_name)

curdir = os.path.dirname(os.path.abspath(__file__))
runtimepath = os.path.expanduser('~/.config/nvim')

source = f'{curdir}/init.lua'
link_name = f'{runtimepath}/init.lua'
make_link(source, link_name)

source = f'{curdir}/lua'
link_name = f'{runtimepath}/lua'
make_link(source, link_name)
