#!/usr/bin/env bash

# Copyright 2021 Gunnar Thor Örnólfsson
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

set -euo pipefail

log() {
    local fname=${BASH_SOURCE[1]##*/}
    echo -e "$(date '+%Y-%m-%dT%H:%M:%S') (${fname}:${BASH_LINENO[0]}:${FUNCNAME[1]}) $*"
}
SECONDS=0

stage=1
stop_stage=1

. utils/parse_options.sh

if [ $# -ne 1 ]; then
    log "Error: Only speaker id is required. It should be one of the values [a, b, c, d, e, f, g, h]"
    exit 2
fi

speaker_id=$1

if [ $speaker_id = "all" ]; then
    ./local/data_multi_speaker.sh
    exit 0
fi

. ./path.sh || exit 1
. ./cmd.sh || exit 1
. ./db.sh || exit 1

if [ -z "${TALROMUR}" ]; then
   log "Fill the value of 'TALROMUR' of db.sh"
   exit 1
fi
db_root=${TALROMUR}

full_set=full_mfa_${speaker_id}
train_set=train_mfa_${speaker_id}
train_dev=dev_mfa_${speaker_id}
eval_set=eval1_mfa_${speaker_id}

if [ ${stage} -le -1 ] && [ ${stop_stage} -ge -1 ]; then
    log "stage -1: Data Download"
    local/data_download.sh "${db_root}"
fi

if [ ${stage} -le 0 ] && [ ${stop_stage} -ge 0 ]; then
    log "stage 0: Data Preparation"
    # set filenames
    scp=data/${full_set}/wav.scp
    utt2spk=data/${full_set}/utt2spk
    spk2utt=data/${full_set}/spk2utt
    text=data/${full_set}/text

    # check file existence
    [ ! -e data/${full_set} ] && mkdir -p data/${full_set}
    [ -e ${scp} ] && rm ${scp}
    [ -e ${utt2spk} ] && rm ${utt2spk}
    [ -e ${spk2utt} ] && rm ${spk2utt}
    [ -e ${text} ] && rm ${text}

    # make scp, utt2spk, and spk2utt
    find ${db_root}/${speaker_id} -follow -name "*.wav" | sort | while read -r filename;do
        id=$(basename ${filename} | sed -e "s/\.[^\.]*$//g")
        echo "${id} ${filename}" >> ${scp}
        echo "${id} ${speaker_id}" >> ${utt2spk}
    done

    utils/utt2spk_to_spk2utt.pl ${utt2spk} > ${spk2utt}

    # make text using the original text
    paste -d " " \
        <(cut -f 1 < ${db_root}/${speaker_id}/index.tsv) \
        <(cut -f 4 < ${db_root}/${speaker_id}/index.tsv) \
        >> ${text}

    utils/fix_data_dir.sh data/${full_set}
    utils/validate_data_dir.sh --no-feats data/${full_set}

    # Run g2p on the data directory, generating the required pronunciations in the appendix file.
    ./local/dump_tts_prons.py \
        --full-set ${full_set} \
        --dump-transcripts \
        --current-appendix ./dump/prondict_appendix.txt
fi

if [ ${stage} -le 1 ] && [ ${stop_stage} -ge 1 ]; then
    log "stage 2: generate durations and text from mfa alignment"

    # Note that we need the durations file to be called utt2dur so it is handled 
    # properly by subset_data_dir.sh in the next step
    python ./pyscripts/utils/mfa_format.py durations \
        --corpus_dir ${db_root}/${speaker_id}/ \
        --textgrid_dir ${db_root}/alignments_json/${speaker_id}/ \
        --durations_path ./data/${full_set}/utt2dur \
        --train_text_path ./data/${full_set}/text
    
    python ./local/convert_ipa_to_sampa.py \
        --input-textfile ./data/${full_set}/text \
        --output-textfile ./data/${full_set}/text_sampa


    mv ./data/${full_set}/text ./data/${full_set}/text_ipa
    mv ./data/${full_set}/text_sampa ./data/${full_set}/text

    log "finished generating mfa alignment text and duration files"
fi


if [ ${stage} -le 2 ] && [ ${stop_stage} -ge 2 ]; then
    log "stage 3: utils/subset_data_dir.sh"
    if [ -e val_utts.txt ]; then rm val_utts.txt; fi
    if [ -e test_utts.txt ]; then rm test_utts.txt; fi
    if [ -e train_utts.txt ]; then rm train_utts.txt; fi

    # make evaluation and devlopment sets
    paste -d " " \
        <(cut -f 1 < ${db_root}/split/${speaker_id}_val.txt) \
        >> val_utts.txt
    paste -d " " \
        <(cut -f 1 < ${db_root}/split/${speaker_id}_test.txt) \
        >> test_utts.txt
    paste -d " " \
        <(cut -f 1 < ${db_root}/split/${speaker_id}_train.txt) \
        >> train_utts.txt

    utils/subset_data_dir.sh --utt-list val_utts.txt data/${full_set} data/${train_dev}
    utils/subset_data_dir.sh --utt-list test_utts.txt data/${full_set} data/${eval_set}
    utils/subset_data_dir.sh --utt-list train_utts.txt data/${full_set} data/${train_set}

    rm val_utts.txt test_utts.txt train_utts.txt

    # rename utt2dur files to reflect tts.sh expectation
    mv data/${train_set}/utt2dur data/${train_set}/durations
    mv data/${eval_set}/utt2dur data/${eval_set}/durations
    mv data/${train_dev}/utt2dur data/${train_dev}/durations

fi


log "Successfully finished. [elapsed=${SECONDS}s]"