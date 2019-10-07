
#%% criando um array
myarr = [10, 4,3, 4, 2,40,50,42,31,55,22,23,16,17,33,9,8,9,13,98, 83,72, 65, 64,72,56]

#%%
def bubleSort(arr):
    arrLen = len(arr)
    while True:
        swapped = False
        for index in range(1, arrLen):
            el = arr[index]
            ant = arr[index-1]
            if el <= ant:
                arr[index], arr[index-1] = ant, el
                swapped = True
        if not swapped: break
    return arr

bubleSort(myarr)
                 

#%%
