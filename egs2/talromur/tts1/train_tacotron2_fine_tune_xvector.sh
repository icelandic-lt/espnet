#!/bin/bash

speaker_id=$1

if [ -z $speaker_id ]; then
    echo "Speaker id was not provided. Please provide a speaker id from the available ids: [a, b, c, d, e, f, g, h]"
    exit 1
fi

expdir="exp/${speaker_id}"

train_set=train_${speaker_id}
valid_set=dev_${speaker_id}
eval_set=eval1_${speaker_id}
test_sets="${valid_set} ${eval_set}"
pretrain="/home/gunnar/espnet/egs2/talromur2/tts1/exp/tts_augmented_clean2/valid.loss.ave_5best.pth"

# Prep data directory
./run.sh --stage 1 --stop-stage 1 \
    --train_set "$train_set" \
    --valid_set "$valid_set" \
    --test_sets "$test_sets" \
    --srctexts "data/train_${speaker_id}/text" \
    --expdir "$expdir" \
    --local_data_opts "$speaker_id"

# Since espeak is super slow, dump phonemized text at first
./phonetize.sh $speaker_id

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
    --train_config ./conf/tuning/train_xvector_tacotron2.yaml \
    --inference_model valid.loss.ave_5best.pth \
    --train_args "--init_param /home/gunnar/espnet/egs2/talromur2/tts1/exp/tts_augmented_clean2/valid.loss.ave_5best.pth:tts:tts" \
    --tag finetune_tacotron2_raw_phn_talromur2_aug_clean2