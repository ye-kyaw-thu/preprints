#!/bin/bash

## Written by Ye Kyaw Thu, Affiliated Professor, NECTEC, Thailand
## for NMT Experiments for co-my
## used Marian NMT Framework for seq2seq training
## Last updated: 28 Feb 2025

## Reference: https://marian-nmt.github.io/examples/mtm2017/complex/

model_folder="co-my/model.s2s.vomy";
mkdir -p ${model_folder};
data_path="/home/ye/exp/nmt/cv-predict/data/vo/vo-my";
src="vo"; tgt="sy";


marian \
  --type s2s \
  --train-sets ${data_path}/train.${src} ${data_path}/train.${tgt} \
  --max-length 200 \
  --valid-sets ${data_path}/dev.${src} ${data_path}/dev.${tgt} \
  --vocabs  ${data_path}/vocab/vocab.${src}.yml  ${data_path}/vocab/vocab.${tgt}.yml \
  --model ${model_folder}/model.npz \
  --workspace 500 \
  --enc-depth 2 --enc-type alternating --enc-cell lstm --enc-cell-depth 2 \
  --dec-depth 2 --dec-cell lstm --dec-cell-base-depth 2 --dec-cell-high-depth 2 \
  --tied-embeddings --layer-normalization --skip \
  --mini-batch-fit \
  --valid-mini-batch 32 \
  --valid-metrics cross-entropy perplexity bleu\
  --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
  --dropout-rnn 0.3 --dropout-src 0.3 --exponential-smoothing \
  --early-stopping 10 \
  --log ${model_folder}/train.log --valid-log ${model_folder}/valid.log \
  --devices 0 --sync-sgd --seed 1111  \
  --dump-config > ${model_folder}/vo-my.config.yml

time marian -c ${model_folder}/vo-my.config.yml  2>&1 | tee ${model_folder}/s2s.${src}-${tgt}.log

