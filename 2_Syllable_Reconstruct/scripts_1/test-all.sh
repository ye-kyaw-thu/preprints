#!/bin/bash

# Testing
cd ./co-bg/model.tf.co2bg/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.co2kh/;
./test-eval.sh
cd ../..;

# cd ./co-bg/model.tf.co2my/;
#./test-eval.sh
#cd ../..;

cd ./co-bg/model.tf.co2hi/;
./test-eval.sh
cd ../..;

cd ./co-bg/model.tf.co2lo/;
./test-eval.sh
cd ../..;

cd ./co-bg/model.tf.co2th/;
./test-eval.sh
cd ../..;

# for vo-sys

# Testing

cd ./co-bg/model.tf.vo2bg/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.vo2kh/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.vo2my/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.vo2hi/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.vo2lo/;
./test-eval.sh;
cd ../..;

cd ./co-bg/model.tf.vo2th/;
./test-eval.sh;
cd ../..;
