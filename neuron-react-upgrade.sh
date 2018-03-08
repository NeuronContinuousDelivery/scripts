#!/usr/bin/env bash

#公共组件
rm -rf ./src/_common/
mkdir ./src/_common
cp ~/work/neuron/src/github.com/NeuronFramework/ui/web/src/_common/* ./src/_common/

#模版
rm tsconfig.json tsconfig.test.json tslint.json
cp ~/work/neuron/src/github.com/NeuronContinuousDelivery/scripts/react-template/* ./

#npm 升级
npm upgrade