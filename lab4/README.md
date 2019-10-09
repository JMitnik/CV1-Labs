# Image Alignment and Stitching
---

Here we perform the task of image alignment and stitching. Image alignment takes two pictures to find the most important points (keypoints) and tries to match the keypoints of both pictures. Then based on these keypoints an alignment method can be used to find a transformation matrix and apply these on either picture to transform to the space of the other. After we have transformed one picture to the other, we can stitch them together at the overlapping regions.

## How to run?
---
1. Setup SIFT feature extractor:
```
>> run('VLFEATROOT/toolbox/vl_setup')
```
2. Run demo_1_image_alignment for a demonstration of image alignment
3. Run demo_stitch for a demonstration of image stitching
4. Due to the stochastic nature of the process, sometimes the results on the images of the tram are not perfect. Run a few times to get the best result.

## Authors
---
1. Pieter de Marez Oyens [10002403]
2. Jonathan Mitnik [10911197]
3. András Csirik [12521620]
4. Aman Hussain [12667447]
