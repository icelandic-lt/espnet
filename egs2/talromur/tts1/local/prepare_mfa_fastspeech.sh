#!/bin/bash

# I want to generate a data directory for training a fastspeech 
# model based on MFA alignments.
# The required files are a durations file with a matching text file.

# I also need to make sure that my g2p produces similar output to the text input of the model.
# Another script in this directory converts IPA transcriptions used by MFA
# To SAMPA transcriptions used here in ESPNet
path_to_trimmed_dir=/home/gunnar/talromur_analysis/talromur_trimmed
spkid="e"
mkdir ./data/full_mfa_${spkid}
python ./pyscripts/utils/mfa_format.py durations --corpus_dir ${path_to_trimmed_dir}/$spkid/ --textgrid_dir ${path_to_trimmed_dir}/alignments_json/$spkid/ --durations_path ./data/full_mfa_${spkid}

cp ./data/full_${spkid}/{spk2utt,wav.scp} ./data/full_mfa_${spkid}