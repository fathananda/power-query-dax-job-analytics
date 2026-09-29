let
    Source = job_postings_fact,
    #"Removed Columns" = Table.RemoveColumns(Source,{"company_id", "job_title_short", "job_title", "job_location", "job_via", "job_work_from_home", "search_location", "job_posted_datetime", "job_no_degree_mention", "job_health_insurance", "job_country", "salary_rate", "salary_year_avg", "salary_hour_avg"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Columns",", and",",",Replacer.ReplaceText,{"job_schedule_type"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value"," and",",",Replacer.ReplaceText,{"job_schedule_type"}),
    #"Split Column by Delimiter" = Table.ExpandListColumn(Table.TransformColumns(#"Replaced Value1", {{"job_schedule_type", Splitter.SplitTextByDelimiter(",", QuoteStyle.None), let itemType = (type nullable text) meta [Serialized.Text = true] in type {itemType}}}), "job_schedule_type"),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"job_schedule_type", type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Changed Type",{{"job_schedule_type", Text.Trim, type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Trimmed Text", each ([job_schedule_type] <> ""))
in
    #"Filtered Rows"