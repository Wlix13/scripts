import subprocess

from sanic import Sanic
from sanic.response import text
from requests import post, get

app = Sanic(name='Eins_windows')

@app.route("/control")
async def control(request):
    state = request.args.get('switch')

    try:
        if state == 'restart':
            res = subprocess.run(['shutdown', '/r', '-t', '10'])
        elif state == 'shutdown':
            res = subprocess.run(['shutdown', '/s', '-t', '10'])
    except TimeoutError():
        print('Maybe you need admin rights')
        return text('TimeOut error')
    except subprocess.CalledProcessError():
        print('Error with processing command')
        return text('Process error')
    else:
        return text('ok')


if __name__ == "__main__":
    app.run(debug=True, auto_reload=True)

    