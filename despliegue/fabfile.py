# coding: utf-8

from fabric.api import sudo, cd, env, run
import os


def Install():
	""" Download the repo """

	run('git clone https://github.com/patamimbre/sptorrent-api')

def Uninstall():
	""" Remove the repo """

	run('sudo rm -rf ./sptorrent-api')

def Start():
	""" Run docker-ce """

	run('cd ~/sptorrent-api/ && sudo docker-compose up --build',pty=False)

def Stop():
    """ Stop running containers  """
    run('sudo docker stop $(sudo docker ps -q)')