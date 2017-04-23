hotcode <- function(train, test){
  
  train[,1:11] <- lapply(train[,1:11], as.character)
  test[,1:11] <- lapply( test[,1:11], as.character)
  
  train$Gender <- ifelse(train$Gender=='F', 0, 1)
  test$Gender <- ifelse(test$Gender=='F', 0, 1)
  
  train$Stay_In_Current_City_Years <- ifelse(train$Stay_In_Current_City_Years=='4+', '4', train$Stay_In_Current_City_Years)
  test$Stay_In_Current_City_Years <- ifelse(test$Stay_In_Current_City_Years=='4+', '4', test$Stay_In_Current_City_Years)
  
  train <- dummy.data.frame(train, names = c("City_Category", "Stay_In_Current_City_Years"), sep = "_")
  test <- dummy.data.frame(test, names = c("City_Category", "Stay_In_Current_City_Years"), sep = "_")
  
  train <- data.table(train)
  test <- data.table(test)
  
  train[, Age_Count := .N, by = Age]
  train_test_age <- unique(select(train, Age, Age_Count))
  test <- merge(test, train_test_age, by = 'Age', all.x = TRUE)
  
  train[, Occupation_Count := .N, by = Occupation]
  train_test_Occupation <- unique(select(train, Occupation, Occupation_Count))
  test <- merge(test, train_test_Occupation, by = 'Occupation',all.x = TRUE)
  
  train[, Product_Category_1_Count := .N, by = Product_Category_1]
  train_test_Product_1 <- unique(select(train, Product_Category_1, Product_Category_1_Count))
  test <- merge(test, train_test_Product_1, by = 'Product_Category_1',all.x = TRUE)
  
  train[, Product_Category_2_Count := .N, by = Product_Category_2]
  train_test_Product_2 <- unique(select(train, Product_Category_2, Product_Category_2_Count))
  test <- merge(test, train_test_Product_2, by = 'Product_Category_2',all.x = TRUE)
  
  train[, Product_Category_3_Count := .N, by = Product_Category_3]
  train_test_Product_3 <- unique(select(train, Product_Category_3, Product_Category_3_Count))
  test <- merge(test, train_test_Product_3, by = 'Product_Category_3',all.x = TRUE)
  
  train[, User_Count := .N, by = User_ID]
  train_test_User <- unique(select(train, User_ID, User_Count))
  test <- merge(test, train_test_User, by = 'User_ID',all.x = TRUE)
  
  train[, Product_Count := .N, by = Product_ID]
  train_test_Product <- unique(select(train, Product_ID, Product_Count))
  test <- merge(test, train_test_Product, by = 'Product_ID',all.x = TRUE)
  
  train[, Mean_Purchase_Product := mean(Purchase), by = Product_ID]
  train_product_purchase <- unique(select(train, Product_ID, Mean_Purchase_Product))
  test <- merge(test, train_product_purchase, by = 'Product_ID', all.x = TRUE)
  
  train[, Mean_Purchase_User := mean(Purchase), by = User_ID]
  train_user_purchase <- unique(select(train, User_ID, Mean_Purchase_User))
  test <- merge(test, train_user_purchase, by = 'User_ID', all.x = TRUE)
  
  test[, pro_self_count := .N, by = Product_ID]
  
  train$pro <- paste(train$Product_Category_1, train$Product_Category_2, train$Product_Category_3, sep='_')
  test$pro <- paste(test$Product_Category_1, test$Product_Category_2, test$Product_Category_3, sep='_')
  
  train[, pro_mean_purchase := mean(Purchase), by = pro]
  train_pro_purchase <- unique(select(train, pro, pro_mean_purchase))
  test <- merge(test, train_pro_purchase, by = 'pro', all.x = TRUE)
  
  
  test <- data.frame(test)
  for (i in 1:dim(test)[1]) {
    if(is.na(test[i,'Mean_Purchase_Product'])){
      test[i,'Mean_Purchase_Product'] = test[i,'pro_mean_purchase']
    }
    
    if(is.na(test[i,'Product_Count'])){
      test[i,'Product_Count'] = test[i, 'pro_self_count']
    }
    
  }
  
  
  train <- subset(train, select = -c(Age, pro, pro_mean_purchase, Occupation, Product_Category_1,Product_Category_2, Product_Category_3))
  
  test <- subset(test, select = -c(pro_self_count, Age, Occupation, pro, pro_mean_purchase, Product_Category_1,Product_Category_2, Product_Category_3))
  
  train <- select(train, User_ID, Product_ID, Gender,  City_Category_A, City_Category_B, City_Category_C, Stay_In_Current_City_Years_0, Stay_In_Current_City_Years_1,
                  Stay_In_Current_City_Years_2, Stay_In_Current_City_Years_3, Stay_In_Current_City_Years_4, Marital_Status, Age_Count, Occupation_Count, Product_Category_1_Count,
                  Product_Category_2_Count, Product_Category_3_Count, User_Count, Product_Count, Mean_Purchase_Product, Mean_Purchase_User, Purchase)               
  
  test <- select(test, User_ID, Product_ID, Gender,  City_Category_A, City_Category_B, City_Category_C, Stay_In_Current_City_Years_0, Stay_In_Current_City_Years_1,
                  Stay_In_Current_City_Years_2, Stay_In_Current_City_Years_3, Stay_In_Current_City_Years_4, Marital_Status, Age_Count, Occupation_Count, Product_Category_1_Count,
                  Product_Category_2_Count, Product_Category_3_Count, User_Count, Product_Count, Mean_Purchase_Product, Mean_Purchase_User)                

  c <- list(train, test)
  train_test <- rbindlist(c, fill = TRUE)
  train_test <- data.frame(train_test)
  train_test[,3:dim(train_test)[2]] <- lapply(train_test[,3:dim(train_test)[2]], as.numeric)
  return(train_test)               
  
}