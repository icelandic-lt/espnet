#!/usr/bin/env python

import argparse
import os
import sys
import shutil
from ice_g2p.transcriber import Transcriber
from tqdm import tqdm

parser = argparse.ArgumentParser(description="""
Performs g2p across a corpus of speech prompts, collecting all OOV words along 
with their predicted pronunciation into a pronunciation dictionary appendix to
be used and reused during training, evaluation and inference to save compute time. 
The text prompts reside in data/<full_set>/text , with the name of <full_set> usually 
being specified in the local/data.sh file for a given corpus.
The pronunciation dictionary appendix will be saved to dump/prondict_appendix.txt 
unless otherwise specified, is alphabetically sorted by prompt word and contains 
2 columns in the following format, separated by a tab character:
<word>  <pronunciation>
""")
group = parser.add_mutually_exclusive_group(required=True)

group.add_argument("--full-set", type=str,
                   help="""
Name of the data subdirectory which contains the corpus text file.""")

group.add_argument("--textfile-path", type=str,
                   help="""
Relative path from project directory to text file. e.g. data/full/text""")

parser.add_argument("--output-file", type=str, default="dump/prondict_appendix.txt",
                    help="""
Specifies the file to which the pronunciation dictionary appendix should be saved.
The file will go in the same directory as the supplied text prompt file.
Default value is prondict_appendix.txt""")

parser.add_argument("--dump-transcripts", default=False, action='store_true',
                    help="""
If set to true, transcripts will be dumped in a file named text_phn
The file will go in the same directory as the supplied text file.""")

parser.add_argument("--current-appendix", type=str, default="",
                    help="""
Specifies the path to a previously prepared pronunciation dictionary appendix.
The created appendix will contain all words specified in this file in addition to 
the new additions.""")

args = parser.parse_args()

full_set = args.full_set
outfile_path = args.output_file

prompts = []
if not full_set:
    textfile_path = args.textfile_path
    if not os.path.exists(textfile_path):
        sys.stderr.write("The provided path to the prompt text file is not valid.") 
        sys.stderr.write(f"--textfile-path {textfile_path}. Please check the argument and try again.")
        sys.stderr.flush()
        exit(1)
    with open(textfile_path, "r", encoding="utf8") as f:
        for line in f.readlines():
            prompts.append(line)
    phon_transcript_path = os.path.join(os.path.dirname(textfile_path), "text_phn")
else:
    if not os.path.exists(f"data/{full_set}/text"):
        sys.stderr.write("The provided name of the full-set data subdirectory is not valid.") 
        sys.stderr.write(f"--full-set {full_set}. Please check the argument and try again.")
        sys.stderr.flush()
        exit(1)
    with open(f"data/{full_set}/text", "r", encoding="utf8") as f:
        for line in f.readlines():
            prompts.append(line)
    phon_transcript_path = os.path.join("data", full_set, "text_phn")

g2p = Transcriber(use_dict=True, word_sep="<wb>")

if args.current_appendix:
    if not os.path.exists(args.current_appendix):
        sys.stderr.write("The provided path to a pronunciation dictionary appendix file is not valid.")
        sys.stderr.write(f"--current-appendix {args.current_appendix}. Please check the argument and try again.")
        sys.stderr.flush()
        exit(1)
    with open(args.current_appendix) as f:
        # Go through pronunciation dict appendix, adding to *automatic_g2p_dict*
        # as we expect the file to contain automatic pronunciation transcriptions.
        # and want it to be combined with new additional automatic transcriptions.
        for line in f.readlines():
            assert (len(line.split("\t")) == 2)
            word, pron = line.strip().split("\t")
            g2p.g2p.automatic_g2p_dict[word] = pron


outlines = []
for line in tqdm(prompts, desc="Transcribing prompts..."):
    uid, prompt = line.split(" ", maxsplit=1)
    transcription = g2p.transcribe(prompt)
    outlines.append(f"{uid} {transcription}\n")

auto_transcriptions = g2p.g2p.automatic_g2p_dict

with open(outfile_path, "w") as f:
    f.writelines([f"{word}\t{trans}\n"
                  for word, trans
                  in sorted(auto_transcriptions.items())])

if args.dump_transcripts:
    with open(phon_transcript_path, "w") as f:
        f.writelines(outlines)
