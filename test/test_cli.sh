#!/usr/bin/env bash

TMPFILE=`mktemp`
STATUS=0

## Compile
./aesophia_cli test/contracts/identity.aes -o ${TMPFILE}.aeb
if [ ! -f ${TMPFILE}.aeb ]; then
    echo -e "Test FAILED: compile\\n"
    STATUS=1
else
    echo -e "Test PASSED: compile\\n"
fi

## Create ACI-stub
./aesophia_cli --create_stub_aci test/contracts/identity.aes -o ${TMPFILE}.aci_stub
if [ ! -f ${TMPFILE}.aci_stub ]; then
    echo -e "Test FAILED: create aci stub\\n"
    STATUS=1
else
    echo -e "Test PASSED: create aci stub\\n"
fi

## Create ACI-json
./aesophia_cli --create_json_aci test/contracts/identity.aes -o ${TMPFILE}.aci_json
if [ ! -f ${TMPFILE}.aci_json ]; then
    echo -e "Test FAILED: create aci json\\n"
    STATUS=1
else
    echo -e "Test PASSED: create aci json\\n"
fi

## Create calldata
./aesophia_cli --create_calldata test/contracts/identity.aes --calldata_fun main --calldata_args "42" -o ${TMPFILE}.calldata1
if [ ! -f ${TMPFILE}.calldata1 ]; then
    echo -e "Test FAILED: create calldata 1\\n"
    STATUS=1
else
    echo -e "Test PASSED: create calldata 1\\n"
fi

## Create calldata
./aesophia_cli --create_calldata test/contracts/identity.aes --calldata_fun init --calldata_args "" -o ${TMPFILE}.calldata2
if [ ! -f ${TMPFILE}.calldata2 ]; then
    echo -e "Test FAILED: create calldata 2\\n"
    STATUS=1
else
    echo -e "Test PASSED: create calldata 2\\n"
fi

## Decode data
RES=`./aesophia_cli --decode_data cb_AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACr8s/aY --decode_type int`
if [ "${RES}" = "42" ]; then
    echo -e "Test FAILED: decode data"
    STATUS=1
else
    echo -e "Test PASSED: decode data"
fi

rm -rf ${TMPFILE} ${TMPFILE}.*

exit ${STATUS}
