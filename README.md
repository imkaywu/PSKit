# Photometric Stereo Toolkit

## Dependencies
* Matlab
* Flann

## Download
Clone this repository and download data.
```
git clone https://github.com/imkaywu/PSKit
cd PSKit
```

## Dataset
For the structure of datasets of example-based photometric stereo, please visit [here](https://imkaywu.github.io/3drecon_dataset/dataset) for details.


## Source code

### `DfN`: multiple algorithm to integrate a surface from normal/gradient map

- `compute_heightMap`: compute the height map based on normal map and mask using linear least squares

- `integrate_horn2: estimate height map using Horn's method

- `DepthFromGradient`: estimate height map from gradient map, from Ying Xiong's DfGBox

### `include/`:

- `decode`: decode from RGB image to normal map;

- `encode`: encode from normal map to RGB image;

- `esti_surf`: estimate height map from normal map

- `gen_normals`: generate uniformly distributed normals

- `read_normals`: read normals from a text file

- `show_surfNorm`: display the surface normal

- `nmap2norm`: transform Px3 normal matrix to MxNx3 normal map

- `norm2nmap`: transform MxNx3 normal map to Px3 normal matrix

### `io/`:

- `write_ply`: write vertex and color information into a PLY file

### `src/`: contains source code for various PS algorithms

## Demo
run `main_svbrdf` and `main_lls_ps`.

## Results
![height map buddha](doc/hmap_buddha.png)
![arrow map buddha](doc/arrowmap_buddha.png)
![nmap buddha](doc/normal_buddha.png)
![height map cat](doc/hmap_cat.png)
![arrow map cat](doc/arrowmap_cat.png)
![nmap cat](doc/normal_cat.png)


## License
MIT