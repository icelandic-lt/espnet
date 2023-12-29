#!/bin/env python

durations_filepath = "data/train_1and2_spk_avg_phn/durations"
numframes_filepath = "dump/mfcc/train_1and2_spk_avg_phn/utt2num_frames"

dur_dict = {}
with open(durations_filepath, 'r') as f:
    for line in f.readlines():
        id, *durs = line.split()
        durs = [int(x) for x in durs]
        dur_dict[id] = {'durs': durs, 'dur_frames': sum(durs)}


# with open(numframes_filepath, 'r') as f:
#     for line in f.readlines():
#         id, num_frames = line.split()
#         if id not in dur_dict.keys():
#             print(f"{id} not present in dictionary. skipping...")
#             continue
#         dur_dict[id]['mfcc_frames'] = int(num_frames)

# Compare the two:
with open('alldurs.txt', 'w') as f:
    for id, dict in dur_dict.items():
        f.write(f"{id} {dict['dur_frames']}\n")