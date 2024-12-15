
'''
Transformation.py
Converts proper motion and radial velocities to 3D velocities in the following coordinate systems:

1. Galactocentric UVW Coordinates. For the convention used here, see Bhattacharjee et. al. 2014
2. Galactocentric Cartesian Coordinates. As used in Bhattacharjee et. al. 2014
2. Galactocentric Spherical Coordinates. Based on the Cartesian system as used in Bhattacharjee et. al. 2014

Author: @ved.shenoy
'''

## Log:
# 2019-11-17: Began new iteration of Transformation.py after unfortunate data loss. (@ved.shenoy)
# 


import numpy as np 
import matplotlib.pyplot as plt 
from astropy.io import ascii
from astropy.table import Table 

import argparse, configparser

parser = argparse.ArgumentParser()
parser.add_argument('infile', help='Input file with data to be transformed', type=str)
parser.add_argument('config', help='Config file with constants to be used for transformation', type=str)
parser.add_argument('transform_type', help='Tranform to UVW, XYZ, SPH', type=str)
parser.add_argument('--verbose', help='Verbose output', default=True, type=bool)
args = parser.parse_args()
verb = parser.verbose

if verb:
	print('-----------------------------------------')
	print('Reading Data and Config Files ')

data = ascii.read(args.infile)


ra = np.array(data['ra'])*np.pi/180
dec = np.array(data['dec'])*np.pi/180
l = np.array(data['l'])*np.pi/180
b = np.array(data['b'])*np.pi/180
dist = np.array(data['dist'])
e_dist = np.array(data['e_dist'])
pmra = np.array(data['pmra'])
e_pmra = np.array(data['e_pmra'])
pmdec = np.array(data['pmdec'])
e_pmdec = np.array(data['e_pmdec'])
pm_corr = np.array(data['pm_corr'])
v_r = np.array(data['v_r'])
e_v_r = np.array(data['e_v_r'])


userconf = configparser.ConfigParser()
userconf.read(args.config)
constants =  dict(userconf['constants'])

U_sun, V_sun, W_sun = constants['u_sun'], constants['v_sun'], constants['w_sun']
R0 = constants['r0']
ra_G, dec_G = constants['ra_g'], constants['dec_g']

if verb:
	print('Done!')
	print('-----------------------------------------')


# Propagates error given the Transformation Matrix and the Covariance Matrix of the original measurements
def transformation(vec, t_matrix, cov_matrix):
    transformed_vec = np.einsum('ijk,kj->ki',t_matrix,vec)
    transformed_cov_matrix = np.einsum('mik,ilk->mlk',t_matrix,np.einsum('ijk,jlk->ilk',cov_matrix,np.transpose(t_matrix,[1,0,2])))
    return transformed_vec, transformed_cov_matrix

# For details, refer https://arxiv.org/abs/1306.2945
C1 = (np.sin(dec_G)*np.cos(dec) - np.cos(dec_G)*np.sin(dec)*np.cos(ra-ra_G))
C2 = (np.cos(dec_G)*np.sin(ra-ra_G))
norm = np.linalg.norm([C1,C2], axis=0)
C1/=norm
C2/=norm

tr_matrix = np.array([[C1,C2],[-C2,C1]])
pm_corr_matrix = np.array([[e_pmra**2,pm_corr*e_pmra*e_pmdec],[pm_corr*e_pmra*e_pmdec,e_pmdec**2]])
galactic_pm = transformation(np.c_[pmra,pmdec],tr_matrix,pm_corr_matrix)


