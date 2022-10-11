import os
import subprocess
import json
from pathlib import Path

pwd = Path().absolute()

def init():
    if os.path.exists(pwd / '.info.json'):
        pass
    else:
        print('Выберите папку с файлами Pascal')
        print(*[i for i in os.listdir(pwd) if os.path.isdir(i) and (not i.startswith('.'))])
        with open(pwd / '.info.json', 'w') as f:
            json.dump({'path': f'{pwd / input()}','lasttime': '', 'lastfile': ''}, f, indent=4)


def main():
    data = json.load(open(pwd / '.info.json', 'r'))
    path = Path(data['path'])
    lst = sorted([(os.path.getmtime(path / i), i) for i in os.listdir(path)], reverse=True, key=lambda x: x[0])
    for file in lst:
        if file[1].endswith('.pas'):
            if file[0] == json.load(open(pwd / '.info.json'))['lasttime']:
                print('No new files. Running old compilation')
                # subprocess.run(f'{path / file[1][:-4]}', shell=True)
                exit()
            code = subprocess.run(f'fpc -O1 -XS {path / file[1]}', shell=True).returncode
            break
    if code == 0:
        print('\nRunning your code:')
        # TODO: Проверять если файл старый, то не компилировать, а просто запускать. 
        # TODO: Если название изменилось, то компилировать
        # if data['lastfile'] != file[[0]]:
        subprocess.run(f'rm -rf {path / file[1][:-4]}.o', shell=True)
        code = subprocess.run(f'{path / file[1][:-4]}', shell=True).returncode
        # subprocess.run(f'rm -rf {path / file[1][:-4]}', shell=True)
        data['lasttime'], data['lastfile'] = file[0], file[1]
        json.dump(data, open(pwd / '.info.json', 'w'), indent=4)
    else:
        print('\nCompilation failed')

if __name__ == "__main__":
    init()
    main()