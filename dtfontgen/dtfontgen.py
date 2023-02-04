import shlex
import sys

ROBOTO_CODECS = {
    'iso8859-1',
    'iso8859-2',
    'iso8859-3',
    'iso8859-4',
    'iso8859-5',
    'iso8859-7',
    'iso8859-9',
    'iso8859-10',
    'iso8859-13',
    'iso8859-15',
    'iso8859-16',
    'koi8-e',
    'koi8-r',
    'koi8-ru',
    'koi8-u',
    'koi8-uni',
    'iso10646-1',
}

ROBOTO_SERIF_CODECS = {
    'iso8859-1',
    'iso8859-2',
    'iso8859-3',
    'iso8859-4',
    'iso8859-9',
    'iso8859-10',
    'iso8859-13',
    'iso8859-15',
    'iso10646-1',
}


def dt2google(name, orig):
    vals = name[1:].split('-')
    ovals = orig[1:].split('-')

    vals[6] = ovals[6]
    vals[7] = ovals[7]
    vals[8] = ovals[8]
    vals[9] = ovals[9]
    vals[11] = ovals[11]

    codec = '-'.join(vals[12:])
    if vals[0] != 'dt':
        return None

    if codec in ROBOTO_CODECS or codec in ROBOTO_SERIF_CODECS:
        vals[0] = 'google'

    if vals[10] == 'm' and codec in ROBOTO_CODECS:
        vals[1] = 'roboto mono'
        if vals[2] == 'bold':
            vals[2] = '700'
        elif vals[2] == 'medium':
            vals[2] = '400'
        else:
            return None
        vals[5] = ''
    elif codec in ROBOTO_CODECS and 'sans' in vals[5]:
        vals[1] = 'roboto'
        if vals[2] == 'bold':
            vals[2] = '700'
        elif vals[2] == 'medium':
            vals[2] = '400'
        else:
            return None
        if vals[4] != 'normal':
            return None
        vals[4] = '100'
        vals[5] = ''
    elif 'serif' in vals[5] and codec in ROBOTO_SERIF_CODECS:
        vals[1] = 'roboto serif 20pt'
        if vals[2] == 'bold':
            vals[2] = '700'
        elif vals[2] == 'medium':
            vals[2] = '400'
        else:
            return None
        if vals[4] != 'normal':
            return None
        vals[4] = '100'
        vals[5] = '[]'
    elif codec in ROBOTO_CODECS and 'serif' in vals[5]:
        vals[1] = 'roboto slab'
        if vals[2] == 'bold':
            vals[2] = '700'
        elif vals[2] == 'medium':
            vals[2] = '400'
        else:
            return None
        if vals[4] != 'normal':
            return None
        vals[3] = 'r'
        vals[5] = ''
    elif 'jis' in codec or 'ksc' in codec or 'gb' in codec:
        if vals[10] == 'm':
            vals[0], vals[1] = 'google', 'noto sans mono cjk '
        elif 'sans' in vals[5]:
            vals[0], vals[1] = 'adobe', 'noto sans cjk '
        elif 'serif' in vals[5]:
            vals[0], vals[1] = 'google', 'noto serif cjk '
        if 'jis' in codec:
            lg = 'jp'
        elif 'ksc' in codec:
            lg = 'kr'
        elif 'gb' in codec:
            lg = 'sc'
        vals[1] += lg
        if vals[2] == 'bold':
            vals[2] = '700'
        elif vals[2] == 'medium':
            vals[2] = '400'
        else:
            return None
        if vals[4] != 'normal':
            return None
        vals[3] = 'r'
        vals[5] = ''
        vals[10] = 'p'
    else:
        return None
    name = '-' + '-'.join(vals)
    return name


with open(sys.argv[1]) as f:
    for line in f.readlines():
        dtalias, dtfont = shlex.split(line.strip())
        res = dt2google(dtalias, dtfont)
        if res is not None:
            print(f'"{dtalias}" "{res}"')
        else:
            print(f'"{dtalias}" "{dtfont}"')
