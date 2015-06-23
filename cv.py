import argparse
import gettext


from jinja2 import (
    Environment,
    FileSystemLoader,
    )

loader = FileSystemLoader(searchpath='html')
env = Environment(loader=loader, extensions=['jinja2.ext.i18n'])

def render(lang):
    env.install_gettext_translations(gettext.translation('cv', 'i18n', (lang,)))
    vars = {'conf': {'lang':lang}, 'content': {'private':{'phone':'+1-514-571-6377'}}}
    return env.get_template('cv.html').render(vars)
    

if __name__ == "__main__":
    import argparse
    argparser = argparse.ArgumentParser(description='Render my resume.')
    argparser.add_argument('lang', choices=["en", "fr", "en_US", "fr_CA"])
    argparser.add_argument('out', type=argparse.FileType('w'))

    args = argparser.parse_args()
    lang = args.lang[0:2]
    out = args.out
    out.write(render(lang))
    
    
