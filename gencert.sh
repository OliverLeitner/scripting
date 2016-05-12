#!/bin/bash
# generate crt/csr/key/pem pair with openssl

OUT_NAME="vpn_cert"
OUT_PASSLESS_NAME="new_vpn_cert"
OUT_DIR="certs/"
OUT_DAYS=356
OUT_CRYPTOLEVEL=4096
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

#store a new key without password so one may start webserver without keyphrase
openssl rsa -in ${OUT_DIR}ssl_${OUT_NAME}.key -out ${OUT_DIR}${OUT_PASSLESS_NAME}.key

#and finally the reduced .pem file for apache2 etc...
cat ${OUT_DIR}ssl_${OUT_NAME}.crt | openssl x509 > ${OUT_DIR}ssl_${OUT_NAME}.pem

#now we need a crl for vpn...
openssl ca -gencrl -keyfile ${OUT_DIR}${OUT_PASSLESS_NAME}.key -cert ${OUT_DIR}ssl_${OUT_NAME}.crt -out ${OUT_DIR}ssl_${OUT_NAME}.crl.pem
openssl crl -inform PEM -in ${OUT_DIR}ssl_${OUT_NAME}.crl.pem -outform DER -out ${OUT_DIR}ssl_${OUT_NAME}.crl

#generating sha checksums for the generated cert files.
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.key > ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.csr >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.crt >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.pem >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.crl.pem >> ${OUT_DIR}ssl_${OUT_NAME}.sums
sha512sum ${OUT_DIR}ssl_${OUT_NAME}.crl >> ${OUT_DIR}ssl_${OUT_NAME}.sums

#flush memory after cert generation...
#sync; echo 3 > /proc/sys/vm/drop_caches

exit 0
