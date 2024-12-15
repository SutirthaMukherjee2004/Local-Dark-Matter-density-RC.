import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Parameters from the image
B_n = 1.4  # µG
B_s = -1.1  # µG
r_n = 9.22  # kpc
r_s = 16.7  # kpc
w_h = 0.20  # kpc
z_0 = 5.3  # kpc
B_X = 4.6  # µG
theta_X = np.radians(49)  # Convert degrees to radians
r_X_c = 4.8  # kpc
r_X = 4.8  # Assume r_X matches r_X_c

# Functions
def L(z, h, w):
    return (1 + np.exp(-2 * (np.abs(z) - h) / w))**-1

def B_tor(r, z):
    L_z = L(z, z_0, w_h)
    if z > 0:
        return np.exp(-np.abs(z) / z_0) * L_z * B_n * (1 - L(r, r_n, w_h))
    else:
        return np.exp(-np.abs(z) / z_0) * L_z * B_s * (1 - L(r, r_s, w_h))

def B_pol(r, z):
    rp = r - np.abs(z) / np.tan(theta_X) if r > r_X else (r * r_X_c) / (r_X_c + np.abs(z) / np.tan(theta_X))
    if r > r_X:
        scale_factor = rp / r
    else:
        scale_factor = (rp / r)**2
    return B_X * np.exp(-rp / r_X) * scale_factor

# Creating a grid for visualization
r = np.linspace(0.1, 15, 20)  # radial distance (kpc)
z = np.linspace(-8, 8, 20)  # vertical height (kpc)
phi = np.linspace(0, 2 * np.pi, 30)  # azimuthal angle (radians)
R, Z, PHI = np.meshgrid(r, z, phi)

# Convert cylindrical to Cartesian coordinates
X = R * np.cos(PHI)
Y = R * np.sin(PHI)

# Calculate the field components in cylindrical coordinates
B_tor_field = np.vectorize(B_tor)(R, Z)
B_pol_field = np.vectorize(B_pol)(R, Z)

# Transform field components to Cartesian coordinates
B_X_cart = -B_tor_field * np.sin(PHI)  # x-component
B_Y_cart = B_tor_field * np.cos(PHI)   # y-component
B_Z_cart = B_pol_field                 # z-component

# Downsample the grid for better visualization
step = 3  # sampling step
X_down, Y_down, Z_down = X[::step, ::step, ::step], Y[::step, ::step, ::step], Z[::step, ::step, ::step]
Bx_down, By_down, Bz_down = B_X_cart[::step, ::step, ::step], B_Y_cart[::step, ::step, ::step], B_Z_cart[::step, ::step, ::step]

# Plotting the vector field
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection='3d')

# Quiver plot for magnetic field vectors
ax.quiver(X_down, Y_down, Z_down, Bx_down, By_down, Bz_down, length=0.5, normalize=True, color='blue', alpha=0.7)

# Labels and title
ax.set_title('3D Magnetic Field of the Milky Way', fontsize=14)
ax.set_xlabel('X (kpc)')
ax.set_ylabel('Y (kpc)')
ax.set_zlabel('Z (kpc)')

plt.show()
