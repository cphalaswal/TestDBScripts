USE [dBuilder_Master]
GO
/****** Object:  StoredProcedure [dbo].[_pcm_ProductContentLocationCustomerZone]    Script Date: 3/28/2017 12:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
TEST

CREATE PROCEDURE [dbo].[_pcm_ProductContentLocationCustomerZone]
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--CREATE VIEW vuedCatalog_ProductContentLocationCustomerZone
	--AS
	--SELECT * FROM SRVDCATALOG.dCatalog.dbo.tblProductContentLocationCustomerZone

	SELECT
		*
	INTO #vueProductContentLocationCustomerZone
	FROM vuedCatalog_ProductContentLocationCustomerZone

	DELETE 
		PCLC
	FROM 
	tblProductContentLocationCustomerZone PCLC
	INNER JOIN #vueProductContentLocationCustomerZone T ON T.ProductContentLocationCustomerZoneID = PCLC.ProductContentLocationCustomerZoneID

	INSERT INTO tblProductContentLocationCustomerZone (
		ProductContentLocationCustomerZoneID,
		ProductContentLocationID,
		CustomerZoneID,
		DBDateUpdated
	)
	SELECT
		T.ProductContentLocationCustomerZoneID
		, T.ProductContentLocationID
		, T.CustomerZoneID
		, T.DBDateUpdated
	FROM
		#vueProductContentLocationCustomerZone T
		LEFT JOIN tblProductContentLocationCustomerZone PCLC ON T.ProductContentLocationCustomerZoneID = PCLC.ProductContentLocationCustomerZoneID
	WHERE
		PCLC.ProductContentLocationCustomerZoneID IS NULL
	
END



GO
