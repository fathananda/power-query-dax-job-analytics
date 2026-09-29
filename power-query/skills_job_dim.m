let
    Source = star_schema_files,
    #"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_skills_job_dim csv" = Source{[#"Folder Path"="D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\",Name="skills_job_dim.csv"]}[Content],
    #"Imported CSV" = Csv.Document(#"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_skills_job_dim csv",[Delimiter=",", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"job_id", Int64.Type}, {"skill_id", Int64.Type}})
in
    #"Changed Type"