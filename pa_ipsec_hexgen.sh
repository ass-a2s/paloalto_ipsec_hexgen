#!/bin/sh

### LICENSE - (BSD 2-Clause) // ###
#
# Copyright (c) 2017, Daniel Plominski (ASS-Einrichtungssysteme GmbH)
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice, this
# list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
### // LICENSE - (BSD 2-Clause) ###

### ### ### ASS ### ### ###

#// SCRIPT:

while getopts ":s:h:" opt; do
  case "$opt" in
    s) hex=$OPTARG ;;
    h) string=$OPTARG ;;
  esac
done
shift $(( OPTIND - 1 ))

#/ check - empty arguments
if [ -z "$hex" ] && [ -z "$string" ]
then
   echo "usage:   ./pa_ipsec_hexgen.sh -h <HEX> OR -s <STRING>"
   echo "example: ./pa_ipsec_hexgen.sh -h 6578616d706c65 OR -s example"
   exit 1
fi

#/ check HEX and STRING match
if [ -z "$hex" ] || [ -z "$string" ]
then
   : # dummy
else
   CHECKMATCH=$(echo -n "$hex" | xxd -p)
   if [ "$string" = "$CHECKMATCH" ]
   then
      echo "[$(printf "\033[1;32m  OK  \033[0m\n")] valid match"
      exit 0
   else
      echo "[$(printf "\033[1;31mERROR\033[0m\n")] invalid match"
      exit 1
   fi
fi

#/ get HEX
if [ -z "$hex" ]
then
   : # dummy
else
   GETHEX=$(echo -n "$hex" | xxd -p)
   CHECKHEX=$(echo -n "$hex" | xxd -p | xxd -p -r)
   if [ "$hex" = "$CHECKHEX" ]
   then
      echo "HEX: $GETHEX"
      exit 0
   else
      echo "[$(printf "\033[1;31mERROR\033[0m\n")] invalid hex code"
      exit 1
   fi
fi

#/ get STRING
if [ -z "$string" ]
then
   : # dummy
else
   GETSTRING=$(echo -n "$string" | xxd -p -r)
   CHECKSTRING=$(echo -n "$string" | xxd -p -r | xxd -p)
   if [ "$string" = "$CHECKSTRING" ]
   then
      echo "STRING: $GETSTRING"
      exit 0
   else
      echo "[$(printf "\033[1;31mERROR\033[0m\n")] invalid hex code"
      exit 1
   fi
fi

### ### ### ASS ### ### ###
exit 0
# EOF
