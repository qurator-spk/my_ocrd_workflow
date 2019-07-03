#!/bin/bash -x
cd `mktemp -d`
wget https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/8d8aa287-94ca-48e3-84a8-1ee602871550/data/lohenstein_agrippina_1665.ocrd.zip
dtrx lohenstein_agrippina_1665.ocrd.zip
cd lohenstein_agrippina_1665.ocrd/data
ocrd-tesserocr-segment-line -l DEBUG -m mets.xml -I DOES-NOT-EXIST -O OCR-D-SEG-REGION