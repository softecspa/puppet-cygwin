cygwin
=================

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
 * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview
This module manage installation of cygwin. It work and it's tested on Windows 7 (x86/x64)

##Module Description
 * This module:
    * download the installation file in a tmp\_dir and, after, it installs it
    * Add cygwin\\bin directory in windows PATH environment variable

##Setup

 * Parameter *tmp_dir* is mandatory:
    * *class{'cygwin': tmp_dir => "C:\\tmp_path"}*

###Setup Requirements
It require modules:
 * basti1302/puppet-windows-path

##Usage

 * **mirror\_src** parameter specify the mirror where installer will be downloaded. Commonly default are the perfect value
 * **packages** parameter specify a comma separated list of packages to install to. Default are wget,openssh

    class{'cygwin':
      packages  => 'wget,openssh,bc,curl'
    }
###Cygwin::wget define

cygwin::wget define is used to download a file, through wget, in windows.

    cygwin::wget{'example':
      url  => 'http://www.example.com/file.tar.gz',
      path => 'C:\\'
    }

## Limitations
Obviuosly it works only in Windows
