# Set the path of your corpus
# "downloads" means the corpus can be downloaded by the recipe automatically

ACCENTED_FR=downloads
AIDATATANG_200ZH=downloads
AISHELL=downloads
AISHELL3=downloads
AISHELL4=downloads
ALFFA=downloads
AN4=downloads
AUDIOSET=
DIRHA_ENGLISH_PHDEV=
DIRHA_WSJ=
DIRHA_WSJ_PROCESSED="${PWD}/data/local/dirha_wsj_processed"  # Output file path
DNS=
DNS2=
DNS3=
DSING=downloads
WSJ0=
WSJ1=
WSJCAM0=
REVERB=
REVERB_OUT="${PWD}/REVERB"  # Output file path
CHIME3=
CHIME4=
CSJDATATOP=
CSJVER=dvd  ## Set your CSJ format (dvd or usb).
            ## Usage    :
            ## Case DVD : We assume CSJ DVDs are copied in this directory with the names dvd1, dvd2,...,dvd17.
            ##            Necessary directory is dvd3 - dvd17.
            ##            e.g. $ ls $CSJDATATOP(DVD) => 00README.txt dvd1 dvd2 ... dvd17
            ##
            ## Case USB : Necessary directory is MORPH/SDB and WAV
            ##            e.g. $ ls $CSJDATATOP(USB) => 00README.txt DOC MORPH ... WAV fileList.csv
            ## Case merl :MERL setup. Necessary directory is WAV and sdb
CSMSC=downloads
CSS10=
HKUST1=
HKUST2=
HUI_ACG=downloads
HUB4_SPANISH=
LABOROTV=
TEDXJP=
LIBRISPEECH=
LIBRILIGHT_LIMITED=
FSC=
SLURP=
VOXCELEB=
MINI_LIBRISPEECH=downloads
MISP2021=
LIBRIMIX=downloads
LIBRITTS=
LJSPEECH=downloads
MUSAN=
NSC=
JMD=downloads
JSSS=downloads
JSUT=downloads
JTUBESPEECH=downloads
JVS=downloads
KSS=
SNIPS= # smart-light-en-closed-field data path
SPGISPEECH=
SWBD=
SWBD_NXT=
THCHS30=downloads
TIMIT=$(realpath ../../../../TIMIT)
TSUKUYOMI=downloads
VOXFORGE=downloads
AMI=
COMMONVOICE=downloads
MICROSOFT_SPEECH_CORPUS=
BABEL_101=
BABEL_102=
BABEL_103=
BABEL_104=
BABEL_105=
BABEL_106=
BABEL_107=
BABEL_201=
BABEL_202=
BABEL_203=
BABEL_204=
BABEL_205=
BABEL_206=
BABEL_207=
BABEL_301=
BABEL_302=
BABEL_303=
BABEL_304=
BABEL_305=
BABEL_306=
BABEL_307=
BABEL_401=
BABEL_402=
BABEL_403=
BABEL_404=
PUEBLA_NAHUATL=downloads
TEDLIUM2=downloads
TEDLIUM3=downloads
VCTK=downloads
VIVOS=downloads
YESNO=downloads
YOLOXOCHITL_MIXTEC=downloads
HOW2_TEXT=downloads/how2-300h-v1
HOW2_FEATS=downloads/fbank_pitch_181516
ZEROTH_KOREAN=downloads
JAVA=downloads
RU_OPEN_STT=downloads
RUSLAN=downloads
SIWIS=downloads
GIGASPEECH=
GOOGLEI18N=downloads
NOISY_SPEECH=
NOISY_REVERBERANT_SPEECH=
LRS2=
LRS3=
SUNDA=downloads
CMU_ARCTIC=downloads
CMU_INDIC=downloads
INDIC_SPEECH=downloads
IWSLT22_DIALECT=
JKAC=
MUCS_SUBTASK1=downloads
MUCS_SUBTASK2=downloads
GAMAYUN=downloads
IWSLT21LR=downloads/iwslt21
<<<<<<< HEAD
JDCINAL=downloads
GRABO=downloads
WENETSPEECH=
SPEECHCOMMANDS=downloads
<<<<<<< HEAD
TOTONAC=downloads
PRIMEWORDS_CHINESE=downloads
SEAME=
BENGALI=downloads
IWSLT14=
BURMESE=downloads
MALAYALAM=downloads
ST_CMDS=downloads
MS_INDIC_IS18=
MARATHI=downloads
HARPERVALLEY=downloads

