let
    Source = star_schema_files,
    #"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_company_dim csv" = Source{[#"Folder Path"="D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\",Name="company_dim.csv"]}[Content],
    #"Imported CSV" = Csv.Document(#"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_company_dim csv",[Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"company_id", Int64.Type}, {"name", type text}, {"link", type text}, {"link_google", type text}, {"thumbnail", type text}})
in
    #"Changed Type"