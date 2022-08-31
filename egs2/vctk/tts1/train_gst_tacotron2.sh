#!/bin/bash


fs=24000
n_fft=2048
n_shift=300
win_length=1200

expdir="exp/all"

train_set=train_all
valid_set=dev_all
eval_set=eval1_all
test_sets="${valid_set} ${eval_set}"

train_config=conf/train.yaml
inference_config=conf/decode.yaml

./run.sh --stage 1 --stop-stage 1 \
    --train_set "$train_set" \
    --valid_set "$valid_set" \
    --test_sets "$test_sets" \
    --srctexts "data/train_all/text" \
    --expdir "$expdir" \


# Since g2p phonetization is very slow, dump phonemized text at first
./phonetize.sh

# Run from stage 2
./run.sh \
    --lang en \
    --stage 2 \
    --ngpu 4 \
    --feats_type raw \
    --fs "${fs}" \
    --n_fft "${n_fft}" \
    --n_shift "${n_shift}" \
    --win_length "${win_length}" \
    --token_type phn \
    --cleaner tacotron \
    --g2p none \
    --tts_task gan_tts \
    --expdir exp/all/22k \
    --dumpdir dump/all/22k \
    --feats_normalize none \
    --train_config "${train_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --srctexts "data/${train_set}_phn/text" \
    ${opts} "$@"
