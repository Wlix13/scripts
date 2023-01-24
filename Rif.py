import os
from pathlib import Path

from dotenv import load_dotenv
from smb.SMBConnection import SMBConnection


if not Path('.env').exists():
    raise FileNotFoundError('.env file not found')

load_dotenv()
USER = os.getenv('USER')
PASSWD = os.getenv('PASSWD')
IP = os.getenv('IP')
try:
    images = Path(os.getenv('IMAGES')).resolve()
    other = Path(os.getenv('OTHER')).resolve()
except TypeError:
    print('Path for IMAGES or OTHER not found in .env file\nYou can add IMAGES and OTHER to .env file now')
    images = Path(input('Path for IMAGES: ')).resolve()
    other = Path(input('Path for OTHER: ')).resolve()
    with open('.env', 'a') as f:
        f.write(f"IMAGES='{images}'\n")
        f.write(f"OTHER='{other}'\n")


class SMB:
    def __init__(self, user, passwd, ip) -> None:
        self.serv = self.connect(user, passwd, ip)
        self.share = '4Tb'
        self.path = 'wlix/'

    def connect(self, user, passwd, ip):
        conn = SMBConnection(user, passwd, 'Rif', ip, is_direct_tcp=True)

        if conn.connect(ip, 445):
            return conn
        else:
            return None

    def folder(self) -> list:
        return self.serv.listPath(self.share, self.path)

    def download_file(self, folder, name) -> None:
        with open(folder / name, 'wb') as f:
            self.serv.retrieveFile(self.share, f'{self.path}/{name}', f)

    def remove(self, name) -> None:
        self.serv.deleteFiles(self.share, f'{self.path}/{name}')


try:
    smb = SMB(USER, PASSWD, IP)
    folder = {i.filename: i for i in smb.folder() if not i.filename.startswith('.')}

    for file in folder:
        file = file.lower()
        if file.endswith('.jpg') or file.endswith('.png'):
            smb.download_file(images, file)
        else:
            smb.download_file(other, file)
        smb.remove(file)

except Exception as e:
    print(e)
