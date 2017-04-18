train_data[,1:11] <- lapply(train_data[,1:11], as.factor)

purchase_plot <- ggplot(train_data, aes(Purchase))+geom_area(stat = "bin")

gen_pur_box = ggplot(train_data, aes(Gender, Purchase))+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
gen_pur_vio = ggplot(train_data, aes(Gender, Purchase))+geom_violin(scale ="area")
grid.arrange(gen_pur_box, gen_pur_vio,  ncol=2)

age_pur_box = ggplot(train_data, aes(Age, Purchase))+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
age_pur_vio = ggplot(train_data, aes(Age, Purchase))+geom_violin(scale ="area")
grid.arrange(age_pur_box, age_pur_vio,  ncol=2)

occupation_pur_box = ggplot(train_data, aes(Occupation, Purchase))+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
occupation_pur_vio = ggplot(train_data, aes(Occupation, Purchase))+geom_violin(scale ="area")
grid.arrange(occupation_pur_box, occupation_pur_vio,  ncol=2)

category_pur_box = ggplot(train_data, aes(City_Category, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
category_pur_vio = ggplot(train_data, aes(City_Category, Purchase))+geom_violin(scale ="area")
grid.arrange(category_pur_box, category_pur_vio,  ncol=2)

stay_pur_box = ggplot(train_data, aes(Stay_In_Current_City_Years, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
stay_pur_vio = ggplot(train_data, aes(Stay_In_Current_City_Years, Purchase))+geom_violin(scale ="area")
grid.arrange(stay_pur_box, stay_pur_vio,  ncol=2)

marital_pur_box = ggplot(train_data, aes(Marital_Status, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
marital_pur_vio = ggplot(train_data, aes(Marital_Status, Purchase))+geom_violin(scale ="area")
grid.arrange(marital_pur_box, marital_pur_vio,  ncol=2)

product_pur_box_1 = ggplot(train_data, aes(Product_Category_1, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
product_pur_vio_1 = ggplot(train_data, aes(Product_Category_1, Purchase))+geom_violin(scale ="area")
product_pur_box_2 = ggplot(train_data, aes(Product_Category_2, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
product_pur_vio_2 = ggplot(train_data, aes(Product_Category_2, Purchase))+geom_violin(scale ="area")
product_pur_box_3 = ggplot(train_data, aes(Product_Category_3, Purchase))+geom_boxplot()+geom_boxplot()+stat_summary(fun.y="mean", geom="point", size=5, position=position_dodge(width=0.75), color="black") 
product_pur_vio_3 = ggplot(train_data, aes(Product_Category_3, Purchase))+geom_violin(scale ="area")
grid.arrange(product_pur_box_1, product_pur_vio_1, product_pur_box_2, product_pur_vio_2, product_pur_box_3, product_pur_vio_3, ncol=2)