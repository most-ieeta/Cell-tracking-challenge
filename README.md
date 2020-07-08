# Cell-tracking-challenge


The [Cell Tracking Challenge](http://celltrackingchallenge.net/) is a regular challenge on whole-cell and nucleus segmentation and tracking. It provides several datasets of video sequences on nuclei or cells moving.

We processed the following 2D datasets available at the [Cell Tracking Challenge website](http://celltrackingchallenge.net/):

- BF-C2DL-HSC
- BF-C2DL-MuSC
- DIC-C2DH-HeLa
- Fluo-C2DL-MSC
- Fluo-N2DH-GOWT1
- Fluo-N2DH-SIM+
- Fluo-N2DL-HeLa
- PhC-C2DH-U373
- PhC-C2DL-PSC

Each dataset has two sequences of images and ground truth, gold truth and silver truth data annotations are available depending on the dataset. We extracted the contours of the moving nuclei and cells from the datasets and created the WKT (well-Known Text Representations) of such moving objects. Then, use merged the WKT representations of each moving object in a single file, using the format accepted by [SPT Data Lab](https://github.com/most-ieeta/SPT-DataLab) to create the moving regions representations for in-between observations.

We also created SQL files that may be used to load the cells' representations into PostgreSQL and that uses PostGIS object datatype to represent the whole-cells / nucleus contours.

In this repository, we make available the SQL scripts and WKT representations of such moving objects, and also the scripts used to generate such representations.

## How we built the SQL and WKT representations



## How to use the SQL files



## How to use the WKT representations in SPT Data Lab




## MoST Project

This repository is part of the MoST Project. It is being developed at IEETA (Institute of Electronics and Informatics Engineering of Aveiro) and DETI (Departament of Electronic, Telecommunications and Informatics) from the University of Aveiro (www.ua.pt) and is partially funded by National Funds through the FCT (Foundation for Science and Technology) in the context of projects UID/CEC/00127/2013 and POCI-01-0145-FEDER-032636.
