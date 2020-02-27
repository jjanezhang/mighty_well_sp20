library(RMySQL)
library(dplyr)
library(plyr)
library(ggplot2)
setwd('C:\\Users\\Jayesh\\Downloads')
customers_export <- read.csv("customers_export_MW.csv", header = T)
orders_export <- read.csv("orders_export_1 MW.csv", header = T)
customers_export_spent <-customers_export[( customers_export$Total.Spent > 0),]
customers_export_spent_zipcode <- aggregate(customers_export_spent$Total.Spent,by=list(customers_export_spent$Zip),sum)
customers_export_spent_city <- aggregate(customers_export_spent$Total.Spent, by=list(customers_export_spent$City), sum)
customers_export_orders_zipcode <- aggregate(customers_export_spent$Total.Orders, by = list(customers_export_spent$Zip), sum)
customers_export_orders_city <- aggregate(customers_export_spent$Total.Orders, by=list(customers_export_spent$City), sum)
customers_export_orders_city <- customers_export_orders_city[order(customers_export_orders_city$Group.1),]
customers_export_orders_zipcode <- customers_export_orders_zipcode[order(customers_export_orders_zipcode$Group.1),]
customers_export_spent_city <- customers_export_spent_city[order(customers_export_spent_city$Group.1),]
customers_export_spent_zipcode <- customers_export_spent_zipcode[order(customers_export_spent_zipcode$Group.1),]
customers_export_spentorder_city <- customers_export_orders_city
customers_export_spentorder_zipcode <- customers_export_orders_zipcode
customers_export_spentorder_zipcode$x <- customers_export_spent_zipcode$x / customers_export_orders_zipcode$x
customers_export_spentorder_city$x <- customers_export_spent_city$x / customers_export_orders_city$x
#write.csv(customers_export_spentorder_zipcode, "zipcodeanalysis.csv")
write.csv(customers_export_spentorder_city, "citycodeanalysis.csv")