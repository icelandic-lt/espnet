#!/bin/bash

expdir="exp"


train_set=lestin_train
valid_set=lestin_dev
eval_set=lestin_eval

tag="xvector_fastspeech2_spk_avg_finetune_lestin"

# # # Run from stage 2
# ./run.sh \
#     --train_set "${train_set}_phn" \
#     --valid_set "${valid_set}_phn" \
#     --test_sets "${valid_set}_phn" \
#     --srctexts "data/${train_set}_phn/text" \
#     --tts_stats_dir exp/stats_lestin \
#     --expdir "$expdir" \
#     --stage 2 \
#     --stop_stage 5 \
#     --g2p none \
#     --cleaner none \
#     --use_xvector true \
#     --ngpu 1 \
#     --expdir "$expdir" \
#     --train_config ./conf/tuning/finetune_xvector_fastspeech2.yaml \
#     --inference_model valid.loss.ave_5best.pth \
#     --teacher_dumpdir data \
#     --tag "$tag" \
#     --train_args "--init_param ./exp/tts_xvector_fastspeech2_spk_avg_combined/valid.loss.ave_5best.pth" \
#     --write_collected_feats true

#     # --tts_stats_dir exp/tts_with_wordsep/decode_use_teacher_forcingtrue_valid.loss.ave_5best/stats \
# for dset in "${train_set}" "${valid_set}"
# do
#     ./local/convert_to_avg_xvectors.py --xvector-path dump/xvector/${dset}/xvector.scp \
#         --spk-xvector-path dump/xvector/${dset}/spk_xvector.scp --utt2spk data/${dset}/utt2spk 
# done

./run.sh \
    --train_set "${train_set}_phn" \
    --valid_set "${valid_set}_phn" \
    --test_sets "${valid_set}_phn ${eval_set}_phn" \
    --srctexts "data/${train_set}_phn/text" \
    --tts_stats_dir exp/stats_lestin \
    --expdir "$expdir" \
    --stage 7 \
    --stop_stage 7 \
    --g2p none \
    --cleaner none \
    --use_xvector true \
    --ngpu 1 \
    --expdir "$expdir" \
    --train_config ./conf/tuning/finetune_xvector_fastspeech2.yaml \
    --inference_model valid.loss.ave_5best.pth \
    --teacher_dumpdir data \
    --tag "$tag" \
    --train_args "--init_param ./exp/tts_xvector_fastspeech2_spk_avg_combined/valid.loss.ave_5best.pth" \
    --write_collected_feats true