#!/bin/bash

for dset in train dev eval1; do
    utils/copy_data_dir.sh data/"${dset}"{,_phn}
    ./pyscripts/utils/convert_text_to_phn.py \
        --nj 32 \
        --g2p espeak_ng_english_us_vits \
        --cleaner tacotron \
        data/"${dset}"{,_phn}/text
done