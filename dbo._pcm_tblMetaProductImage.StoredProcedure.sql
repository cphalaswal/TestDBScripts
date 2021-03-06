USE [dBuilder_Master]
GO
/****** Object:  StoredProcedure [dbo].[_pcm_tblMetaProductImage]    Script Date: 3/28/2017 12:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[_pcm_tblMetaProductImage]
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	--CREATE VIEW vuedCatalog_tblMetaProductImage
	--AS
	--SELECT * FROM dAP.dbo.tblMetaProductImage

	SELECT
		*
	INTO #vueMetaProductImage
	FROM vuedCatalog_MetaProductImage

	BEGIN TRY

		BEGIN TRANSACTION 
	
		--TRUNCATE TABLE tblMetaProductImage
		DELETE MPI FROM tblMetaProductImage MPI WHERE NOT EXISTS (SELECT 1 FROM #vueMetaProductImage M WHERE M.MetaProductImageID = MPI.MetaProductImageID)

		INSERT INTO tblMetaProductImage (
			MetaProductImageID,
			MetaProductID,
			ImageID,
			DBDateUpdated
		)
		SELECT
			T.MetaProductImageID,
			T.MetaProductID,
			T.ImageID,
			T.DBDateUpdated
		FROM
			#vueMetaProductImage T
			LEFT JOIN tblMetaProductImage MPI ON T.MetaProductImageID = MPI.MetaProductImageID
		WHERE
			MPI.MetaProductImageID IS NULL

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END

	END CATCH	
END



GO
