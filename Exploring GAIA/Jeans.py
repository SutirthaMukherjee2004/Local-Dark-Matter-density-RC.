import numpy as np
import matplotlib.pyplot as plt 
from astropy.io import ascii

from scipy.optimize import curve_fit
import rotation_curve as rc 

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('infile', help='ascii file to input containing data', type=str)
parser.add_argument('--outpath', default='./', help='Outpath to save images', type=str)
args = parser.parse_args()

# read data:
# RA, DEC (degrees)
# l, b (degrees)
# dist, e_dist (kpc)
# pmra, e_pmra (mas/yr)
# pmdec, e_pmdec (mas/yr)
# pm_radec_corr 
# rv, e_rv (km/s)

data = ascii.read(args.infile)
ra, dec, l, b, dist, e_dist, pmra, e_pmra, pmdec, e_pmdec, pm_corr, rv, e_rv = data.T 

R, eR, U, V, W, cov_matrix = rc.rotation_curve(data,  U_peculiar=11.1, V_peculiar=245.8, W_peculiar=7.8, V0=0, R0 = 8.122)

eU = np.sqrt(np.array([cov_matrix[i][0,0] for i in range(len(cov_matrix))]))
eV = np.sqrt(np.array([cov_matrix[i][1,1] for i in range(len(cov_matrix))]))
eW = np.sqrt(np.array([cov_matrix[i][2,2] for i in range(len(cov_matrix))]))

threshold = 5
sel2 = (np.abs(eU/U)<threshold)&(np.abs(eV/V)<threshold)&(np.abs(eW/W)<threshold)

R = R[sel2]
eR = eR[sel2]
U = U[sel2]
V = V[sel2]
W = W[sel2]

R_sorted = np.sort(R)

# All data
x = (dist*np.cos(np.deg2rad(b))*np.sin(np.deg2rad(l)))[sel2]
y = (R0 - dist*np.cos(np.deg2rad(b))*np.cos(np.deg2rad(l)))[sel2]
z = (dist*np.sin(np.deg2rad(b)))[sel2]

theta = np.arctan2((x**2+y**2)**0.5, z)
phi = np.arctan2(y,x)

def transformation(vec, t_matrix, cov_matrix):
    transformed_vec = np.einsum('ijk,kj->ki',t_matrix,vec)
    transformed_cov_matrix = np.einsum('mik,ilk->mlk',t_matrix,np.einsum('ijk,jlk->ilk',cov_matrix,np.transpose(t_matrix,[1,0,2])))
    return transformed_vec, transformed_cov_matrix


a_  = np.array([[-np.sin(phi)*np.sin(theta), np.cos(phi)*np.sin(theta), np.cos(theta)],\
          [-np.sin(phi)*np.cos(theta), np.cos(phi)*np.cos(theta), -np.sin(theta)],\
          [np.cos(phi), np.sin(phi), np.zeros_like(phi)]])

c_ = np.transpose(np.array(cov_matrix)[sel2], (1,2,0))

trans_vec, trans_cov_matrix = transformation(np.c_[U,V,W], a_, c_)

Vr, Vtheta, Vphi = trans_vec.T

ind = np.where((np.abs(Vtheta)>500)|(np.abs(Vphi)>500)|(np.abs(Vr)>500))
trans_cov_matrix = np.delete(trans_cov_matrix, ind, axis=2)
R = np.delete(R, ind, axis = 0)
eR = np.delete(eR, ind, axis = 0)
trans_vec = np.delete(trans_vec, ind, axis=0)
Vr, Vtheta, Vphi = trans_vec.T


eVr = np.sqrt(trans_cov_matrix[0,0,:])
eVtheta = np.sqrt(trans_cov_matrix[1,1,:])
eVphi = np.sqrt(trans_cov_matrix[2,2,:])


