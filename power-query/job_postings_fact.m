let
    Source = star_schema_files,
    #"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_job_postings_fact csv" = Source{[#"Folder Path"="D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\",Name="job_postings_fact.csv"]}[Content],
    #"Imported CSV" = Csv.Document(#"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_job_postings_fact csv",[Delimiter=",", Columns=16, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"job_id", Int64.Type}, {"company_id", Int64.Type}, {"job_title_short", type text}, {"job_title", type text}, {"job_location", type text}, {"job_via", type text}, {"job_schedule_type", type text}, {"job_work_from_home", type logical}, {"search_location", type text}, {"job_posted_date", type datetime}, {"job_no_degree_mention", type logical}, {"job_health_insurance", type logical}, {"job_country", type text}, {"salary_rate", type text}, {"salary_year_avg", Int64.Type}, {"salary_hour_avg", type number}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","via ","",Replacer.ReplaceText,{"job_via"}),
    #"Renamed Columns" = Table.RenameColumns(#"Replaced Value",{{"job_posted_date", "job_posted_datetime"}})
in
    #"Renamed Columns"