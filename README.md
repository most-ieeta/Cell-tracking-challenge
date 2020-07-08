# Cell-tracking-challenge


The Cell Tracking Challenge is a regular challenge on whole-cell and nucleus segmentation and tracking. It provides several datasets of video sequences on nuclei or cells moving.

We extracted the contours of such nuclei and moving cells from the 2D datasets available at the Cell Tracking Challenge website and created the WKT (well-Known Text Representations) of such moving objects. Then, use merged the WKT representations of each moving object in a single file, using the format accepted by SPT Data Lab to create the moving regions representations for in-between observations.

We also created SQL files that may be used to load the cells' representations into PostgreSQL and that uses PostGIS object datatype to represent the whole-cells / nucleus contours.

In this repository, we make available the SQL scripts and WKT representations of such moving objects, and also the scripts used to generate such representations.
