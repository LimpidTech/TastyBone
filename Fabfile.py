from fabric.api import local

def upload():
    local('make && python setup.py sdist upload')

