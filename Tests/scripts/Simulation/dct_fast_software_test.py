from multiprocessing.dummy import Array
from operator import inv
from pydoc import allmethods
import PIL
from PIL import Image
import numpy as np
import math
import sys
import scipy
from scipy.fftpack import dctn, idctn


small = [[170,153,153,153,170,153,153,153],
         [170,153,170,187,170,153,170,153],
         [170,153,170,170,204,187,221,204],
         [187,153,187,187,204,187,238,221],
         [170,187,170,153,187,187,170,153],
         [187,170,187,153,204,170,170,153],
         [204,187,153,153,136,136,136,136],
         [205,187,153,153,153,153,153,119]]

# C1 = 0.5*math.cos(1*math.pi/16)
# C2 = 0.5*math.cos(2*math.pi/16)
# C3 = 0.5*math.cos(3*math.pi/16)
# C4 = 0.5*math.cos(4*math.pi/16)
# C5 = 0.5*math.cos(5*math.pi/16)
# C6 = 0.5*math.cos(6*math.pi/16)
# C7 = 0.5*math.cos(7*math.pi/16)
C1 = 0.49
C2 = 0.46
C3 = 0.42
C4 = 0.35
C5 = 0.28
C6 = 0.19
C7 = 0.10

intermediate = np.zeros((8,8))

for i in range(8):
    X0 = small[i][0]
    X1 = small[i][1]
    X2 = small[i][2]
    X3 = small[i][3]
    X4 = small[i][4]
    X5 = small[i][5]
    X6 = small[i][6]
    X7 = small[i][7]

    Y0 = ((X0+X7)+(X1+X6)+(X2+X5)+(X3+X4))*C4


    Y1 = (X0-X7)*C1+(X1-X6)*C3+(X2-X5)*C5+(X3-X4)*C7
 

    Y2 = ((X0+X7)-(X3+X4))*C2+((X1+X6)-(X2+X5))*C6


    Y3 = (X0-X7)*C3+(X1-X6)*(-C7)+(X2-X5)*(-C1)+(X3-X4)*(-C5)


    Y4 = ((X0+X7)+(X3+X4)-(X1+X6)-(X2+X5))*C4


    Y5 = (X0-X7)*C5+(X1-X6)*(-C1)+(X2-X5)*C7+(X3-X4)*C3


    Y6 = ((X0+X7)-(X3+X4))*C6-((X1+X6)-(X2+X5))*C2


    Y7 = (X0-X7)*C7+(X1-X6)*(-C5)+(X2-X5)*C3+(X3-X4)*(-C1)



    intermediate[i][0] = Y0
    intermediate[i][1] = Y1
    intermediate[i][2] = Y2
    intermediate[i][3] = Y3
    intermediate[i][4] = Y4
    intermediate[i][5] = Y5
    intermediate[i][6] = Y6
    intermediate[i][7] = Y7
print("INPUT ARRAY")
print(np.array(small))
print("-------------------------------------------------------------------------")
print("INTERMEDIATE/1-D DCT ARRAY")
print(intermediate)
print('--------------------------------------------------------------------------')
print("FINAL/2-D DCT ARRAY")
final = np.zeros((8,8))

for i in range(8):
    X0 = intermediate[0][i]
    X1 = intermediate[1][i]
    X2 = intermediate[2][i]
    X3 = intermediate[3][i]
    X4 = intermediate[4][i]
    X5 = intermediate[5][i]
    X6 = intermediate[6][i]
    X7 = intermediate[7][i]

    Y0 = ((X0+X7)+(X1+X6)+(X2+X5)+(X3+X4))*C4

    Y1 = (X0-X7)*C1+(X1-X6)*C3+(X2-X5)*C5+(X3-X4)*C7

    Y2 = ((X0+X7)-(X3+X4))*C2+((X1+X6)-(X2+X5))*C6

    Y3 = (X0-X7)*C3+(X1-X6)*(-C7)+(X2-X5)*(-C1)+(X3-X4)*(-C5)

    Y4 = ((X0+X7)+(X3+X4)-(X1+X6)-(X2+X5))*C4

    Y5 = (X0-X7)*C5+(X1-X6)*(-C1)+(X2-X5)*C7+(X3-X4)*C3

    Y6 = ((X0+X7)-(X3+X4))*C6-((X1+X6)-(X2+X5))*C2

    Y7 = (X0-X7)*C7+(X1-X6)*(-C5)+(X2-X5)*C3+(X3-X4)*(-C1)

    final[0][i] = round(Y0)
    final[1][i] = round(Y1)
    final[2][i] = round(Y2)
    final[3][i] = round(Y3)
    final[4][i] = round(Y4)
    final[5][i] = round(Y5)
    final[6][i] = round(Y6)
    final[7][i] = round(Y7)

print(final)

