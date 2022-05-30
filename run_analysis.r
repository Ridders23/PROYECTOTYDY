library(reshape2)
getwd()
#se obtiene los datos
directorio <- "./data"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data <- "rawData.zip"
datos <- paste(directorio, "/", "rawData.zip", sep = "")
View(datos)
directorio2 <- "./dataset"

if (!file.exists(directorio)) {
  dir.create(directorio)
  download.file(url = url, destfile = datos)
}
if (!file.exists(directorio2)) {
  dir.create(directorio2)
  unzip(zipfile = datos, exdir = directorio2)
}

# Merges the training and the test sets to create one data set.

# train data
x_train <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/train/Y_train.txt"))
SUB_train <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/train/subject_train.txt"))

# test data
x_test <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/test/Y_test.txt"))
SUB_test <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/test/subject_test.txt"))

# merge TRAIN, TEST
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
SUB_data <- rbind(SUB_train, SUB_test)
#CARGA FEATURE
# feature info
feature <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/features.txt"))

# activity labels
labels <- read.table(paste(sep = "", directorio2, "/UCI HAR Dataset/activity_labels.txt"))

# extraemos las columnas con nombres "mean, std"

SELE_COL <- grep("-(mean|std).*", as.character(feature[,2]))
View(SELE_COL)
NOMCOL <- feature[SELE_COL, 2]
NOMCOL <- gsub("-mean", "Mean", NOMCOL)
NOMCOL <- gsub("-std", "Std", NOMCOL)
NOMCOL <- gsub("[-()]", "", NOMCOL)

#EXTRAEMOS LOS DATOS POR COLUMNAS

x_data <- x_data[SELE_COL]
datosunidos <- cbind(SUB_data, y_data, x_data)
colnames(datosunidos) <- c("Subject", "Activity", NOMCOL)

datosunidos$Activity <- factor(datosunidos$Activity, levels = labels[,1], labels = labels[,2])
datosunidos$Subject <- as.factor(datosunidos$Subject)
#datos limpios
melteddatos <- melt(datosunidos, id = c("Subject", "Activity"))
tidydatos <- dcast(melteddatos, Subject + Activity ~ variable, mean)

write.table(tidydatos, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)

