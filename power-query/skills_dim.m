let
    Source = star_schema_files,
    #"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_skills_dim csv" = Source{[#"Folder Path"="D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\",Name="skills_dim.csv"]}[Content],
    #"Imported CSV" = Csv.Document(#"D:\Power BI\PowerBI_Data_Analytics_Course\Data\star_schema_files\_skills_dim csv",[Delimiter=",", Columns=3, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Imported CSV", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"skill_id", Int64.Type}, {"skills", type text}, {"type", type text}}),
    #"Capitalized Each Word" = Table.TransformColumns(#"Changed Type",{{"skills", Text.Proper, type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Capitalized Each Word","Sql","SQL",Replacer.ReplaceText,{"skills"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","sql","SQL",Replacer.ReplaceText,{"skills"}),
    #"Added Conditional Column" = Table.AddColumn(#"Replaced Value1", "skills_clean", each if [skills] = "Html" then "HTML" else if [skills] = "Css" then "CSS" else if [skills] = "Sas" then "SAS" else if [skills] = "Sass" then "SAS" else if [skills] = "Php" then "PHP" else if [skills] = "Power Bi" then "Power BI" else if [skills] = "Powerbi" then "Power BI" else if [skills] = "Aws" then "AWS" else if [skills] = "Gcp" then "GCP" else if [skills] = "Dax" then "DAX" else [skills])
in
    #"Added Conditional Column"