import astropy.units as u
from astropy.coordinates import SkyCoord, Galactocentric
import numpy as np
import seaborn as sns 
import pandas as pd
import matplotlib.pyplot as plt
file_path=r"table-2.csv"
cep=pd.read_csv(file_path)
ra_array = np.array(cep['ra']) * u.degree
dec_array = np.array(cep['dec']) * u.degree
distance_array = (np.array(cep['parallax']) * u.mas).to(u.kpc, u.parallax())
pm_ra_cosdec_array = np.array(cep['pmra']) * u.mas / u.yr
pm_dec_array = np.array(cep['pmdec']) * u.mas / u.yr
radial_velocity_array = np.array(cep['radial_velocity']) * u.km / u.s
l=np.array(cep['l']) * u.degree
b=np.array(cep['b']) * u.degree 

