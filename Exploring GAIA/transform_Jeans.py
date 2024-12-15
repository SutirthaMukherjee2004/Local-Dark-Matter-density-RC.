import numpy as np
import matplotlib.pyplot as plt
from astropy.io import ascii
import astropy.coordinates as coord 
import astropy.units as u


U_sun = 11.1 * u.km/u.s
V_sun = 245.8 * u.km/u.s
W_sun = 7.8 * u.km/u.s
R0 = 8.122 * u.kpc
z_sun = 25 * u.pc


def transform(ra, dec, parallax, pmra, pmdec, radial_velocity, representation='cartesian'):
	"""
		Transforms from Heliocentric 6D phase space to Galactocentric frame.
		The XYZ axes are defined as in Bhattacharjee et.al. 2014:
			X: in the direction of rotation of the galactic disk.
			Y: direction from Galactic Centre to Sun
			Z: Forms a right handed coordinate system with above. 
		The UVW coordinates are defined as follows:
			U: Sun to Galactic Centre (-Y)
			V: Direction of rotation of the galactic disk (X)
			W: Forms a right handed coordinate system with above (Z)
		Z (and W) point to the NGP, and are antiparallel to the angular momentum of the disk. 
		This convention is different from the usual astropy convention, as is clear from the code. 

		This function accepts only astropy quantities as inputs (i.e. value*u.unit)
	"""
	# Define distance, from the parallax value
	distance = (1/parallax.to(u.mas).value) * u.kpc
	# Define SkyCoord instances for the entire array 
	coords = coord.SkyCoord(ra = ra, dec = dec, distance = distance, pm_ra_cosdec = pmra, pmdec = pmdec, radial_velocity = radial_velocity)
	# Defining the velocity vectors of the Sun as seen from the Galactic Centre
	velocity_sun = coords.CartesianDifferential([U_sun, V_sun, W_sun])

	# Coordinates in the galactocentric frame
	galactocentric_coords = coords.transform_to(coord.Galactocentric(z_sun = z_sun, galcen_distance = R0, galcen_v_sun = velocity_sun))

	# Define the velocities in the Astropy Convention
	vx = galactocentric_coords.v_x.value
	vy = galactocentric_coords.v_y.value
	vz = galactocentric_coords.v_z.value

	# Define the coordinates in the Astropy Convention
	galx = galactocentric_coords.x.value
	galy = galactocentric_coords.y.value
	galz = galactocentric_coords.z.value

	# Defining coordinates and velocities in the convention of Bhattacharjee et. al.
	x = galy 
	y = -galx
	z = galz

	U = vx
	V = vy
	W = vz

	if representation=='cartesian':
		return x,y,z,U,V,W
	elif representation=='spherical':
		theta = np.arctan2((galx**2+galy**2)**0.5, galz)
		phi = np.arctan2(-galx,galy)
		Vr = (-U*np.sin(phi)+V*np.cos(phi))*np.sin(theta) + W*np.cos(theta)
		Vtheta = (-U*np.sin(phi) + V*np.cos(phi))*np.cos(theta) - W*np.sin(theta)
		Vphi = U*np.cos(phi)+V*np.sin(phi)
		return x,y,z, Vr, Vtheta, Vphi


def confidence_limits(array, n_sigma, bins=50):
	"""
		Return the 68%, 95% or 99% confidence intervals of the measurements of a value. 
		This is used for the error estimation
	"""
	lim = 0.5*(1-[0.6827,0.9545,0.9973][n_sigma-1])
	counts, bin_edges = np.histogram(array, bins=bins)
	bins = 0.5*(bin_edges[1:] + bin_edges[:-1])
	dist = np.cumsum(counts)/np.sum(counts)
	lower = array.mean() - bins[np.argmin(np.abs(dist-lim))] 
	upper = array.mean() - bins[np.argmin(np.abs(dist-1+lim))]
	return 0.5*(upper-lower), lower, upper

def bin_tracers(R, V1, V2, V3, bin_edges):
	"""
		Bin the tracers into radial bins, and find the average velocities and velocity dispersions in each bin

		num_tracers, R_bin, mean_V1, mean_V2, mean_V3, sig_V1, sig_V2, sig_V3 = np.array(binned_data).T
	"""
	ind = np.digitize(R, bin_edges)
	binned_data = []
	for i in range(1, bin_edges.size):
		num_tracers = R[ind==i].size
		R_bin = R[ind==i].mean()
		mean_V1 = np.mean(V1[ind==1])
		mean_V2 = np.mean(V2[ind==1])
		mean_V3 = np.mean(V3[ind==1])
		sig_V1 = np.std(V1[ind==1])
		sig_V2 = np.std(V2[ind==1])
		sig_V3 = np.std(V3[ind==1])
		binned_data.append([num_tracers, R_bin, mean_V1, mean_V2, mean_V3, sig_V1, sig_V2, sig_V3])

	return np.array(binned_data)

def sample(mean, sigma, sample_size):
    sample_ = mean*np.ones((sample_size,1)) + sigma*np.ones((sample_size,1))*np.random.standard_normal((sample_size,1))
    return sample_


def mc_loop(outfile, ra, e_ra, dec, e_dec, parallax, e_parallax, pmra, e_pmra, pmdec, e_pmdec, radial_velocity, e_radial_velocity, bin_edges, iterations=100, representation='spherical'):
	"""
		Run the loop:
			1. ra, dec, parallax, pmra, pmdec, radial_velocity ==> x, y, z, U, V, W (or Vr, Vtheta, Vphi)
			2. Bin tracers radially, and find the mean velocities and velocity dispersions
			3. Save the resultant 2D array to a fits file (outfile). Shape is (iterations, 8) 
	"""
	ra_array = sample(ra, e_ra, iterations)
	dec_array = sample(dec, e_dec, iterations)
	parallax_array = sample(parallax, e_parallax, iterations)
	pmra_array = sample(pmra, e_pmra, iterations)
	pmdec_array = sample(pmdec, e_pmdec, iterations)
	radial_velocity_array = sample(radial_velocity, e_radial_velocity, iterations)

	for i in range(iterations):
		# We will call the variables Vr, Vtheta, Vphi. If representation is cartesian, then it is U, V, W
		x, y, z, Vr, Vtheta, Vphi = transform(ra_array[i], dec_array[i], parallax_array[i], pmra_array[i], pmdec_array[i], radial_velocity_array[i], representation=representation)
		R = np.sqrt(x**2 + y**2 + z**2)
		binned_data = bin_tracers(R, Vr, Vtheta, Vphi, bin_edges)
		