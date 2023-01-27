import os
from pathlib import Path
import stat

import paramiko
from dotenv import load_dotenv


if not Path('.env').exists():
    raise FileNotFoundError('.env file not found')

load_dotenv()
USER = os.getenv('USER')
IP = os.getenv('IP')
SFTPPORT = int(os.getenv('SFTPPORT'))

try:
    images = Path(os.getenv('IMAGES')).resolve()
    other = Path(os.getenv('OTHER')).resolve()
except TypeError:
    print('Path for IMAGES or OTHER not found in .env file\nYou can add IMAGES and OTHER to .env file now')
    images = Path(input('Path for IMAGES: ')).resolve()
    other = Path(input('Path for OTHER: ')).resolve()
    with open('.env', 'a') as f:
        f.write(f"IMAGES = '{images}'\n")
        f.write(f"OTHER = '{other}'\n")


class SFTP:
    def __init__(self, user: str, ip: str, port: int, key: Path):
        if not Path.exists(key):
            raise FileNotFoundError(f'Key {key} not found')

        self.key = paramiko.RSAKey(filename=key)
        self.sftp = None
        self.user = user
        self.ip = ip
        self.port = port

    def _initialize(self, user: str, ip: str, port: int, key: paramiko.RSAKey):
        """
        Initialize sftp connection to server
        """
        self.transport = paramiko.Transport((ip, port))
        self.transport.connect(username=user, password=None, pkey=key)
        self.sftp = self.transport.open_sftp_client()

    def _disconnect(self):
        """
        Close sftp connection
        """
        self.sftp.close()
        self.transport.close()
        self.sftp = None

    def listdir(self, remote: str) -> list:
        """
        List files in directory
        :param remote: path to directory
        :return:
            `list` of files in directory
        """
        lst = {}
        if self.sftp is None:
            self._initialize(self.user, self.ip, self.port, self.key)
        for atr in self.sftp.listdir_attr(remote):
            if stat.S_ISREG(atr.st_mode):
                lst[atr.filename] = f'{remote}/{atr.filename}'
        return lst

    def download(self, remote: str, local: Path) -> Path:
        """
        Download file from server
        :param remote: path to file on server
        :param local: path of local file

        :return:
            `path` to downloaded file
        """
        if self.sftp is None:
            self._initialize(self.user, self.ip, self.port, self.key)
        with open(local, 'wb') as f:
            self.sftp.getfo(remote, f)
        return local

    def remove(self, remote: str) -> str:
        """
        Remove file from server
        :param remote: path to file on server
        :return:
            `None`
        """
        if self.sftp is None:
            self._initialize(self.user, self.ip, self.port, self.key)
        try:
            self.sftp.unlink(remote)
        except IOError:
            return 'Given name is not a file'


try:
    serv = SFTP(USER, IP, SFTPPORT, Path('rif_rsa'))
    folder = serv.listdir('/mnt/data')


    for file in folder:
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp')):
            serv.download(folder[file], images / file)
        else:
            serv.download(folder[file], other / file)
        serv.remove(folder[file])

    serv._disconnect()

except Exception as e:
    print(e)
