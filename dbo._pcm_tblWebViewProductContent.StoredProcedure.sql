USE [dBuilder_Master]
GO
/****** Object:  StoredProcedure [dbo].[_pcm_tblWebViewProductContent]    Script Date: 3/28/2017 12:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[_pcm_tblWebViewProductContent]  
AS  
BEGIN  
 SET NOCOUNT ON  
 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
  
 DECLARE @LastUpdate DATETIME, @PushDate DATETIME  
 SELECT @LastUpdate = MAX(LastUpdate) FROM tblWebViewProductContent (NOLOCK)  
 SET @PushDate = dbo.TruncTime(GETDATE()+1)  
  
 --CREATE VIEW vuedCatalog_ProductContent  
 --AS  
 --SELECT * FROM dAP.dbo.tblProductContent  
 IF @LastUpdate IS NULL   
 BEGIN  
  SET @LastUpdate = '01/01/2000'  
 END  
  
 EXEC SRVDCATALOG.dCatalog.dbo.spjHandleUniqueProductContent  
   
 SELECT  
  *  
 INTO #vueWebViewProductContent  
 FROM vuedCatalog_ProductContent  
 WHERE  
  LastUpdate >= @LastUpdate  
 AND (  
  TargetPushDate <= @PushDate  
  OR  
  ( ProductContentStatusID IN (2, 4) AND TargetPushDate IS NULL )  
 )  
  
 DELETE   
  WVPC  
 FROM   
 tblWebViewProductContent WVPC  
 INNER JOIN #vueWebViewProductContent T ON T.ProductContentID = WVPC.ProductContentID  
  
 DELETE T FROM #vueWebViewProductContent T WHERE T.ProductContentStatusID NOT IN (2, 3)  
  
  
 INSERT INTO tblWebViewProductContent (  
  ProductContentID  
  , ProductContentTypeID  
  , ArtistID  
  , MetaProductID  
  , ItemDisplayedTypeID  
  , CategoryID  
  , ProductContentLocationID  
  , LanguageID  
  , ProductContent  
  , Quote  
  , QuoteAuthor  
  , Links  
  , Tags  
  , RelatedItems  
  , LastUpdate  
 )  
 SELECT  
  T.ProductContentID  
  , T.ProductContentTypeID  
  , T.ArtistID  
  , T.MetaProductID  
  , T.ItemDisplayedTypeID  
  , T.CategoryID  
  , T.ProductContentLocationID  
  , T.LanguageID  
  , T.ProductContent  
  , T.Quote  
  , T.QuoteAuthor  
  , T.Links  
  , T.Tags  
  , T.RelatedItems  
  , T.LastUpdate  
 FROM  
  #vueWebViewProductContent T  
  LEFT JOIN tblWebViewProductContent WVPC ON T.ProductContentID = WVPC.ProductContentID  
 WHERE  
  WVPC.ProductContentID IS NULL  
   
END 



GO
