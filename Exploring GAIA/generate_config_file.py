config = '''
# Sample config file for Transformation.py
# Comment lines starting with # are ignored
# Do not add extra spaces!
#
# author: ved.shenoy
#
[constants]
#
# Motion of the Sun with respect to the Galactic Centre in km/s
U_sun : 10.1
V_sun : 245.9
W_sun : 7.3
#
# Radial Distance of Sun from Galactic Centre in kpc
R0 : 8.09
#
# Equatorial Coordinates of the North Galactic Pole in decimal degrees
ra_G : 192.85948
dec_G : 27.12825
'''

with open('rotation_curve.config', 'w') as handle:
    handle.write(config)


