USE [dBuilder_Master]
GO
/****** Object:  UserDefinedFunction [dbo].[APCAddAppendWord]    Script Date: 3/28/2017 12:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[APCAddAppendWord](@String as nvarchar(255), @LanguageID as int)
Returns nvarchar(255)
AS
Begin
	select @String = case when @LanguageID = 1 then
		 	@String + case when right(@String,7) = 'Posters'  then '' when  right(@String,6) = 'Poster'  then 's'  else '-Posters' end 
		when @LanguageID = 2 then
			@String + case when left(@String,8)= 'Affiches' then '' else '-Affiches' end 
		when @LanguageID = 3 then
			@String + case when right(@String,6) = 'Poster' or left (@String, 6) = 'poster' then '' else '-Poster' end 
		when @LanguageID = 4 then
			@String + case when right(@String,8) = 'Posteres' or left(@String,8) = 'Posteres' then '' else '-Posteres' end 
		when @LanguageID = 5 then
		 	@String + case when right(@String,7) = 'Posters'  then '' when  right(@String,6) = 'Poster'  then 's'  else '-Posters' end 
		when @LanguageID = 6 then
		 	@String + case when right(@String,7) = 'Posters'  then '' when  right(@String,6) = 'Poster'  then 's'  else '-Posters' end 
		when @LanguageID = 7 then
			@String + case when right(@String,6) = 'Poster' then '' else '-Poster' end 
		 	--@String + '-Poster'
		 	--Commented the following to change as per SEO requirements
		 	/*
		when @LanguageID = 8 then
		 	@String + case when right(@String,7) = 'Posters'  then '' when  right(@String,6) = 'Poster'  then 's'  else '-posters' end 
		 	--@String + '-posters'
		when @LanguageID = 9 then
			@String + case when right(@String,8)= 'plakater' then '' else '-plakater' end 
		 	--@String + '-plakater'
		when @LanguageID = 10 then
			@String + case when right(@String,8)= 'plakater' then '' else '-plakater' end 
		 	--@String + '-plakater'
		when @LanguageID = 11 then
		 	@String + case when right(@String,7) = 'Posters'  then '' when  right(@String,6) = 'Poster'  then 's'  else '-posters' end 
		 	--@String + '-posters'
		 	*/
		when @LanguageID = 8 then
		 	@String + '-posters'
		when @LanguageID = 9 then
			@String + '-plakater'
		when @LanguageID = 10 then
			@String + '-plakater'
		when @LanguageID = 11 then
		 	@String + '-posters'
		when @LanguageID = 12 then
			@String + '-posters' 
		when @LanguageID = 13 then
		 	@String + '-plakaty'
		when @LanguageID = 14 then -- this should be changed once SEO requirements are available
			@String + N'-海报' 
		when @LanguageID = 15 then
		 	@String + '-Posterler'
		when @LanguageID = 16 then
		 	@String + '-Plakaty'
		end
	return @String
end 



GO
