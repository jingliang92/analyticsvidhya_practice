library(gridExtra)
library(grid)
library(ggplot2)
library(dummies)
library(caret)
library(dplyr)
library(data.table)

train_data <- read.csv(file.choose())
test_data <- read.csv(file.choose())

source('D:/analyticsvidhya_practice/hotcode.R')
train_test <- hotcode(train_data, test_data)

train <- train_test[1:nrow(train_data), ]
test <- train_test[-(1:nrow(train_data)), 1:21]

lm_model <- train(train[,3:21], train[,22], method = 'lm', preProcess = c("center", "scale"), metric = "RMSE")
summary(lm_model)


train <- subset(train, select=-c(City_Category_C, Stay_In_Current_City_Years_4))
test <- subset(test, select=-c(City_Category_C, Stay_In_Current_City_Years_4))

source('D:/xgboost_train/xgboost.R')
ctrl <- trainControl(method = "repeatedcv", number = 5)
xgbgrid <- expand.grid(eta=0.26, gamma=0.1, max_depth=10,
                       min_child_weight=11, max_delta_step=0, subsample=1,
                       colsample_bytree=1, colsample_bylevel = 1, lambda=0.05,
                       alpha=0, scale_pos_weight = 1, nrounds=80, eval_metric='rmse',
                       objective='reg:linear')
xgb_model <- train(train[,3:19], train[,20], method = xgboost, tuneGrid=xgbgrid, trControl=ctrl)

Purchase <- predict(xgb_model, test[, 3:19])
result_sub <- data.frame(User_ID=test$User_ID, Product_ID=test$Product_ID, Purchase=Purchase)
write.csv(result_sub, file = 'D:/analyticsvidhya_practice/result_sub.csv', row.names = FALSE)