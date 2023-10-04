-- Padronização da coluna com Datas

ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate Date

SELECT SaleDate
FROM PortfolioProjects.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------------------

-- Existem endereços ('PropertyAddress') nulos que são do mesmo ID ('ParcelID').
-- Então, podemos estabelecer que se o 'ParcelID' for igual, o 'PropertyAddress' também será igual
-- Usei a coluna 'UniqueID' para estabelecer que quero o mesmo 'ParcelID' mas em linhas diferentes

-- 1º Passo: Verificar, linha a linha, quais são os endereços vazios com o mesmo 'ParcelID', mostrando qual o endereço correspondente

SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress 
FROM PortfolioProjects.dbo.NashvilleHousing AS A
JOIN PortfolioProjects.dbo.NashvilleHousing AS B
	ON A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

-- P.S. Após a atualização feita no "2º Passo", a query do "1º Passo" estará vazia, pois os valores em branco foram substituídos pelos endereços correspondentes

-- 2º Passo: Atribuir o endereço correspondente, atualizando a coluna 'PropertyAddress'

UPDATE A
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM PortfolioProjects.dbo.NashvilleHousing AS A
JOIN PortfolioProjects.dbo.NashvilleHousing AS B
	ON A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

--------------------------------------------------------------------------------------------------------------------------------------

-- Separando colunas de Localização ('Property Address' e 'Owner Address') em Colunas Individuais (Endereço, Cidade e Estado)

-- 1ª Opção: Utilizando SUBSTRING e CHARINDEX (Procura por um valor ou texto específico)

SELECT 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Property_Address -- O "-1" significa ir até a vírgula e parar no caractere anterior
	,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Property_City -- O "+1" significa da vírgula pra frente, indo até o comprimento final da palavra
FROM PortfolioProjects.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD Property_Address NVARCHAR(255);

UPDATE NashvilleHousing
SET Property_Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
ADD Property_City NVARCHAR(255);

UPDATE NashvilleHousing
SET Property_City = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- 2ª Opção: Utilizando PARSNAME(É uma função que procura por "." em uma string) e REPLACE (para substituir "," por ".")

SELECT
	PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) AS Owner_Adress
	,PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) AS Owner_City
	,PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) AS Owner_State
FROM PortfolioProjects.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD Owner_Adress NVARCHAR(255);

UPDATE NashvilleHousing
SET Owner_Adress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
ADD Owner_City NVARCHAR(255);

UPDATE NashvilleHousing
SET Owner_City = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
ADD Owner_State NVARCHAR(255);

UPDATE NashvilleHousing
SET Owner_State = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

--------------------------------------------------------------------------------------------------------------------------------------

-- A coluna "SoldAsVacant" apresenta valores booleanos (Y,N) e também "Yes" e "No". 
-- Transformei tudo em "Yes" and "No" usando "CASE"

SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END
FROM PortfolioProjects.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = 
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END

--------------------------------------------------------------------------------------------------------------------------------------

-- Identificando e removendo linhas duplicadas, usando "CTE", "WINDOW FUNCTION" AND "ROW_NUMBER"

-- 1º Passo → Identificando as linhas únicas com "ROW_NUMBER" (as que estiverem com valor 1 são únicas)
-- 2º Passo → Removendo as linhas com "ROW_NUMBER" > 1

WITH RowNumCTE
AS(
	SELECT *,
		ROW_NUMBER()
		OVER(
			PARTITION BY
				ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
			ORDER BY
				UniqueID
			) AS Row_Num
FROM PortfolioProjects.dbo.NashvilleHousing
)

DELETE
FROM RowNumCTE
WHERE Row_Num > 1

--------------------------------------------------------------------------------------------------------------------------------------

-- Removendo colunas não usadas

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT *
FROM PortfolioProjects.dbo.NashvilleHousing
