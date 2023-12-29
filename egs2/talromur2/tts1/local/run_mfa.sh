#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

fs=22050
n_shift=256

./scripts/utils/mfa.sh \
    --language is  \
    --train true \
    --g2p_model g2p_is \
    --samplerate ${fs} \
    --hop-size ${n_shift} \
    --split_sets "train dev" \
    --clean_temp true \
    --stage 3 \
    "$@"

    # --split_sets "train_1and2_spk_avg dev_1and2_spk_avg eval1_1and2_spk_avg" \