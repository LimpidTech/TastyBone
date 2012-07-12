from distutils.core import setup

import os
import sys

parent_directory = os.path.abspath(os.path.dirname(__file__))

metafiles = {
    'README.md': None,
    'CHANGES.md': None,
    'CLASSIFIERS.txt': None,
}

# The following bit will read each index from metafiles and fill it's value
# with the contents of that file if it is able to read the file.
for filename in metafiles:
    try:
    	current_file = open(os.path.join(parent_directory, filename))
    	metafiles[filename] = current_file.read()
    	current_file.close()

    except IOError:
    	pass

metadata = {
    'name': 'tastybone',
    'version': '0.0.4',
    'description': 'Expose TastyPie to your client. Nicely.',
    'long_description': metafiles['README.md'] + '\n\n' + metafiles['CHANGES.md'],
    'classifiers': metafiles['CLASSIFIERS.txt'],
    'author': 'Brandon R. Stoner',
    'author_email': 'monokrome@limpidtech.com',
    'url': 'http://github.com/LimpidTech/TastyBone',
    'keywords': 'django tastypie',
    'packages': ['tastybone'],
    'package_data': {
        'tastybone': [
            'api.py',
            '__init__.py',
            'static/scripts/tastybone.js',
            'static/scripts/tastybone.min.js',
        ]
    }
}

setup(**metadata)
