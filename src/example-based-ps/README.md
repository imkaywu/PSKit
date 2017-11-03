## Source code

- `main_svbrdf`: example-based PS for objects with spatially-varying BRDF

- `main_ivbrdf`: example-based PS for objects with invariant BRDF

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