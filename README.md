# analyticsvidhya_practice
black_friday_data_hack

## Import packages

```
library(gridExtra)
library(grid)
library(ggplot2)
library(dummies)
library(caret)
library(dplyr)
library(data.table)
```

## Get the data

```
train_data <- read.csv(file.choose())
test_data <- read.csv(file.choose())
```

## Feature Engineering

```
source('D:/data_practice_1/hotcode.R')
train_test <- hotcode(train_data, test_data)

train <- train_test[1:nrow(train_data), ]
test <- train_test[-(1:nrow(train_data)), 1:21]
```

## lm model

```
lm_model <- train(train[,3:21], train[,22], method = 'lm', preProcess = c("center", "scale"), metric = "RMSE")
summary(lm_model)

train <- subset(train, select=-c(City_Category_C, Stay_In_Current_City_Years_4))
test <- subset(test, select=-c(City_Category_C, Stay_In_Current_City_Years_4))
```

## xgboost model

```
source('D:/data_practice_1/xgboost.R')
ctrl <- trainControl(method = "repeatedcv", number = 5)

xgb_model <- train(train[,3:19], train[,20], method = xgboost, preProcess = c("center", "scale"), tuneGrid=xgbgrid, trControl=ctrl)
```
## Make the prdiction

```
test_pre <- test[, 3:19]
preProc <- preProcess(test_pre)
test_pre <- predict(preProc, test_pre)
Purchase <- predict(xgb_model, test_pre)
result_sub <- data.frame(User_ID=test$User_ID, Product_ID=test$Product_ID, Purchase=Purchase)
write.csv(result_sub, file = 'D:/data_practice_1/result_sub.csv', row.names = FALSE)
```

![](https://68.media.tumblr.com/a65a64902e53e5609cc3356726e58941/tumblr_oom6xfpqX01w13vv3o1_540.png)

[详见博客]()
