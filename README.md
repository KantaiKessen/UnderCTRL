# Everything is Under CTRL

No really. It's under control.

## Releases
##### Prerelease
1. [Alicorn 0.1.0](https://github.com/Niokiryth/UnderCTRL/releases/tag/v0.1.0.16-prealpha)
2. [Alicorn 0.2.0](https://github.com/Niokiryth/UnderCTRL/releases/tag/v0.2.0-prealpha)
##### Alpha
1. [Basilisk 0.5.0](https://github.com/Niokiryth/UnderCTRL/releases/tag/v0.5.0-alpha)
## Getting Started
Download the repo to your computer through git or github.

### Prerequisites
If you are downloading through git, you will need git. You also need to have Ubuntu.

```
git clone https://github.com/Niokiryth/UnderCTRL.git
```

### Installing

Installing is a simple 3 step process

#### Easy Way

1. Go to https://github.com/Niokiryth/UnderCTRL 
2. Download the zip/tar file.
3. Extract it to somewhere like the desktop


#### Hard Way

1. Make sure git is installed on your computer
2. Type in `git clone https://github.com/Niokiryth/UnderCTRL.git`
3. Put the folder on the Desktop


End with an example of getting some data out of the system or using it for a little demo

## Running the scripts

You will need to have put the directory on the desktop and made the users and programs files.

### Make sure the starter is executable
starter will make the other scripts executable
```
chmod 755 starter.sh
```

### Run the starter script

This will install useful programs, like vim, clamav, and libpam-cracklib. It will also change your default editor to vim and enable the firewall. It will also make all the scripts executable.

```
sudo ./starter.sh
```

### Run the basicscript

This adds users to the system from the users file, and deletes those that are not. It also changes passwords for all users except for yourself.
It also deletes autologin users and bad programs.

```
sudo ./basicscript/basicscript.sh
```

### Run the replace script
This will replace your security policy files with those that are clean

```
sudo ./YOUR_UBUNTU_VERSION/replace.sh
```

### Run the findmedia script
This will find media files and print them into a file.
```
sudo ./mediafinder/findmedia.sh
```

## Deployment

This probably won't work on a real computer.

## Written

* [Cloud9](https://c9.io) - IDE
* [Bash](https://www.gnu.org/software/bash/) - Language

## Authors

* **Kevin Liu** - *Initial work* - [Niokiryth](https://github.com/Niokiryth)

See also the list of [contributors](https://github.com/Niokiryth/UnderCTRL/graphs/contributors) who participated in this project.

## License

This project is licensed under the GNU License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Me
* Myself
* I


_____
UnderCTRL
Copyright (C) 2017  Kevin Liu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
