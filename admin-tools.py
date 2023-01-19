#!/usr/bin/python3
from yast import import_module
import_module('UI')
from yast import *
from subprocess import Popen
import os

def choose_module():
    module = None
    header = Header('')
    items = [Item(Id('aduc'), 'Active Directory Users and Computers'),
             Item(Id('adsi'), 'ADSI Edit'),
             Item(Id('dns-manager'), 'DNS'),
             Item(Id('gpmc'), 'Group Policy Management'),
    ]
    dialog = VBox(
        Table(Id('tools'), Opt('notify'), header, items),
        VSpacing(.3),
        Right(HBox(
            PushButton(Id('close'), 'Close'),
        ))
    )
    UI.OpenDialog(Opt('mainDialog'), dialog)
    UI.SetApplicationTitle('Administrative Tools')

    while True:
        ret = UI.WaitForEvent()
        ycpbuiltins.y2error(str(ret))
        if ret['ID'] == 'close':
            break
        else:
            module = UI.QueryWidget('tools', 'Value')
            break
    UI.CloseDialog()

    return module

def run(module):
    Popen(['/usr/sbin/yast2', module]).wait()

if __name__ == "__main__":
    module = choose_module()
    if module:
        run(module)
