for mediatype in $(cat mediatypes); do find /home | grep *[.]$mediatype >> ./mediafiles; done
