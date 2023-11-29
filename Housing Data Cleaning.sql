--Show table in order of UniqueID
SELECT *
FROM Housing
ORDER BY 1;

--Standardise saledate
UPDATE Housing
SET SaleDate = CONVERT(DATE,SaleDate);

ALTER TABLE Housing
ADD SaleDateConverted DATE;

UPDATE Housing
SET SaleDateConverted = CONVERT(DATE,SaleDate);

SELECT SaleDateConverted, SaleDate
FROM Housing;

--Populate property address
--Dealing with NULL addresses
SELECT PropertyAddress
FROM Housing;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM Housing a
JOIN Housing B
  ON a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Housing a
JOIN Housing B
  ON a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

--Break property address into individual columns;'Address','City'.
SELECT PropertyAddress
FROM Housing;

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS MainAddress,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City 
FROM Housing;

ALTER TABLE Housing
ADD MainAddress NVARCHAR(300);

UPDATE Housing
SET MainAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1);

ALTER TABLE Housing
ADD City NVARCHAR(50);

UPDATE Housing
SET City = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress));

SELECT MainAddress, City
FROM Housing;

--Break Owner address into individual columns;'Address','City','State'.
SELECT OwnerAddress
FROM Housing;


SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS OwnerPersonalAddress, 
PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS OwnerCity, 
PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS OwnerState
FROM Housing;

ALTER TABLE Housing
ADD OwnerPersonalAddress NVARCHAR(100);

UPDATE Housing
SET OwnerPersonalAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3);

ALTER TABLE Housing
ADD  OwnerCity NVARCHAR(100);

UPDATE Housing
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2);

ALTER TABLE Housing
ADD OwnerState NVARCHAR (30);

UPDATE Housing
SET OwnerState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

SELECT OwnerPersonalAddress, OwnerCity, OwnerState
FROM Housing;

--Transform Y & N in SoldAsVacant to Yes or No
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Housing
GROUP BY SoldAsVacant;

SELECT SoldAsVacant, CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
                          WHEN SoldAsVacant = 'N' THEN 'NO'
						  ELSE SoldAsVacant
						  END AS EitherSoldAsVacant
FROM Housing;

ALTER TABLE Housing
ADD EitherSoldAsVacant NVARCHAR(10);

UPDATE Housing
SET EitherSoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
                          WHEN SoldAsVacant = 'N' THEN 'NO'
						  ELSE SoldAsVacant
						  END;

SELECT DISTINCT(EitherSoldAsVacant), COUNT(EitherSoldAsVacant)
FROM Housing
GROUP BY EitherSoldAsVacant;

--Remove Duplicates
SELECT *
FROM Housing;

With ROW_NUMCTE AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY ParcelID,
                                          PropertyAddress,
										  SalePrice,
										  SaleDate,
										  LegalReference
										  ORDER BY
										    UniqueID
											) ROW_NUM
FROM Housing
--ORDER BY ParcelID;
)
DELETE
FROM ROW_NUMCTE
WHERE ROW_NUM > 1
---ORDER BY PropertyAddress;

--Delete unused columns
SELECT *
FROM Housing;

ALTER TABLE Housing
DROP COLUMN SaleDate,
            SoldAsVacant,
			OwnerAddress,
			PropertyAddress;








