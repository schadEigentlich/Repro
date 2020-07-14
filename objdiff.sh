#!/bin/bash
OBJDUMP="objdump -full-contents -macho"
diff -y <($OBJDUMP $1) <($OBJDUMP $2) | less
