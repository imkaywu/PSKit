## Source code

- `main_svbrdf`: example-based PS for objects with spatially-varying BRDF

- `main_ivbrdf`: example-based PS for objects with invariant BRDF

### `include/`:

	- `decode`: decode from RGB image to normal map;

	- `encode`: encode from normal map to RGB image;

	- `esti_surf`: estimate height map from normal map

	- `gen_normals`: generate uniformly distributed normals

	- `read_normals`: read normals from a text file

	- `show_surfNorm`: display the surface normal

### `include/DfN`: multiple algorithm to integrate a surface from normal/gradient map

	- `compute_heightMap`: compute the height map based on normal map and mask using linear least squares

	- `integrate_horn2: estimate height map using Horn's method

	- `DepthFromGradient`: estimate height map from gradient map, from Ying Xiong's DfGBox

### `io/`:

	- `write_ply`: write vertex and color information into a PLY file

### `src/`:

	- `exap_based_ps_vsbrdf`: implementation of example-based photometric stereo of objects with SVBRDF

	- `normal_esti_coarse2fine_ps`: coarse to fine estimation of surface normal

	- `nnls`: non-negative least squares
	
	- `mex_normal_esti_coarse2fine_ps`: mex file of `normal_esti_coarse2fine_ps`

## Compile
```
cd <root_dir>/src/
mex mex_normal_esti_coarse2fine_ps.cpp normal_esti_coarse2fine_ps.cpp nnls.c -I./ -I<opencv_dir> -I<Eigen_parent_dir> -L<opencv_lib_dir> -lopencv_highguixxxx -lopencv_imgprocxxxx -output normal_esti_coarse2fine_ps
```