# For only CMU TIR environment
if [[ "$(hostname)" == tir* ]]; then
    BABEL_101=/projects/tir5/data/speech_corpora/babel/IARPA_BABEL_BP_101/
    BABEL_102=/projects/tir5/data/speech_corpora/babel/BABEL_OP1_102/
    BABEL_103=/projects/tir5/data/speech_corpora/babel/BABEL_OP1_103/
    BABEL_104=/projects/tir5/data/speech_corpora/babel/BABEL_BP_104/
    BABEL_105=/projects/tir5/data/speech_corpora/babel/IARPA-babel105b-v0.5-build/BABEL_BP_105/
    BABEL_106=/projects/tir5/data/speech_corpora/babel/BABEL_BP_106/
    BABEL_107=/projects/tir5/data/speech_corpora/babel/BABEL_BP_107/
    BABEL_201=/projects/tir5/data/speech_corpora/babel/IARPA-babel201b-v0.2b.build/BABEL_OP1_201/
    BABEL_202=/projects/tir5/data/speech_corpora/babel/IARPA-babel202b-v1.0d-build/BABEL_OP2_202/
    BABEL_203=/projects/tir5/data/speech_corpora/babel/IARPA-babel203b-v3.1a-build/
    BABEL_204=/projects/tir5/data/speech_corpora/babel/BABEL_OP1_204/
    BABEL_205=/projects/tir5/data/speech_corpora/babel/IARPA-babel205b-v1.0a-build/BABEL_OP2_205/
    BABEL_206=/projects/tir5/data/speech_corpora/babel/BABEL_OP1_206/
    BABEL_207=/projects/tir5/data/speech_corpora/babel/IARPA-babel207b-v1.0e-build/BABEL_OP2_207/
    BABEL_301=/projects/tir5/data/speech_corpora/babel/IARPA-babel301b-v2.0b-build/BABEL_OP2_301/
    BABEL_302=/projects/tir5/data/speech_corpora/babel/IARPA-babel302b-v1.0a-build/BABEL_OP2_302/
    BABEL_303=/projects/tir5/data/speech_corpora/babel/IARPA-babel303b-v1.0a/BABEL_OP2_303/
    BABEL_304=/projects/tir5/data/speech_corpora/babel/IARPA-babel304b-v1.0b/BABEL_OP2_304/
    BABEL_305=/projects/tir5/data/speech_corpora/babel/IARPA-babel305b-v1.0c-build/BABEL_OP3_305/
    BABEL_306=/projects/tir5/data/speech_corpora/babel/IARPA-babel306b-v2.0c-build/BABEL_OP3_306/
    BABEL_307=/projects/tir5/data/speech_corpora/babel/IARPA-babel307b-v1.0b-build/BABEL_OP3_307/
    BABEL_401=/projects/tir5/data/speech_corpora/babel/IARPA-babel401b-v2.0b-build/BABEL_OP3_401/
    BABEL_402=/projects/tir5/data/speech_corpora/babel/IARPA-babel402b-v1.0b-build/BABEL_OP3_402/
    BABEL_403=/projects/tir5/data/speech_corpora/babel/IARPA-babel403b-v1.0b-build/BABEL_OP3_403/
    BABEL_404=/projects/tir5/data/speech_corpora/babel/IARPA_BABEL_OP3_404/
    GRABO=/projects/tir5/data/speech_corpora/Grabo
    IWSLT14=/projects/tir5/data/iwslt14
    IWSLT22_DIALECT=/projects/tir5/data/speech_corpora/LDC2022E01_IWSLT22_Tunisian_Arabic_Shared_Task_Training_Data/
    PRIMEWORDS_CHINESE=/projects/tir5/data/speech_corpora/Primewords_Chinese
    FISHER_CALLHOME_SPANISH=/projects/tir5/data/speech_corpora/fisher_callhome_spanish
    DSING=/projects/tir5/data/speech_corpora/sing_300x30x2
    MS_INDIC_IS18=/projects/tir6/general/cnariset/corpora/microsoft_speech_corpus_indian_languages
fi
=======
TALROMUR=/work/gunnar/talromur
>>>>>>> 07d151cce (add talromur to db.sh)
=======
TALROMUR=downloads
>>>>>>> 2f2ed4bfd (Add talromur recipe)

