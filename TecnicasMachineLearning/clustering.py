print(__doc__)

# Adaptado de Code source: Gaël Varoquaux
# License: BSD 3 clause
# Carrega as bibliotecas necessárias
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from sklearn import datasets

np.random.seed(5)

# carrega a base Iris
iris = datasets.load_iris()
X = iris.data
y = iris.target

# Realiza o agrupamento considerando 3 grupos ou cliusters
n_clusters=3
cluster=KMeans(n_clusters);
cluster.fit(X)

cluster_labels = cluster.fit_predict(X)

# Calcula o Silhouette_score o qual dá uma perspectiva da densidade e separação dos clusters
silhouette_avg = silhouette_score(X, cluster_labels)
print("\n\n For ", n_clusters,
          " clusters, the average silhouette_score is :", silhouette_avg)


# Plota o resultado (visualização)
fig = plt.figure("Figura 1", figsize=(4, 3))
ax = Axes3D(fig, rect=[0, 0, .95, 1], elev=48, azim=134)
labels = cluster.labels_
ax.scatter(X[:, 3], X[:, 0], X[:, 2],
               c=labels.astype(np.float), edgecolor='k')

ax.w_xaxis.set_ticklabels([])
ax.w_yaxis.set_ticklabels([])
ax.w_zaxis.set_ticklabels([])
ax.set_xlabel('Petal width')
ax.set_ylabel('Sepal length')
ax.set_zlabel('Petal length')
ax.set_title("Resultado para 3 clusters")
ax.dist = 12
#fig.show()


# Plota o resultado real (ground truth) para verificação
fig = plt.figure("Figura 2", figsize=(4, 3))
ax = Axes3D(fig, rect=[0, 0, .95, 1], elev=48, azim=134)

for name, label in [('Setosa', 0),
                    ('Versicolour', 1),
                    ('Virginica', 2)]:
    ax.text3D(X[y == label, 3].mean(),
              X[y == label, 0].mean(),
              X[y == label, 2].mean() + 2, name,
              horizontalalignment='center',
              bbox=dict(alpha=.2, edgecolor='w', facecolor='w'))

y = np.choose(y, [1, 2, 0]).astype(np.float)
ax.scatter(X[:, 3], X[:, 0], X[:, 2], c=y, edgecolor='k')

ax.w_xaxis.set_ticklabels([])
ax.w_yaxis.set_ticklabels([])
ax.w_zaxis.set_ticklabels([])
ax.set_xlabel('Petal width')
ax.set_ylabel('Sepal length')
ax.set_zlabel('Petal length')
ax.set_title('Resultado Real')
ax.dist = 12

fig.show()