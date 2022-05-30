Getting and Cleaning Data

El script realiza lo siguiente , se crea un directorio donde guargar un archivo zip que se descarga de la web.

se leen los dos  datos del Train  y del test, y el subject de ambos, se combinan, siendo x las medidas y las "y" la actividad y la variable SUB_data, se cargan las feature
y los labels

luego se extraen las columnas que contienen la media y la desviacion y se modifica el nombre de las columnas para que sean descriptivas y se eliminan los simbolos para trabajar mejor con los datos


se extraen los datos de las columnas que se seleccionaron, se combina x, y y los datos , se remplaza la columna y por su nombre que hace referencia a la actividad lo que nos deja un conjunto de datos  mas  limpio 
