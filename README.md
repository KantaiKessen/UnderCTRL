# Everything is Under CTRL

No really. It's under control.
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

## Running the tests

You will need to have put the directory on the desktop and made the users and programs files.

### Run the starter script

This will install useful programs, like vim, clamav, and libpam-cracklib. It will also change your default editor to vim and enable the firewall

```
./starter.sh

```

### Run the basicscript

This adds users to the system from the users file, and deletes those that are not. It also changes passwords for all users except for yourself.
It also deletes autologin users and bad programs.

```
./basicscript.sh
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Cloud9](https://c9.io) - IDE

## Authors

* **Kevin Liu** - *Initial work* - [Niokiryth](https://github.com/Niokiryth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the GNU License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Me
* Myself
* I
