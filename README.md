# FocalLossOptimization

Pytorch  implementation of RetinaNet object detection as described in [Focal Loss for Dense Object Detection](https://arxiv.org/abs/1708.02002) by Tsung-Yi Lin, Priya Goyal, Ross Girshick, Kaiming He and Piotr Dollár.

This implementation is modified so that the loss parameters are related in a power relation decreasing the degree of freedom from two to one. If the balancing parameter is chosen to be the inverse class frequencies, then the degree of freedom drops down to zero. The focal parameter is expressed in terms of the balancing parameter in the form:

![img1](https://github.com/mert-acar/FocalLossOptimization/blob/main/1.png)

with the parameters

![img2](https://github.com/mert-acar/FocalLossOptimization/blob/main/2.png)


## Installation

1) Clone this repo

2) Install the required packages:

```
apt-get install tk-dev python-tk
```

3) Install the python packages:
    
```
pip install pandas
pip install pycocotools
pip install opencv-python
pip install requests

```

## Data

The datasets can be found in the following links:
+ COCO Dataset: http://cocodataset.org
+ TACO Dataset: http://tacodataset.org

## Training

The network can be trained using the `train.py` script. Currently, two dataloaders are available: COCO and CSV. For training on coco, use

```
python train.py --dataset coco --coco_path ../coco --depth 50
```

For training using a custom dataset, with annotations in CSV format (see below), use

```
python train.py --dataset csv --csv_train <path/to/train_annots.csv>  --csv_classes <path/to/train/class_list.csv>  --csv_val <path/to/val_annots.csv>
```

Note that the --csv_val argument is optional, in which case no validation will be performed.

## Pre-trained model

A pre-trained model is available at: 
- https://drive.google.com/open?id=1yLmjq3JtXi841yXWBxst0coAgR26MNBS (this is a pytorch state dict)

The state dict model can be loaded using:

```
retinanet = model.resnet50(num_classes=dataset_train.num_classes(),)
retinanet.load_state_dict(torch.load(PATH_TO_WEIGHTS))
```
## Results
The results can be seen below,

![img3](https://github.com/mert-acar/FocalLossOptimization/blob/main/3.png)

