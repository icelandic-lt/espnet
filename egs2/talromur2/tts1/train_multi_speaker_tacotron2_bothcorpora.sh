#!/bin/bash

expdir="exp"

train_set=train_1and2
valid_set=dev_1and2
eval_set=eval1_1and2
test_sets="${valid_set} ${eval_set}"

# # # Prep data directory
# ./run.sh --stage 1 --stop-stage 1 \
#     --train_set "$train_set" \
#     --valid_set "$valid_set" \
#     --test_sets "$test_sets" \
#     --srctexts "data/$train_set/text" \
#     --expdir "$expdir"

# Run from stage 2
./run.sh \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${valid_set} ${eval_set}" \
    --srctexts "data/${train_set}/text" \
    --expdir "$expdir" \
    --stage 2 \
    --g2p "g2p_is" \
    --cleaner none \
    --token_type phn \
    --use_xvector true \
    --ngpu 1 \
    --expdir "$expdir" \
    --train_config ./conf/tuning/train_xvector_tacotron2.yaml \
    --inference_model valid.loss.ave_5best.pth \
    --tag tts_xvector_tacotron2_bothcorpora_is
