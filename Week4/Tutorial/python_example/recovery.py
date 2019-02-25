import numpy as np
import math
import matplotlib.pyplot as plt

def sinc_interp(x, s, u):
    if len(x) != len(s):
        raise ValueError('x and s must be the same length')

    # Find the period    
    T = s[1] - s[0]

    sincM = np.tile(u, (len(s), 1)) - np.tile(s[:, np.newaxis], (1, len(u)))
    y = np.dot(x, np.sinc(sincM/T))
    return y


x=np.arange(0,2*np.pi,0.01)
y=np.sin(x)
plt.plot(x,y)
plt.show()

under_sample_indexes = np.array(list(range(0, len(x), 100)))
over_sample_indexes = np.array(list(range(0, len(x), 10)))
print('len of x:', len(x), 'len of under sample:', len(under_sample_indexes),
      'len of over sample:', len(over_sample_indexes))

under_sample_values = y[under_sample_indexes]
print('under sample values:', under_sample_values)

predict_values = sinc_interp(under_sample_values, under_sample_indexes,
                             over_sample_indexes) 
print('predict values:', predict_values)


real_sample_indexes = x[under_sample_indexes]
plt.scatter(real_sample_indexes, under_sample_values)
plt.show()


predict_indexes = x[over_sample_indexes]
plt.scatter(predict_indexes, predict_values)
plt.show()



