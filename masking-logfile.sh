#!/bin/bash
# ======================================================================
# Project Name    : masking-logfile
# File Name       : masking-logfile.sh
# Encoding        : utf-8
# Creation Date   : Sep. 8, 2017
#  
# Copyright @ 2017 Masaru Kawabata. All rights reserved.
#  
# This source code or any portion thereof must not be  
# reproduced or used in any manner whatsoever.
# ======================================================================

# gunzip compress file
## get target files
ls -ld sample*.gz | awk '{print $9}' > gzipfile.lst

## gunzip target files
while read GZIPFILE
do
    gunzip $GZIPFILE
done < ./gzipfile.lst

# mask log file
## get target files
ls -ld sample* | awk '{print $9}' > logfile.lst

## mask target file
while read LOGFILE
do
    cat ${LOGFILE} |\
    sed -e 's/\\//g' \
        -e 's/"email"=>"[^@ ]*@[^@]*\.[^@ ]*"/"email"=>"[FILTERED]"/g' \
        -e 's/"name"=>"[^ ]*[^]*\.[^ ]*"/"name"=>"[FILTERED]"/g' \
        -e 's/"name"=>"[^ ]* [^]*\.[^ ]*"/"name"=>"[FILTERED]"/g' \
        -e 's/"tel"=>"[^ ]*[^]*\.[^ ]*"/{"tel"=>"[FILTERED]"/g' \
        -e 's/"address_detail"=>"[^ ]*[^]*\.[^ ]*"/"address_detail"=>"[FILTERED]"/g' \
        -e 's/"account_number"=>"[^ ]*[^]*\.[^ ]*"/"account_number"=>"[FILTERED]"/g' \
        -e 's/"account_name_kana"=>"[^ ]*[^]*\.[^ ]*"/"account_name_kana"=>"[FILTERED]"/g' \
        -e 's/"bank_name"=>"[^ ]*[^]*\.[^ ]*"/"bank_name"=>"[FILTERED]"/g' \
        -e 's/"bank_code"=>"[^ ]*[^]*\.[^ ]*"/"bank_code"=>"[FILTERED]"/g' \
        -e 's/"branch_name"=>"[^ ]*[^]*\.[^ ]*"/"branch_name"=>"[FILTERED]"/g' \
        -e 's/"branch_number"=>"[^ ]*[^]*\.[^ ]*"/"branch_number"=>"[FILTERED]"/g' \
        -e 's/"address"=>"[^ ]*[^]*\.[^ ]*"/"address"=>"[FILTERED]"/g' \
        -e 's/"aid"=>"[^ ]*[^]*\.[^ ]*"/"aid"=>"[FILTERED]"/g' \
        -e 's/"user_name"=>"[^ ]*[^]*\.[^ ]*"/"user_name"=>"[FILTERED]"/g' \
        -e 's/"primary_key"=>"[^ ]*[^]*\.[^ ]*"/"primary_key"=>"[FILTERED]"/g' \
        -e 's/"identifier"=>"[^ ]*[^]*\.[^ ]*"/"identifier"=>"[FILTERED]"/g' \
        -e 's/"encrypted_password"=>"[^ ]*[^]*\.[^ ]*"/"encrypted_password"=>"[FILTERED]"/g' \
        -e 's/"password_salt"=>"[^ ]*[^]*\.[^ ]*"/"password_salt"=>"[FILTERED]"/g' \
        -e 's/"reset_password_token"=>"[^ ]*[^]*\.[^ ]*"/"reset_password_token"=>"[FILTERED]"/g' \
        -e 's/"contact_email"=>"[^ ]*[^]*\.[^ ]*"/"contact_email"=>"[FILTERED]"/g' \
        -e 's/"birthday"=>"[^ ]*[^]*\.[^ ]*"/"birthday"=>"[FILTERED]"/g' \
        -e 's/"confirmation_token"=>"[^ ]*[^]*\.[^ ]*"/"confirmation_token"=>"[FILTERED]"/g' \
        -e 's/"unconfirmed_email"=>"[^ ]*[^]*\.[^ ]*"/"unconfirmed_email"=>"[FILTERED]"/g' > ${LOGFILE}.tmp
    mv ${LOGFILE}.tmp ${LOGFILE}
done < ./logfile.lst

