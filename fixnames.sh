#!/bin/bash
#script from nev fixing multiple filename
#bugs that dont get caught by detox
#input=$1
rename 's/#/nr/g' *
rename 's/%/prc/g' *
rename 's/~//g' *
rename 's/\,/_/g' *
rename 's/\+/_/g' *
rename 's/\.\.\./\./g' *
rename 's/\.\./\./g' *
exit 0