def density_dispersion(data, n_tracers=250):
    bin_edges = np.r_[R_sorted[::n_tracers]]
    R_, eR_, Vr_, Vtheta_, Vphi_ = data.T
    ntr = np.histogram(R_, bins=bin_edges)[0]
    dr = bin_edges[1:]-bin_edges[:-1]
    R_bins = 0.5*(bin_edges[1:]+bin_edges[:-1])
    dens_tr = ntr/(4*np.pi*R_bins**2*dr)
    
    sigR, sigtheta, sigphi = [],[],[]
    for i in range(bin_edges.size-1):
        ind = np.where((R_>=bin_edges[i])&(R_<bin_edges[i+1]))
        Vr_bin = Vr_[ind]
        Vtheta_bin = Vtheta_[ind]
        Vphi_bin = Vphi_[ind]
        sigR = np.append(sigR,np.std(Vr_bin))
        sigtheta = np.append(sigtheta,np.std(Vtheta_bin))
        sigphi = np.append(sigphi,np.std(Vphi_bin))
        
    return dens_tr, R_bins, dr, sigR, sigtheta, sigphi


sample_size= 5000

# Gaussian Error-bars
Vr_array = Vr*np.ones((sample_size, 1))+eVr*(np.random.standard_normal((sample_size, 1)))
Vtheta_array = Vtheta*np.ones((sample_size, 1)) + eVtheta*(np.random.standard_normal((sample_size, 1)))
Vphi_array = Vphi*np.ones((sample_size, 1)) + eVphi*(np.random.standard_normal((sample_size, 1)))

dens_tr_array = []
R_bins_array = []
dr_array = []
sigR_array = []
sigtheta_array = []
sigphi_array = []


for i in range(sample_size):
    data_jeans = np.c_[R,eR,Vr_array[i,:],Vtheta_array[i,:],Vphi_array[i,:]]
    dens_tr, R_bins, dr, sigR, sigtheta, sigphi = density_dispersion(data_jeans)
    dens_tr_array.append(dens_tr)
    R_bins_array.append(R_bins)
    dr_array.append(dr)
    sigR_array.append(sigR)
    sigtheta_array.append(sigtheta)
    sigphi_array.append(sigphi)


dens_tr_array = np.array(dens_tr_array)
R_bins_array = np.array(R_bins_array)
dr_array = np.array(dr_array)
sigR_array = np.array(sigR_array)
sigtheta_array = np.array(sigtheta_array)
sigphi_array = np.array(sigphi_array)

sigT_array = np.sqrt(0.5*(sigtheta_array**2+sigphi_array**2))
anisotropy_array = 1 - sigT_array**2/sigR_array**2

beta, ebeta = [], []
for i in range(anisotropy_array.shape[1]):
    beta = np.append(beta, anisotropy_array[:,i].mean())
    ebeta = np.append(ebeta, anisotropy_array[:,i].std())

np.savetxt('{}Anisotropy.txt'.format(args.outpath), np.c_[beta, ebeta], fmt='%s', delimiter=',', header='Anisotropy, Error')


def line(x, m, c): return m*x+c
m_dens_tr_array, c_dens_tr_array = [], []
m_sigR_array, c_sigR_array = [], []

for i in range(sample_size):
    (m_dens_tr, c_dens_tr), perr = curve_fit(line, np.log10(R_bins_array[i,:]), np.log10(dens_tr_array[i,:]))
    (m_sigR, c_sigR), perr = curve_fit(line, np.log10(R_bins_array[i,:]), np.log10(sigR_array[i,:]**2))
    m_dens_tr_array = np.append(m_dens_tr_array, m_dens_tr)
    c_dens_tr_array = np.append(c_dens_tr_array, c_dens_tr)
    m_sigR_array = np.append(m_sigR_array, m_sigR)
    c_sigR_array = np.append(c_sigR_array, c_sigR)


dens_tr = []
e_dens_tr = []

for i in range(dens_tr_array.shape[1]):
    dens_tr = np.append(dens_tr, dens_tr_array[:,i].mean())
    e_dens_tr = np.append(e_dens_tr, dens_tr_array[:,i].std())

m_dens_tr = m_dens_tr_array.mean()
m_sigR = m_sigR_array.mean()

sigR = []
e_sigR = []

for i in range(sigR_array.shape[1]):
    sigR = np.append(sigR, sigR_array[:,i].mean())
    e_sigR = np.append(e_sigR, sigR_array[:,i].std())


v_circular = np.sqrt(-sigR**2*(m_dens_tr+m_sigR+2*(beta)))
e_v_circular = np.sqrt(e_sigR**2/sigR**2*v_circular**2 + ebeta**2*sigR**4/v_circular**2)

np.savetxt('{}Rotation_Curve.txt', np.c_[R_bins, v_circular, e_v_circular], fmt='%s', delimiter=',', header='R, V, eV')
