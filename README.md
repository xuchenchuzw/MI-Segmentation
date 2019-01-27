# MI-Segmentation

## Requirements
This code is written for the Matlab (tested with versions R2014a-2014b) and Python (2.7) interpreter and requires the Matlab Image Processing Toolbox and the Keras.
- For the localization of the ROI, please download the [Faster-rcnn](https://github.com/jinfagang/keras_frcnn).
- Additionally, FullFlow is to download from https://cqf.io/fullflow/Full_Flow_Source_Code.zip
- Piotr's Matlab Toolbox (version 3.26 or later) written by Piotr Dollar is also required.

## Train New Dataset

To train a new dataset is also very simple and straight forward. Simply convert your cropped ROI by:
- 11x11_builder.m
- flow_builder.m

Then, running the train.py
