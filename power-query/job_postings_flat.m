let
    Source = Csv.Document(File.Contents("D:\Power BI\PowerBI_Data_Analytics_Course\Data\job_postings_flat.csv"),[Delimiter=",", Columns=17, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"job_title_short", type text}, {"job_title", type text}, {"job_location", type text}, {"job_via", type text}, {"job_schedule_type", type text}, {"job_work_from_home", type logical}, {"search_location", type text}, {"job_posted_date", type datetime}, {"job_no_degree_mention", type logical}, {"job_health_insurance", type logical}, {"job_country", type text}, {"salary_rate", type text}, {"salary_year_avg", Int64.Type}, {"salary_hour_avg", type number}, {"company_name", type text}, {"job_skills", type text}, {"job_type_skills", type text}}),
    #"Inserted Multiplication" = Table.AddColumn(#"Changed Type", "Multiplication", each [salary_hour_avg] * 2080, type number),
    #"Reordered Columns" = Table.ReorderColumns(#"Inserted Multiplication",{"job_title_short", "job_title", "job_location", "job_via", "job_schedule_type", "job_work_from_home", "search_location", "job_posted_date", "job_no_degree_mention", "job_health_insurance", "job_country", "salary_rate", "salary_year_avg", "Multiplication", "salary_hour_avg", "company_name", "job_skills", "job_type_skills"}),
    #"Renamed Columns" = Table.RenameColumns(#"Reordered Columns",{{"Multiplication", "salary_hour_adj_yearly"}})
in
    #"Renamed Columns"