#!/bin/bash

## Written by Ye Kyaw Thu, LST, NECTEC, Thailand
## Experiments for co-my, Transformer
## Date: 28 Feb 2025

## Old Notes
#     --mini-batch-fit -w 10000 --maxi-batch 1000 \
#    --mini-batch-fit -w 1000 --maxi-batch 100 \
#     --tied-embeddings-all \
#     --tied-embeddings \
#     --valid-metrics cross-entropy perplexity translation bleu \
#     --transformer-dropout 0.1 --label-smoothing 0.1 \
#     --learn-rate 0.0003 --lr-warmup 16000 --lr-decay-inv-sqrt 16000 --lr-report \
#     --optimizer-params 0.9 0.98 1e-09 --clip-norm 5 \

model_folder="model/model.tf.rm2lo";
mkdir -p ${model_folder};
data_path="/home/ye/exp/nmt/cv-predict/data/random/two-del/rm-lo";
src="rm"; tgt="sy";

marian \
    --model ${model_folder}/model.npz --type transformer \
    --train-sets ${data_path}/train.${src} ${data_path}/train.${tgt} \
    --max-length 200 \
    --vocabs ${data_path}/vocab/vocab.${src}.yml  ${data_path}/vocab/vocab.${tgt}.yml \
    --mini-batch-fit -w 1000 --maxi-batch 100 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 500 \
    --valid-metrics cross-entropy perplexity bleu \
    --valid-sets ${data_path}/dev.${src} ${data_path}/dev.${tgt} \
    --valid-translation-output ${model_folder}/valid.${src}-${tgt}.output \
    --quiet-translation \
    --valid-mini-batch 64 \
    --beam-size 6 --normalize 0.6 \
    --log ${model_folder}/train.log \
    --valid-log ${model_folder}/valid.log \
    --enc-depth 2 --dec-depth 2 \
    --transformer-heads 8 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.3 --label-smoothing 0.1 \
    --learn-rate 0.0003 --lr-warmup 0 --lr-decay-inv-sqrt 16000 --lr-report \
    --clip-norm 5 \
    --tied-embeddings \
    --devices 0 --sync-sgd --seed 1111 \
    --exponential-smoothing \
    --dump-config > ${model_folder}/${src}-${tgt}.config.yml

time marian -c ${model_folder}/${src}-${tgt}.config.yml 2>&1 | tee ${model_folder}/tf.${src}-${tgt}.log

