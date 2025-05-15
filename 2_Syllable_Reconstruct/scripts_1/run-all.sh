#!/bin/bash

# for Consonants to Syllables
./tf.cobg.sh;
./tf.cokh.sh;
#./tf.comy.sh
./tf.cohi.sh;
./tf.colo.sh;
./tf.coth.sh;

# Testing 
./co-bg/model.tf.co2bg/test-eval.sh
./co-bg/model.tf.co2kh/test-eval.sh
#./co-bg/model.tf.co2my/test-eval.sh
./co-bg/model.tf.co2hi/test-eval.sh
./co-bg/model.tf.co2lo/test-eval.sh
./co-bg/model.tf.co2th/test-eval.sh

# for Vowels to Syllables
./tf.vobg.sh;
./tf.vokh.sh;
#./tf.vomy.sh
./tf.vohi.sh;
./tf.volo.sh;
./tf.voth.sh;

# Testing
./vo-bg/model.tf.vo2bg/test-eval.sh
./vo-bg/model.tf.vo2kh/test-eval.sh
./vo-bg/model.tf.vo2my/test-eval.sh
./vo-bg/model.tf.vo2hi/test-eval.sh
./vo-bg/model.tf.vo2lo/test-eval.sh
./vo-bg/model.tf.vo2th/test-eval.sh