# For only JHU environment
if [[ "$(hostname -d)" == clsp.jhu.edu ]]; then
    AIDATATANG_200ZH=downloads
    AISHELL=
    AISHELL3=downloads
    ALFFA=downloads
    AN4=
    DIRHA_ENGLISH_PHDEV=
    DIRHA_WSJ=
    DIRHA_WSJ_PROCESSED="${PWD}/data/local/dirha_wsj_processed"  # Output file path
    DNS=
    WSJ0=
    WSJ1=
    WSJCAM0=/export/corpora3/LDC/LDC95S24/wsjcam0
    REVERB=/export/corpora5/REVERB_2014/REVERB
    REVERB_OUT="${PWD}/REVERB"  # Output file path
    CHIME3=
    CHIME4=
    CSJDATATOP=/export/corpora5/CSJ/USB
    CSJVER=usb  ## Set your CSJ format (dvd or usb).
                ## Usage    :
                ## Case DVD : We assume CSJ DVDs are copied in this directory with the names dvd1, dvd2,...,dvd17.
                ##            Necessary directory is dvd3 - dvd17.
                ##            e.g. $ ls $CSJDATATOP(DVD) => 00README.txt dvd1 dvd2 ... dvd17
                ##
                ## Case USB : Necessary directory is MORPH/SDB and WAV
                ##            e.g. $ ls $CSJDATATOP(USB) => 00README.txt DOC MORPH ... WAV fileList.csv
                ## Case merl :MERL setup. Necessary directory is WAV and sdb
    CSMSC=downloads
    CSS10=
    HKUST1=
    HKUST2=
    HUI_ACG=downloads
    HUB4_SPANISH=
    LABOROTV=
    TEDXJP=
    LIBRISPEECH=
    FSC=
    SNIPS= # smart-light-en-closed-field data path
    SLURP=
    MINI_LIBRISPEECH=downloads
    LIBRITTS=
    LJSPEECH=downloads
    JMD=downloads
    JSSS=downloads
    JSUT=downloads
    JVS=downloads
    KSS=
    THCHS30=downloads
    TIMIT=
    TSUKUYOMI=downloads
    VOXFORGE=
    AMI=/export/corpora4/ami/amicorpus
    COMMONVOICE=downloads
    BABEL_101=/export/babel/data/101-cantonese
    BABEL_102=/export/babel/data/102-assamese
    BABEL_103=/export/babel/data/103-bengali
    BABEL_104=/export/babel/data/104-pashto
    BABEL_105=/export/babel/data/105-turkish
    BABEL_106=/export/babel/data/106-tagalog
    BABEL_107=/export/babel/data/107-vietnamese
    BABEL_201=/export/babel/data/201-haitian
    BABEL_202=/export/babel/data/202-swahili/IARPA-babel202b-v1.0d-build/BABEL_OP2_202
    BABEL_203=/export/babel/data/203-lao
    BABEL_204=/export/babel/data/204-tamil
    BABEL_205=/export/babel/data/205-kurmanji/IARPA-babel205b-v1.0a-build/BABEL_OP2_205
    BABEL_206=/export/babel/data/206-zulu
    BABEL_207=/export/babel/data/207-tokpisin/IARPA-babel207b-v1.0e-build/BABEL_OP2_207
    BABEL_301=/export/babel/data/301-cebuano/IARPA-babel301b-v2.0b-build/BABEL_OP2_301
    BABEL_302=/export/babel/data/302-kazakh/IARPA-babel302b-v1.0a-build/BABEL_OP2_302
    BABEL_303=/export/babel/data/303-telugu/IARPA-babel303b-v1.0a-build/BABEL_OP2_303
    BABEL_304=/export/babel/data/304-lithuanian/IARPA-babel304b-v1.0b-build/BABEL_OP2_304
    BABEL_305=/export/babel/data/305-guarani/IARPA-babel305b-v1.0b-build/BABEL_OP3_305
    BABEL_306=/export/babel/data/306-igbo/IARPA-babel306b-v2.0c-build/BABEL_OP3_306
    BABEL_307=/export/babel/data/307-amharic/IARPA-babel307b-v1.0b-build/BABEL_OP3_307
    BABEL_401=/export/babel/data/401-mongolian/IARPA-babel401b-v2.0b-build/BABEL_OP3_401
    BABEL_402=/export/babel/data/402-javanese/IARPA-babel402b-v1.0b-build/BABEL_OP3_402
    BABEL_403=/export/babel/data/403-dholuo/IARPA-babel403b-v1.0b-build/BABEL_OP3_403
    BABEL_404=/export/corpora/LDC/LDC2016S12/IARPA_BABEL_OP3_404
    PUEBLA_NAHUATL=
    TEDLIUM2=downloads
    TEDLIUM3=downloads
    VCTK=downloads
    VIVOS=
    YESNO=
    YOLOXOCHITL_MIXTEC=downloads
    HOW2_TEXT=
    HOW2_FEATS=
    ZEROTH_KOREAN=downloads
    LRS2=
    JAVA=
    BENGALI=
    RU_OPEN_STT=downloads
    RUSLAN=downloads
    SIWIS=downloads
    SUNDA=
    CMU_INDIC=
    INDIC_SPEECH=
    JKAC=
    MUCS_SUBTASK1=downloads
    MUCS_SUBTASK2=downloads
    GAMAYUN=downloads
    IWSLT21LR=downloads/iwslt21
    TOTONAC=downloads
    GOOGLEI18N=downloads
    MALAYALAM=

fi
