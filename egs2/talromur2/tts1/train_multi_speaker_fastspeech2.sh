#!/bin/bash

expdir="exp"

train_set=train
valid_set=dev
eval_set=eval1
test_sets="${valid_set} ${eval_set}"

# # # Prep data directory
# ./run.sh --stage 1 --stop-stage 1 \
#     --train_set "$train_set" \
#     --valid_set "$valid_set" \
#     --test_sets "$test_sets" \
#     --srctexts "data/train_all/text" \
#     --expdir "$expdir" \
#     --local_data_opts "all"

# # # Since ice-g2p phonetization is very slow, dump phonemized text at first
# ./local/phonetize.sh all

# Run from stage 2
./run.sh \
    --train_set "${train_set}_phn" \
    --valid_set "${valid_set}_phn" \
    --test_sets "${valid_set}_phn ${eval_set}_phn" \
    --srctexts "data/${train_set}_phn/text" \
    --expdir "$expdir" \
    --stage 6 \
    --g2p none \
    --cleaner none \
    --use_xvector true \
    --ngpu 1 \
    --expdir "$expdir" \
    --train_config ./conf/tuning/train_xvector_fastspeech2.yaml \
    --inference_model valid.loss.ave_5best.pth \
    --teacher_dumpdir exp/tts_with_wordsep/decode_use_teacher_forcingtrue_valid.loss.ave_5best \
    --tts_stats_dir exp/tts_with_wordsep/decode_use_teacher_forcingtrue_valid.loss.ave_5best/stats \
    --write_collected_feats true
