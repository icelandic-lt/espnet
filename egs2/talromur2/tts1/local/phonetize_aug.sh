#!/usr/bin/env bash

. ./cmd.sh
. ./path.sh

for dset in train_aug_clean2 dev_aug_clean2 eval1_aug_clean2; do
    utils/copy_data_dir.sh data/"${dset}"{,_phn};
    ${train_cmd} --gpu 1 --num-threads 1 data/"${dset}_phn/log/conversion.log" ./pyscripts/utils/convert_text_to_phn.py --nj 1 --g2p g2p_is data/"${dset}"{,_phn}/text;
    # srun --gres=gpu:1 ./pyscripts/utils/convert_text_to_phn.py --nj 1 --g2p g2p_is --cleaner tacotron data/"${dset}"{,_phn}/text;
done