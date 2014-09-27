import matplotlib
matplotlib.use('Agg')
import numpy as np
import matplotlib.pyplot as plt

colors = [('white')] + [(color(i)) for i in xrange(1,256)]
new_map = matplotlib.colors.LinearSegmentedColormap.from_list('new_map', colors, N=256)

fig = plt.figure()
ax = fig.add_axes([0.2,0.8,0.7,0.2])
ax.matshow([[1,1,1,0,0],[0,0,1,1,1],[1,1,0,1,1]], cmap=new_map, aspect='auto', origin='lower')
plt.show()
