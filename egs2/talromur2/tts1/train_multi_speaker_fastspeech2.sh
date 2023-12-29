#!/bin/bash

expdir="exp"

train_set=train_1and2_spk_avg
valid_set=dev_1and2_spk_avg
eval_set=eval1_1and2_spk_avg
test_sets="${valid_set} ${eval_set}"

# # Use the previously trained tacotron2 model as the teacher
# ./run.sh \
#     --ngpu 1 \
#     --stage 7 \
#     --train_set train_${speaker_id}_phn \
#     --valid_set dev_${speaker_id}_phn \
#     --test_sets "train_${speaker_id}_phn dev_${speaker_id}_phn eval1_${speaker_id}_phn" \
#     --cleaner none \
#     --g2p none \
#     --train_config ./conf/tuning/train_xvector_tacotron2.yaml \
#     --tts_exp exp/${speaker_id}/tts_train_xvector_tacotron2_raw_phn_none \
#     --inference_args "--use_teacher_forcing true"

tag="xvector_fastspeech2_spk_avg_combined"

# # Run from stage 2
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
    --teacher_dumpdir data \
    --tag "$tag" \
    --write_collected_feats true

    # --tts_stats_dir exp/tts_with_wordsep/decode_use_teacher_forcingtrue_valid.loss.ave_5best/stats \
