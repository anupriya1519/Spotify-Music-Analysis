---
title: "Spotify Data Analysis"
output: html_notebook
---

```{r}
dataset=read.csv('data.csv')
names(dataset)
dim(dataset)
str(dataset)
summary(dataset)
sapply(dataset, function(x) sum(is.na(x)))
table(is.na(dataset))
dataset$target<-as.factor(dataset$target)
library(GGally)
ggpairs(dataset,columns = c(1:6,14))
ggpairs(dataset,columns = c(7:13,14))

```

```{r}
dt<-sort(sample(nrow(dataset),nrow(dataset)*.8))
train<-dataset[dt,]
test<-dataset[-dt,]
library(rpart)
library(rpart.plot)
library(caret)
str(train)
model <- rpart(target~.,data=train)
prp(model, type=1, extra=1, col="green")
prp(model, type=2, extra=1, col="blue")
prp(model, type=3, extra=1, col="red")
library(tree)
dataset$X<-NULL
dataset$song_title<-NULL
dataset$artist<-NULL
model1<-tree(target~.,train)
plot(model1)
text(model1,pretty=0)

```
```{r}
str(test)
pred <- predict(model, test, type="class")
confusionMatrix(pred, test$target)
```

```{r}
library(randomForest)
model3 <- randomForest(target~., train, ntree=50)
varImpPlot(model3)
pred2 <- predict(model3, test)                   
confusionMatrix(pred2, test$target)
```



