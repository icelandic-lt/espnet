#!/bin/env python

import argparse
import os
import sys
from ice_g2p.converter import Converter


# Helper methods to silence print calls in Converter class
# Disable
def blockPrint():
    sys.stdout = open(os.devnull, 'w')


# Restore
def enablePrint():
    sys.stdout = sys.__stdout__


parser = argparse.ArgumentParser()
parser.add_argument("--input-textfile", type=str, required=True, help="""
Path to your input textfile. e.g. data/full_f/text""")

parser.add_argument("--output-textfile", type=str, required=True, help="""
Path to desired output text file. e.g. data/full_f/text_sampa""")

args = parser.parse_args()
c = Converter()

infile = args.input_textfile
outfile = args.output_textfile
exists = os.path.exists

if not exists(infile):
    sys.stderr.write(f"{infile} does not exists. Please check the path and try again. Exiting...")
    sys.exit(1)
    
outdir = os.path.dirname(outfile)
if not exists(outdir):
    os.mkdir(outdir)

with open(infile, "r") as f:
    utts = [tuple(x.strip().split(" ", maxsplit=1)) for x in f.readlines()]

blockPrint()
utts_sampa = [(x[0], c.convert(x[1], "IPA", "SAMPA")) for x in utts]
enablePrint()

outlines = [" ".join(x) + "\n" for x in utts_sampa]
with open(outfile, "w") as f:
    f.writelines(outlines)