#!/usr/bin/env bash

speaker_id=$1

if [ -z speaker_id ]; then
    echo "No speaker ID supplied. exiting..."
    exit 1
fi

expdir="exp/${speaker_id}"

# Use the previously trained tacotron2 model as the teacher
./run.sh \
    --ngpu 1 \
    --stage 7 \
    --train_set train_${speaker_id} \
    --valid_set dev_${speaker_id} \
    --test_sets "train_${speaker_id} dev_${speaker_id} eval1_${speaker_id}" \
    --cleaner none \
    --g2p "g2p_is" \
    --token_type phn \
    --train_config ./conf/tuning/train_tacotron2.yaml \
    --tts_exp exp/${speaker_id}/tts_train_tacotron2_raw_phn_g2p_is \
    --inference_args "--use_teacher_forcing true"

# # Run fastspeech2 training
./run.sh --stage 5 \
    --ngpu 1 \
    --train_set train_${speaker_id} \
    --valid_set dev_${speaker_id} \
    --test_sets "dev_${speaker_id} eval1_${speaker_id}" \
    --srctexts "data/train_${speaker_id}/text" \
    --expdir "$expdir" \
    --g2p "g2p_is" \
    --token_type phn \
    --cleaner none \
    --train_config conf/tuning/train_fastspeech2.yaml \
    --teacher_dumpdir exp/${speaker_id}/tts_train_tacotron2_raw_phn_g2p_is/decode_use_teacher_forcingtrue_train.loss.ave \
    --tts_stats_dir exp/${speaker_id}/tts_train_tacotron2_raw_phn_g2p_is/decode_use_teacher_forcingtrue_train.loss.ave/stats