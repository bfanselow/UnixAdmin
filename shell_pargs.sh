#!/bin/sh

##
## File: shell_pargs.sh
## Description:
##  Demonstate a simple way to parse command-line args in (Bourne) shell-script.
##  Better off just writing a Python script, but there are still times when  we 
##  must use a shell script. 
##
## Usage examples: 
##  $ ./shell_pargs.sh -h 
##  $ ./shell_pargs.sh ls (default dir .) 
##  $ ./shell_pargs.sh ls=/etc 
##  $ ./shell_pargs.sh ls=/etc  --long
##
## Author: Bill Fanselow


MYNAME='shell_pargs.sh'

## Set Defaults
DIR='.'
MODE='short'

##-----------------------------------------------------------------------------
## Print all usage details
usage()
{
    exit_code=$1

    echo "Usage:"
    echo ""
    echo "./$MYNAME"
    echo "  -h --help"
    echo "  ls=<dir>"
    echo "  --long"
    echo ""

    if [ "X${exit_code}" != "X" ]; then
      exit $exit_code
    fi
}
##-----------------------------------------------------------------------------
## main()
##-----------------------------------------------------------------------------
## If we require some input
if [ "$1" = "" ]; then
   echo "Cmd-line error: must provide input" 
   usage 1 
fi

## Parse the args: key/value pairs are assumed to passed as "<key>=<val>"
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage 0
            exit
            ;;
        ls)
            DIR=$VALUE
            ;;
        --long)
            MODE='long' 
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage 0
            exit 1
            ;;
    esac
    shift
done

## Perfom the script's purpose based on input options
exec="/bin/ls $DIR"
if [ "X${MODE}" = "Xlong" ]; then
  exec="/bin/ls -ltr $DIR"
fi
$exec

exit 0
