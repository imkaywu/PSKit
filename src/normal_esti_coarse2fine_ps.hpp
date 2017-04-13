//
//  normal_esti_coarse2fine_ps.hpp
//  pm_stereo
//
//  Created by KaiWu on Sep/9/16.
//  Copyright © 2016 KaiWu. All rights reserved.
//

#ifndef normal_esti_coarse2fine_ps_hpp
#define normal_esti_coarse2fine_ps_hpp

#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include <limits>

#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "Eigen/Dense"
#include "nnls.h"

using std::cout;
using std::endl;
using std::cerr;
using std::vector;

using Eigen::Matrix;
using Eigen::Array;
using Eigen::Matrix3d;
using Eigen::MatrixXi;
using Eigen::MatrixXd;
using Eigen::Vector2i;
using Eigen::Vector2d;
using Eigen::Vector3d;
using Eigen::VectorXi;
using Eigen::VectorXd;

using namespace cv;

double* esti_norm(MatrixXd &OV_tar, vector<MatrixXd> &OV_ref, VectorXi &OV_tar_ind, vector<VectorXi> &OV_ref_ind, Vector2i &size_tar, vector<Vector2i> &size_ref, vector<Vector2d, Eigen::aligned_allocator<Vector2d> > &center, vector<double> &radius);
MatrixXd gen_normals(int num_samp, Vector3d &view_dir, double ang_span);
void ind2sub(Vector2i &imsize, int &ind, int &i, int &j);
void sub2ind(Vector2i &imsize, int &i, int &j, int &ind);
int find_index(VectorXi &array, int key);
int find_index(VectorXi &array, int start, int end, int key);
void write_text(const char * fname, MatrixXd &fdata);
template <typename T>
T read_text(const char * fname);
void read_text(const char *fname, vector<Vector2i> &size_ref, vector<Vector2d, Eigen::aligned_allocator<Vector2d> > &center, vector<double> &radius, Vector2i &size_tar);

template <typename T>
inline vector<size_t> sort_indexes(const vector<T> &v)
{
    // initialize original index locations
    vector<size_t> idx(v.size());
    for (size_t i = 0; i != idx.size(); ++i)
        idx[i] = i;
    
    // sort indexes based on comparing values in v
    sort(idx.begin(), idx.end(),
         [&v](size_t i1, size_t i2) {return v[i1] < v[i2];});
    
    return idx;
}

// not used code
MatrixXd samp_norm(Vector3d &c, int num_samp, Vector3d &view_dir, double ang_span);
Matrix3d rot_norm(Vector3d &z, Vector3d &c);
Matrix3d axisangle2rotmat(Vector3d &axis, double &ang);

#endif /* normal_esti_coarse2fine_ps_hpp */
