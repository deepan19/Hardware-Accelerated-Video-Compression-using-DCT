from multiprocessing.dummy import Array
from operator import inv
import PIL
from PIL import Image
import numpy as np
import math
import sys

#initialize

np.set_printoptions(threshold=sys.maxsize)
an_image = PIL.Image.open("small.jpg")
PI = math.pi
m = 8
n = 8
num_blocks_xy = 1

image_array = [[170,153,153,153,170,153,153,153],
         [170,153,170,187,170,153,170,153],
         [170,153,170,170,204,187,221,204],
         [187,153,187,187,204,187,238,221],
         [170,187,170,153,187,187,170,153],
         [187,170,187,153,204,170,170,153],
         [204,187,153,153,136,136,136,136],
         [205,187,153,153,153,153,153,119]]
print((len(image_array[0]),len(image_array)))

inversed_image = np.zeros((len(image_array[0]),len(image_array)))



dct = np.zeros((len(image_array[0]),len(image_array)))


for bx in range(num_blocks_xy):
    for by in range(num_blocks_xy):

        for i in range(m):
            u = bx*8 + i
            for j in range(n):
                v = by*8 + j

                if(i==0):
                    cu = 1/math.sqrt(2)
                else:
                    cu = 1
        
                if(j==0):
                    cv = 1 / math.sqrt(2)
                else:
                    cv = 1

                sum = 0

                for k in range(m):
                    imx = bx*8 + k
                    for l in range(n):
                        imy = by*8 + l

                        dct1 = image_array[imx][imy] * math.cos((2*k+1)*i*PI/(2*m)) * math.cos((2*l+1)*j*PI/(2*n))
                        sum = sum + dct1
                dct[u][v] = (1/math.sqrt(16)) * cu * cv * sum

print(dct)

img = Image.fromarray(dct,"L")


quant = np.array([[13,16,13,16],
                  [16,20,16,20],
                  [13,16,13,16],
                  [16,20,16,20]])

quantization = np.zeros((len(image_array[0]),len(image_array)))
unquantization = np.zeros((len(image_array[0]),len(image_array)))



for i in range(num_blocks_xy):
    for j in range(num_blocks_xy):
            for x in range(4):
                for y in range(4):
                    quantization[4*i + x][4*j + y] = round(dct[4*i + x][4*j + y] / quant[x][y])
                    unquantization[4*i + x][4*j + y] = quantization[4*i + x][4*j + y] * quant[x][y]



for bx in range(num_blocks_xy):
    for by in range(num_blocks_xy):

        for i in range(m):
            u = bx*4 + i
            for j in range(n):
                v = by*4 + j
                
                sum = 0
                for k in range(m):
                    imx = bx*4 + k
                    for l in range(n):
                        imy = by*4 + l

                        if(k==0):
                            ci = 1/math.sqrt(2)
                        else:
                            ci = 1
        
                        if(l==0):
                            cj = 1 / math.sqrt(2)
                        else:
                            cj = 1

                        dct1 = unquantization[imx][imy] * math.cos((2*i+1)*k*PI/(2*m)) * math.cos((2*j+1)*l*PI/(2*n))
                        sum = sum + dct1 * ci * cj * (1/math.sqrt(8))
                inversed_image[u][v] = round(sum)



# img = Image.fromarray(inversed_image).convert("L")
# img.show()
# img.save("pepper_compressed_small.jpg")




        


