#!/usr/bin/env bash
set -euxo pipefail

speaker_id=$1

if [ -z speaker_id ]; then
    echo "No speaker ID supplied. exiting..."
    exit 1
fi

expdir="exp/${speaker_id}"

./tts.sh \
    --ngpu 1 \
    --stage 6 \
    --tts_task gan_tts \
    --train_set train_${speaker_id}_trimmed \
    --valid_set dev_${speaker_id}_trimmed \
    --test_sets "dev_${speaker_id}_trimmed eval1_${speaker_id}_trimmed" \
    --srctexts "data/train_${speaker_id}_trimmed/text" \
    --expdir "exp/${speaker_id}" \
    --fs 16000 \
    --f0min 90 \
    --f0max 200 \
    --n_fft 1024 \
    --n_shift 256 \
    --win_length null \
    --train_config conf/tuning/train_jets.yaml \
    --token_type phn \
    --g2p "g2p_is" \
    --cleaner null \
    --feats_type raw \
    --inference_config "conf/decode.yaml"