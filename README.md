# Contour score

This repository contains the Matlab implementation of the metrics described in [1].
This contour score has bean used to compare contours with each other, using a truncated distance-based approach.

### Usage:

```
[score, scoreStructure] = ContourScore(A, B, dmax, DT_A, DT_B)
```

This is the main function that returns *score*, the contour score between A and B, and a strcture *scoreStructure* which separate every part of the score.
*A* and *B* should be binary images. You can use **convertPolyLineIntoBinaryImage** to convert a polyline into a binary image.

The **demo.m** file illustrates an example use with vizualization.

### Reference
If you find the code useful, please cite the following paper:

[1]
```
@article{franccois2020detecting,
  title={Detecting the occluding contours of the uterus to automatise augmented laparoscopy: score, loss, dataset, evaluation and user study},
  author={Fran{\c{c}}ois, Tom and Calvet, Lilian and Zadeh, Sabrina Madad and Saboul, Damien and Gasparini, Simone and Samarakoon, Prasad and Bourdel, Nicolas and Bartoli, Adrien},
  journal={International journal of computer assisted radiology and surgery},
  volume={15},
  number={7},
  pages={1177--1186},
  year={2020},
  publisher={Springer}
}
```
