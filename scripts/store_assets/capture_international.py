"""Capture one translated listing on our isolated emulator with synthetic backups."""
import argparse
import json
from pathlib import Path
import re
import subprocess
import time

from device import Device

PACKAGE = 'com.appfactory.strick_haekelbuch.dev'
ACTIVITY = PACKAGE + '/com.appfactory.strick_haekelbuch.MainActivity'


class Capture:
    def __init__(self, serial, locale, output, start=1):
        self.d = Device(serial)
        self.start = start
        self.locale = locale
        self.root = output
        self.copy = json.loads((Path(__file__).parent / 'locales' / f'{locale}.json').read_text())
        self.s = json.loads(Path(f'lib/l10n/app_{locale[:2]}.arb').read_text())
        self.width, self.height = 1080, 1920

    def tap(self, key):
        self.d.tap(self.s[key])

    def back(self):
        self.d.run('shell', 'input', 'keyevent', '4')
        time.sleep(.8)

    def wait(self, key, seconds=60):
        deadline = time.monotonic() + seconds
        while time.monotonic() < deadline:
            if self.d.visible(self.s[key]):
                return
            time.sleep(1)
        raise ValueError('UI did not settle: ' + key)

    def tap_node(self, predicate):
        node = next(n for n in self.d.nodes() if predicate(n))
        a,b,c,d = map(int,re.findall(r'\d+',node.get('bounds')))
        self.d.run('shell','input','tap',str((a+c)//2),str((b+d)//2))
        time.sleep(.8)

    def geometry(self, width, height, density):
        self.width, self.height = width,height
        self.d.run('shell','wm','size',f'{width}x{height}')
        self.d.run('shell','wm','density',str(density))
        time.sleep(3)
        subprocess.run(['python3',str(Path(__file__).with_name('device.py')),self.d.serial,'status'],check=True,stdout=subprocess.DEVNULL)

    def home(self):
        # Restart only our synthetic emulator app to reset the navigation stack.
        self.d.run('shell','am','force-stop',PACKAGE)
        self.d.run('shell','am','start','-n',ACTIVITY)
        self.wait('settings')

    def prepare(self):
        d=self.d
        if b'uid=0(' not in d.run('shell','id'):
            try:
                d.run('root')
            except subprocess.CalledProcessError:
                pass  # adbd can close its old socket before returning the reply
            d.run('wait-for-device')
        if b'uid=0(' not in d.run('shell','id'):
            raise ValueError('The isolated emulator must permit root for its region configuration')
        region = self.copy['region']
        if d.run('shell','getprop','persist.sys.locale').decode().strip() != region:
            d.run('shell','setprop','persist.sys.locale',region)
            d.run('shell','stop')
            d.run('shell','start')
        # sys.boot_completed can retain its old value across a framework restart.
        # Wait for the real Settings service, then verify the activity service.
        for _ in range(180):
            try:
                d.run('shell','settings','get','system','accelerometer_rotation')
                d.run('shell','am','get-config')
                d.run('shell','cmd','uimode','night','no')
                d.run('shell','test','-d','/sdcard/Download')
                break
            except subprocess.CalledProcessError:
                time.sleep(1)
        else:
            raise ValueError('Android framework did not become ready')
        d.run('shell','settings','put','system','accelerometer_rotation','0')
        d.run('shell','settings','put','system','user_rotation','0')
        for key in ['window_animation_scale','transition_animation_scale','animator_duration_scale']:
            d.run('shell','settings','put','global',key,'0')
        d.run('shell','pm','grant',PACKAGE,'android.permission.POST_NOTIFICATIONS')
        self.geometry(1080,1920,360)
        backup=Path('build/international-work/demo')/self.locale/'Demo.shbackup'
        for _ in range(30):
            try:
                d.run('push',str(backup),'/sdcard/Download/Demo.shbackup')
                break
            except subprocess.CalledProcessError:
                # A freshly restarted Android can expose the directory before
                # its emulated-storage mount accepts writes.
                time.sleep(2)
        else:
            raise ValueError('Synthetic backup could not be copied to emulator storage')
        self.home()
        self.tap('settings')
        self.d.scroll_to(self.s['restoreBackup'],1080,1920)
        self.tap('restoreBackup')
        time.sleep(2)
        self.restore_from_picker()

    def restore_from_picker(self):
        d = self.d
        # Android file picker. Navigate to Downloads through its navigation drawer.
        if not d.visible('Demo.shbackup'):
            self.tap_node(lambda n:n.get('class')=='android.widget.ImageButton' and n.get('clickable')=='true')
        if not d.visible('Demo.shbackup'):
            self.tap_node(lambda n:'ownload' in (n.get('text','')+n.get('content-desc','')) or n.get('text') in ['Descargas','Téléchargements'])
        d.tap('Demo.shbackup')
        self.wait('backupPassword')
        self.tap_node(lambda n:n.get('class')=='android.widget.EditText')
        d.text('Demo2026')
        self.back()
        self.tap('next')
        self.wait('restoreBackup402')
        self.tap('restore')
        time.sleep(2)
        for _ in range(60):
            if not d.visible(self.s['restoringBackup']):
                break
            time.sleep(1)
        else:
            raise ValueError('Backup restoration did not complete')
        time.sleep(3)
        self.home()
        if not d.visible(self.copy['projects'][0][0]):
            raise ValueError('Localized backup was not restored')

    def project(self):
        self.d.tap(self.copy['projects'][0][0])

    def history(self):
        self.d.scroll_to(self.s['showAllProgressEntries'],self.width,self.height)
        self.tap('showAllProgressEntries')

    def first_entry(self):
        # The first visible history tile is the newest synthetic entry.
        prefix=self.s['recordedOn'].split('{p0}')[0]
        self.tap_node(lambda n:(n.get('content-desc','') or n.get('text','')).startswith(prefix))

    def run(self):
        self.prepare()
        self.capture_screens()

    def capture_screens(self):
        self.geometry(1080,1920,360)
        self.home()
        subprocess.run(['python3',str(Path(__file__).with_name('device.py')),
                        self.d.serial,'status'],check=True,stdout=subprocess.DEVNULL)
        raw=self.root/'raw/phone'
        if self.start <= 3:
            self.d.capture(raw/'01.png')
            self.project()
            self.history()
            self.d.capture(raw/'03.png')
            self.first_entry()
            self.d.scroll_to(self.s['edit'],self.width,self.height)
            self.tap('edit')
            self.d.capture(raw/'02.png')
        if self.start <= 4:
            self.home()
            self.project()
            self.d.scroll_to(self.s['editProjectReminder'],self.width,self.height)
            self.tap('editProjectReminder')
            self.d.scroll_to(self.s['projectReminder'],self.width,self.height)
            self.tap('projectReminder')
            self.d.scroll_to(self.s['standardReminder'],self.width,self.height)
            self.d.capture(raw/'04.png')
        if self.start <= 5:
            self.home()
            self.project()
            self.d.scroll_to(self.s['createReportForProjectHistory'],self.width,self.height)
            self.tap('createReportForProjectHistory')
            self.tap('withCurrentPhotos')
            self.wait('print',120)
            time.sleep(5)
            self.d.capture(raw/'05.png')
        if self.start <= 6:
            self.home()
            self.tap('settings')
            self.d.capture(raw/'06.png')
        self.tablets()
        print('Captured 14 genuine screenshots for '+self.locale,flush=True)

    def tablets(self, only=None):
        for inches,width,height,density in [(7,1920,1200,320),(10,2560,1600,300)]:
            if only is not None and only != inches:
                continue
            self.geometry(width,height,density)
            self.home()
            folder=self.root/f'tablet{inches}'
            self.d.capture(folder/'01-dashboard.png')
            self.tap('settings')
            self.d.capture(folder/'04-backup.png')
            self.home()
            self.project()
            self.history()
            self.d.capture(folder/'02-history.png')
            self.first_entry()
            self.d.capture(folder/'03-reading.png')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('serial')
    parser.add_argument('locale',choices=['de-DE','en-US','es-ES','fr-FR','it-IT','pt-BR'])
    parser.add_argument('output',type=Path)
    parser.add_argument('--phase',choices=['all','prepare','restore','capture'],default='all')
    parser.add_argument('--from-screen',type=int,choices=range(1,8),default=1)
    args=parser.parse_args()
    capture=Capture(args.serial,args.locale,args.output,args.from_screen)
    {'all':capture.run, 'prepare':capture.prepare, 'restore':capture.restore_from_picker,
     'capture':capture.capture_screens}[args.phase]()


if __name__=='__main__':
    main()
