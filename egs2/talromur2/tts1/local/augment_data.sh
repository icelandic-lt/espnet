#!/usr/bin/env bash

# Copyright 2022 Gunnar Thor Örnólfsson
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

# This script adds augmentation data to the training set to improve 
# robustness in cases of extremely short utterances
# The augmentation data comes from utterances in the training set 
# which contain spelling of words and reading of digits
AUG_DIR_PATH="/data/gunnar/aug_talromur2_clean"

# We assume that data directories are already present, 
# and we only need to append to the files therein
FULL_SRC="data/full"
AUGMENTATION_SUFFIX="_aug_clean"
utils/copy_data_dir.sh $FULL_SRC{,${AUGMENTATION_SUFFIX}}

scp="${FULL_SRC}${AUGMENTATION_SUFFIX}/wav.scp"
utt2spk="${FULL_SRC}${AUGMENTATION_SUFFIX}/utt2spk"
textfile="${FULL_SRC}${AUGMENTATION_SUFFIX}/text"
spk2utt="${FULL_SRC}${AUGMENTATION_SUFFIX}/spk2utt"

while IFS="" read -r p || [ -n "$p" ]
do
    id=${p%% *}
    cdr=${p#* }
    text=${cdr%% *}
    spk_id=${id%%-*}
    filename="${AUG_DIR_PATH}/digits/audio/${id}.wav"
    echo "${id} ${filename}" >> ${scp}
    echo "${id} ${spk_id}" >> ${utt2spk}
    echo "${id} ${text}" >> ${textfile}
done <${AUG_DIR_PATH}/digits/index.tsv

while IFS="" read -r p || [ -n "$p" ]
do
    id=${p%% *}
    cdr=${p#* }
    text=${cdr%% *}
    spk_id=${id%%-*}
    filename="${AUG_DIR_PATH}/letters/audio/${id}.wav"
    echo "${id} ${filename}" >> ${scp}
    echo "${id} ${spk_id}" >> ${utt2spk}
    echo "${id} ${text}" >> ${textfile}
done <${AUG_DIR_PATH}/letters/index.tsv

sort ${utt2spk} > ${utt2spk}_sorted
mv ${utt2spk}_sorted ${utt2spk}
sort ${scp} > ${scp}_sorted
mv ${scp}_sorted ${scp}
sort ${text} > ${text}_sorted
mv ${text}_sorted ${text}

utils/utt2spk_to_spk2utt.pl $utt2spk > $spk2utt

echo "Validating data directory"
utils/fix_data_dir.sh ${FULL_SRC}${AUGMENTATION_SUFFIX}/
utils/validate_data_dir.sh --no-feats ${FULL_SRC}${AUGMENTATION_SUFFIX}/
