
# import random
# alist = random.sample(range(1000000), 900000) 

# import time
# alisttemp = alist[:]
# print(alisttemp[0:5])
# inicio = time.time()
# bucketsort(alisttemp)
# fim = time.time()
# print("Tempo do método bucketSort (s) - " + str(fim - inicio))
# print(alisttemp[0:5])

# print('TAMANHO DO ARRAY: ', len(alisttemp))

#%%
def insertionSort(alistf):
    #implemente aqui o InsertionSort
    for index in range(1,len(alistf)):

        currentvalue = alistf[index]
        position = index

        while position>0 and alistf[position-1]>currentvalue:
            alistf[position]=alistf[position-1]
            position = position-1
        alistf[position]=currentvalue
    return alistf

def myQuickSort(alistf):
    if alistf == []: 
        return []
    else:
        pivot = alistf[0]
        lesser = myQuickSort([x for x in alistf[1:] if x < pivot])
        greater = myQuickSort([x for x in alistf[1:] if x >= pivot])
        return lesser + [pivot] + greater


import random
alist = random.sample(range(10000), 9000) 
alist = alist.sort()
alist.append(400)
alist.append(5000)
print(alist[-10:-1])

#%%
import time
alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
alist = insertionSort(alisttemp)
fim = time.time()
print("Tempo do método INSERTIONSORT (s) - " + str(fim - inicio))
print(alist[0:5])

alisttemp = alist[:]
print(alisttemp[0:5])
inicio = time.time()
alist = myQuickSort(alisttemp)
fim = time.time()
print("Tempo do método QUICKSORT (s) - " + str(fim - inicio))
print(alist[0:5])
