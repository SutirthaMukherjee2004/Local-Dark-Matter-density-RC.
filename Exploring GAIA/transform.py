import numpy as np 
import astropy.coordinates as coord
import astropy.units as u 
from astropy.io import ascii

import argparse, configparser

parser = argparse.ArgumentParser(prog='transform.py', description='Given [ra, dec, distance], [pmra_cosdec, pmdec, radial_velocity], transform to a galactocentric cartesian coordinate system')
parser.add_argument('infile', help='File containing column names ra, dec, dist, pmra, pmdec, rad_vel', type=str)
parser.add_argument('config', help='Config File with list of constants. See program for a sample', type=str)
parser.add_argument('outpath', help='Outpath_[positions/velocities].txt', dtype=str)
parser.add_argument('--verbose', default=True, help='Verbose Output', type=bool)
args = parser.parse_args()

verbose = args.verbose


if verbose:
	print('-----------------------------------------')	
	print('Reading Data File')

data = ascii.read(args.infile)
ra = data['ra']
dec = data['dec']
dist = data['dist']
pmra = data['pmra']
pmdec = data['pmdec']
rad_vel = data['rad_vel']

if verbose:
	print('Done')
	print('-----------------------------------------')	


if verbose:
	print('-----------------------------------------')	
	print('Reading Config File')
'''
# Sample config file for Transformation.py
# Comment lines starting with # are ignored
# Do not add extra spaces!
#
# author: ved.shenoy
#
[constants]
#
# Motion of the Sun with respect to the Galactic Centre in km/s
U_sun : 11.1
V_sun : 245.8
W_sun : 7.8
#
# Radial Distance of Sun from Galactic Centre in kpc
R0 : 8.122
#
# Equatorial Coordinates of the North Galactic Pole in decimal degrees
ra_G : 192.85948
dec_G : 27.12825
#
# Distance of Sun from Galactic Mid-plane in pc
z_sun : 25
'''

userconf = configparser.ConfigParser()
userconf.read(args.config)
constants =  dict(userconf['constants'])

U_sun, V_sun, W_sun = float(constants['u_sun']), float(constants['v_sun']), float(constants['w_sun'])
R0 = float(constants['r0'])
ra_G, dec_G = float(constants['ra_g']), float(constants['dec_g'])
z_sun = float(constants['z_sun'])

if verbose:
	print('Done')
	print('-----------------------------------------')	


mas_yr = u.mas/u.year
km_s = u.km/u.second

coords = coord.SkyCoord(ra = ra*u.deg, dec = dec*u.deg, distance = dist*u.kpc, pm_ra_cosdec=pmra*mas_yr, pm_dec = pmdec*mas_yr, radial_velocity=rad_vel*km_s)

v_sun = coord.CartesianDifferential([U_sun, V_sun, W_sun]*u.km/u.s)
galcen = coords.transform_to(coord.Galactocentric(z_sun=z_sun*u.pc, galcen_distance=R0*u.kpc,galcen_v_sun=v_sun))

vx = np.array(galcen.v_x)
vy = np.array(galcen.v_y)
vz = np.array(galcen.v_z)

galx = galcen.x.value
galy = galcen.y.value
galz = galcen.z.value

x = galy 
y = -galx
z = galz

U = vx
V = vy
W = vz

np.savetxt('{}_positions.txt'.format(args.outpath), np.c_[x,y,z], fmt='%s', header='X, Y, Z')
np.savetxt('{}_velocities.txt'.format(args.outpath), np.c_[U,V,W], fmt='%s', header='U,V,W')