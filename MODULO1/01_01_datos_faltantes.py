#En este file copio los codigos del video, mi version es el notebook
#Algunos nombres cambiados

import csv
import pandas as pd


#Leyendo path para evitar no ubicar el file
dir(csv)
path= "/workspaces/desafio-programacion-python-harleeliz/01_01_datos_faltantes/empleados.csv"
df = pd.read_csv(path, delimiter=";")
print(df.head(20))
print(df.shape)
print(df.isnull().sum())
print(df.notnull().sum())
print(df[df.isnull().any(axis=1)])

#Eliminar duplicated columns
df_act=df.drop(axis=1,columns=['Apellido'])

#Drop NaN values
df_actualizado=df_act.dropna(axis=0)
print(df_actualizado)

#Eliminacion de algunas files que tienen al menos 5 filas no validas
df_actualizado=df_act.dropna(axis=0,thresh=5)


#Eliminar filas duplicadas
duplicados=df_actualizado.duplicated()
print(df_actualizado[duplicados])
df=df_actualizado.drop_duplicates()

#Imputacion de datos con relleno de media de edad
df.shape