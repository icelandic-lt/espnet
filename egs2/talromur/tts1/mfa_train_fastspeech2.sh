#!/usr/bin/env bash

speaker_id=$1

if [ -z speaker_id ]; then
    echo "No speaker ID supplied. exiting..."
    exit 1
fi

expdir="exp/mfa_${speaker_id}"

# # Run fastspeech2 training
./run.sh --stage 5 \
    --ngpu 1 \
    --train_set train_mfa_${speaker_id} \
    --valid_set dev_mfa_${speaker_id} \
    --test_sets "dev_mfa_${speaker_id} eval1_mfa_${speaker_id}" \
    --srctexts "data/train_mfa_${speaker_id}/text" \
    --expdir "$expdir" \
    --g2p none \
    --cleaner none \
    --train_config conf/tuning/train_fastspeech2.yaml \
    --teacher_dumpdir data \
    --write_collected_feats true
