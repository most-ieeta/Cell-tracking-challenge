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

We also created SQL files that may be used to load the cells' representations into PostgreSQL and that uses PostGIS's geometry datatype to represent the whole-cells / nucleus contours.

In this repository, we make available the SQL scripts and WKT representations of such moving objects, and also the scripts used to generate such representations.

## How we built the SQL and WKT representations

We developed a tool called [cell_extraction](https://github.com/most-ieeta/preprocessing_extraction) to extract the objects of interest from the dataset. Such tool extracts all the objects contours from an image and store each of them at a WKT file. 

Then, we used the *extract_and_merge* script (available in the *BAT Scripts*) folder to run [cell_extraction](https://github.com/most-ieeta/preprocessing_extraction) to all the images that are in subfolders of the *GT* and *ST* folders of the considered datasets and to generate the WKT files and SQL scripts made available at this repository.

The execution of the *extract_and_merge* to each dataset/GT-ST data series generates thousands of files, organized as in the following: 

- To each dataset:
   - to each ST/GT data series
     - A folder (called *segmented* in the files we make in the available) that contains a file with the WKT representation of each segmented region/frame; 
     - A folder (called *merged* in the files we make in the available) that contains a file for each cell - each file contaning the WKT representations of the cell for several timestamps (as used in SPT Data Lab); 
   - the SQL scripts to load the WKT representations into PostGIS.     


## How to use the SQL files

The [CreateTables file](https://github.com/most-ieeta/Cell-tracking-challenge/blob/master/SQL%20scripts/CreateTables.sql) contains the script to create a table for each dataset. Each table contains three fields: *time* (which indicates the time frame), *name* (which contains the series name and the cell identification) and *object* (which is the object geometry).

The series names contain the information of the original folder of the image. Some examples are *01-ST-SEG*, *02-GT-TRA* and *01-GT-SEG*. 

If you and to query for all the objects of the 01-ST-SEG series in the Fluo-N2DL-HeLa dataset and time 98, than you may use the following query:

```
select name, object from FluoN2DLHeLa  
where TIME = 0 and name like '01-ST-SEG-%'
```

If you and to query for all representations of cell1 of the ST folder in the Fluo-N2DL-HeLa, then you may run the following query:

```
select time, object from FluoN2DLHeLa  
where name like '01-ST-SEG-cell1'
```

If you want to visualize the image in PGAdmin, you should use the ST_RotateX (with pi() rotation) over the object to get the same axis-orientation than the original image.  

## How to use the WKT representations in SPT Data Lab

[SPT Data Lab](https://github.com/most-ieeta/SPT-DataLab) can run spatiotemporal interpolation methods over pairs of files containing a single WKT each or over a file containing several WKT representations (one for each timestamp).

The WKT files folder of this repository contains several Zip files (one for each dataset). In such files, there are folders name *segmented* and *merged* for each time series (i.e. 01-ST-TRA, 01-ST-SEG, ...).  To use the first option available in [SPT Data Lab](https://github.com/most-ieeta/SPT-DataLab) (i.e. pairs of files), you can use the WKT representations available at the *segmented* folders. To use the second option (i.e. a single file that contains several WKT representations of an object - one for each timestamp), you should use the files in the *merged* folders. 

## MoST Project

This repository is part of the **MoST - Modeling, Querying and Interactive Visualization of Spatiotemporal Data** project. This work is being developed at IEETA (Institute of Electronics and Informatics Engineering of Aveiro) and DETI (Departament of Electronic, Telecommunications and Informatics) from the University of Aveiro (www.ua.pt) and is partially funded by National Funds through the FCT (Foundation for Science and Technology) in the context of projects UID/CEC/00127/2013 and POCI-01-0145-FEDER-032636. The institutions participating in this project are the Institute of Electronics and Informatics Engineering of Aveiro (IEETA) and the Research Group on Emissions, Modelling and Climate Change (GEMAC), both from the University of Aveiro, and the INESC TEC.

To more information about the MoST project, visit the [MoST website: http://most.web.ua.pt/](http://most.web.ua.pt/).
