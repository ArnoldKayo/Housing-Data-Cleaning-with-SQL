# Housing-Data-Cleaning-with-SQL
I was able to clean data with the help of SQL SSMS tool. An interesting challenge that was able to transform my dataset to a well understood and usable dataset


# The first step was to identify how best we could clean the dataset
Some of the things that was to dealt with in order to tranform the dataset to clean were:
    1.  Standardising the 'SaleDate'.
    
    2.  Breaking the 'PropertyAddress' and the 'OwnerAddress' into individual columns.
    
    3.  Replacing the 'Y' &'N' with either'Yes' or 'No' under the 'SoldAsVacant' column.
    
    4.  Removing duplicates.


# Actual cleaning of the dataset.
     1.  I first has to standardise the SaleDate. The timestamp on the SaleDate was not necessary so I had 
         to remove it and only remain with the date.
         
     2.  Breaking the PropertyAddress and the OwnerAddress into individual columns was the second thing to 
         be done. The addresses had to be categorised by the Property/Owner Address, City and State 
         respectively. This would make analysis on the dataset easier.

     3.  Transforming the Y & N to Yes or NO was the third thing to be done. Instead of having all four 
         of them under the 'SoldAsVacant' column meaning the same thing, this had to be tranformed to 
         either 'Yes' or 'No'.

     4.  Finaly the last action was to delete the duplicated from the dataset. The dataset was very large 
         and having duplicates was one of the challenges that needed to be solved. Dulicates tend to 
         corrupt datasets and so it had to be dealt with with the help of a CTE tool.
         
