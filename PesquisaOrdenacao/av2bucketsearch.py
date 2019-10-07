#%%
import random
import math

#%%
class sortAlgorithms(object):
    
    def bucketSort(self, alistf,  bucketSize=0):
        # Guardando o valor pra evitar processamentos desnecessario
        list_size = len(alistf)
        #li no artigo 
        if bucketSize == 0:
            bucketSize = math.ceil(math.sqrt(list_size))
        if(list_size == 0):
            print('Sem elementos no array.')

        maxValue = alistf[0]

        # For finding minimum and maximum values
        for i in range(0, list_size):
            if alistf[i] > maxValue:
                maxValue = alistf[i] 
        
        # Initialize buckets
        divider = math.ceil((maxValue +1) / bucketSize) 
        maxindex = math.floor(maxValue/divider)
        if(maxindex > divider):
            divider = maxindex


        buckets = [[] for _ in range(0,divider)]
        
        # For putting values in buckets
        for i in range(0, list_size):
            buckets[math.floor((alistf[i] / divider))].append(alistf[i])

        ''' python é maravilhoso! somando os arrays [1,2] + [3,4] =
            array de [1,2,3,4]

        '''
        sortedArray = []
        for i in range(0, divider):
            sortedArray += self.insertionSort(buckets[i])

        return sortedArray


    def insertionSort(self, x):
        for index in range(1,len(x)):
            currentvalue = x[index]
            position = index

            while position>0 and x[position-1]>currentvalue:
                x[position]=x[position-1]
                position = position-1
            x[position]=currentvalue
        return x



#alist = random.sample(range(10000), 500)
alist = [10,1000,8,3,1,40222,2,4,7,6,43,234,2,3,4,15,12,22,84787]
sort = sortAlgorithms()
print(sort.bucketSort(alist))


