import PIL
import scipy

import PIL, scipy
from PIL import ImageFilter, Image

import numpy as np

a = 1
if a == 1:
    print('helloworld')
elif a == 2:
    print('hellopython')
else:
    print('helloscipy')

for i in range(1000):
    print('index:', i)

st = ['a','b','c','d']
for s in st:
    print(s)
i = 0
while i<5:
    print('hello')
    i+=1

def add_one(a):
    return a+1

add_one(1)

l2 = map(add_one, [1,2,3,4])
print(l2)
l2 = map(lambda x:x+1, [1,2,3,4])
print(l2)
l2 = filter(lambda x:x%2==0, [1,2,3,4,5,6])
print(l2)




