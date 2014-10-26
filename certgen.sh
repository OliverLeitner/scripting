#!/bin/bash
# generate crt/csr/key/pem pair with openssl

OUT_NAME="server"
OUT_DIR="/path/to/certs/"
OUT_DAYS=356
OUT_CRYPTOLEVEL=1024
OUT_CRYPTO="des3"

#create directory automagically if not exists
if [ -d "$OUT_DIR" ]
then
	echo "we are creating the directory $OUT_DIR because it doesnt exist..."
	mkdir $OUT_DIR
fi

#first the key
openssl genrsa -${OUT_CRYPTO} -out ${OUT_DIR}ssl_${OUT_NAME}.key ${OUT_CRYPTOLEVEL}

#secondly the csr
openssl req -new -key ${OUT_DIR}ssl_${OUT_NAME}.key -out ${OUT_DIR}ssl_${OUT_NAME}.csr

#third part is the self signed cert, disable this if you have key auth stuff going...
openssl x509 -req -days ${OUT_DAYS} -in ${OUT_DIR}ssl_${OUT_NAME}.csr -signkey ${OUT_DIR}ssl_${OUT_NAME}.key -out ${OUT_DIR}ssl_${OUT_NAME}.crt

#and finally the reduced .pem file for apache2 etc...
cat ${OUT_DIR}ssl_${OUT_NAME}.crt | openssl x509 > ${OUT_DIR}ssl_${OUT_NAME}.pem

#generating sha checksums for the generated cert files.
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.key > ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.csr >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.crt >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.pem >> ${OUT_DIR}ssl_${OUT_NAME}.sums

#flush memory after cert generation...
#sync; echo 3 > /proc/sys/vm/drop_caches

exit 0
