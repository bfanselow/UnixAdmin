#!/bin/sh

##
## File: shell_pargs.sh
## Description:
##  Demonstate a simple way to parse command-line args in (Bourne) shell-script.
##  Better off just writing a Python script, but there are still times when  we 
##  must use a shell script. 
##
## Usage: ./shell_pargs.sh -h 
##
## Author: Bill Fanselow

## Set Defaults
DIR='.'
MODE='short'

##-----------------------------------------------------------------------------
## Print all usage details
usage()
{
    echo "Usage:"
    echo ""
    echo "./simple_args_parsing.sh"
    echo "  -h --help"
    echo "  ls=<dir>"
    echo "  --long"
    echo ""
}
##-----------------------------------------------------------------------------
## main()
##-----------------------------------------------------------------------------
## If we require some input
if [ "$1" = "" ]; then
   usage
fi

## Parse the args: key/value pairs are assumed to passed as "<key>=<val>"
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
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
            usage
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
