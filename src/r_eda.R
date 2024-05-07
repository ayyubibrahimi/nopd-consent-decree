## ------------------ DF dataframe created in this python code ---------------

# import matplotlib.pyplot as plt
# import seaborn as sns
# import pandas as pd
# import plotly.express as px
# from helper import clean_column_names
# 
# 
# 
# dfa = pd.read_csv("brady_2016_2023.csv")
# 
# 
# def clean_table(df):
#   df.loc[:, "last_name"] = df.last_name.str.replace(r"\'RULE(.+)", "", regex=True).str.replace(r"^\'$", "", regex=True)
# 
# df = df[~((df.last_name.fillna("") == ""))]
# 
# df.loc[:, "tracking_id"] = df.tracking_id.str.replace(r"^\'", "", regex=True)
# 
# df = df.sort_values("tracking_id", ascending=False)
# 
# df.loc[:, "allegation"] = df.allegation_rule.str.cat(df.allegation_paragraph, sep=" ")
# 
# df.loc[:, "allegation"] = df.allegation.str.lower().str.strip().str.replace(r"\'", "", regex=True)
# 
# df = df.drop(columns=["allegation_rule", "allegation_paragraph", "Disposition"])
# 
# df.loc[:, "allegation_desc"] = (df.allegation_desc
#                                 .str.replace(r"\'$", "", regex=True)
#                                 .str.replace(r"^$", "missing", regex=True)
# )
# 
# return df 
# 
# dfa = dfa.pipe(clean_table)
# 
# dfa.loc[:, "tracking_id"] = dfa.tracking_id.str.lower().str.strip().str.replace(r"\s+", "", regex=True).str.replace(r"\'", "", regex=True)
# 
# dfa
# 
# doubles = dfa[dfa.tracking_id.str.contains("2016-0199")]
# 
# doubles
# doubles.allegation_desc.unique()
# 
# 
# dfb = pd.read_csv("data_nola_gov.csv")
# 
# dfb = dfb.rename(columns={"Complaint Tracking Number": "tracking_id"})
# 
# dfb = dfb[['tracking_id' ,'Date Complaint Occurred',
#            'Date Complaint Received by NOPD (PIB)',
#            'Date Complaint Investigation Complete', 'Complaint classification', 'Bureau of Complainant',
#            'Division of Complainant', 'Unit of Complainant',
#            'Unit Additional Details of Complainant', 
#            'Working Status of Complainant', 'Shift of Complainant',
#            'Rule Violation', 'Paragraph Violation', 'Unique Officer Allegation ID',
#            'Officer Race Ethnicity', 'Officer Gender', 'Officer Age',
#            'Officer years of service', 'Complainant Gender',
#            'Complainant Ethnicity', 'Complainant Age', "Disposition"]]
# 
# dfb.loc[:, "tracking_id"] = dfb.tracking_id.str.lower().str.strip().str.replace(r"\s+", "", regex=True)
# 
# 
# doubles_b = dfb[dfb.tracking_id.fillna("").str.contains("2016-0629")]
# 
# doubles_b
# 
# 
# df = pd.merge(dfa, dfb, on="tracking_id")
# 
# df = df.drop_duplicates(subset=["allegation_number"])
# 
# df.to_csv("df.csv")
# 
# 
# 
# df.loc[:, "allegation_desc"] = df.allegation_desc.str.lower().str.strip()
# 
# df.loc[:, "Disposition"] = df["Disposition"].str.lower().str.strip()
# 
# 
# top_allegations = df['allegation'].value_counts().head(25)
# 
# # Create a horizontal bar chart
# fig = px.bar(top_allegations, orientation='h', labels={'index': 'Allegation', 'value': 'Count'}, 
#              title='Top 25 Allegations')
# fig.update_layout(
#   xaxis_title="Count",
#   yaxis_title="Allegation",
#   yaxis={'categoryorder':'total ascending'},
#   height=900  # Adjusted for better visibility with more categories
# )
# fig.update_yaxes(automargin=True, tickmode='array', tickvals=list(range(len(top_allegations))), ticktext=top_allegations.index)
# fig.show()
# 
# 
# df = df[~((df.allegation_desc == "missing"))]
# 
# # Top 25 allegation descriptions
# top_allegation_desc = df['allegation_desc'].value_counts().head(25)
# fig_desc = px.bar(top_allegation_desc, orientation='h', labels={'index': 'Allegation Description', 'value': 'Count'},
#                   title='Top 25 Allegation Descriptions')
# fig_desc.update_layout(
#   xaxis_title="Count",
#   yaxis_title="Allegation Description",
#   yaxis={'categoryorder':'total ascending'},
#   height=800  # Increased height to accommodate more bars
# )
# fig_desc.update_yaxes(automargin=True, tickmode='array', tickvals=list(range(len(top_allegation_desc))), ticktext=top_allegation_desc.index)
# fig_desc.show()
# 
# 
# 
# df.loc[:, "tag"] = (df
#                     .allegation_desc
#                     .str.lower()
#                     .str.replace(r"(.+)(domestic violence|domestic abuse|domestic battery)(.+)?", "domestic violence", regex=True)
#                     .str.replace(r"(.+)battery(.+)?", "battery", regex=True)
#                     .str.replace(r"(.+)?rape(.+)?", "rape", regex=True)
#                     .str.replace(r"(.+)sexual harassment(.+)?", "sexual harassment", regex=True)
#                     .str.replace(r"(.+)assault(.+)?", "assault", regex=True)
#                     .str.replace(r"(.+)body-? ?worn cameras?(.+)?", "body worn camera", regex=True)
#                     .str.replace(r"(.+)theft(.+)?", "theft", regex=True)
#                     .str.replace(r"(.+)stop(.+)?", "terry stop", regex=True)
#                     .str.replace(r"(.+)(authorized firearm|pr312 firearms|possession of a firearm)(.+)?", "firearms")
#                     .str.replace(r"(.+)(firearms training|firearms recertification)(.+)?", "firearms training")
#                     .str.replace(r"(.+)bias(.+)?", "biased based policing", regex=True)
#                     .str.replace(r"(.+)stalking(.+)?", "stalking", regex=True)
#                     .str.replace(r"(.+)(search & seizure|search and seizure)(.+)?", "search and seizure", regex=True)
#                     .str.replace(r"(.+)supervise(.+)?", "failure to supervise", regex=True)
#                     .str.replace(r"(.+)use of force(.+)?", "use of force", regex=True)
#                     .str.replace(r"(.+)?necessary police action(.+)?", "failure to take appropriate and necessary action", regex=True)
#                     .str.replace(r"(.+)?collect(.+)?", "failure to collect, preserve, and identify evidence", regex=True)
#                     .str.replace(r"(.+)?payroll(.+)?", "payroll fraud", regex=True)
#                     .str.replace(r"^\'((.+)to cruelty to juveniles|(.+)relative to indecent behavior with juvenile|(.+)relative to indecent behavior with a juvenile|(.+)relative to molestation of a juvenile|(.+)cruelty to juveniles|(.+)?child abuse(.+)?)", "violence against juvenile", regex=True)
# )
# 
# 
# df = df[~((df.tag.fillna("") == ""))]

## ----------------------- R Analysis ------------------------------------

# Loading Libraries
library(tidyverse)
library(janitor)

# Loading + Cleaning Data + Adding Variables
df <- read_csv("df.csv") %>%
  clean_names() %>%
  mutate(complainant_ethnicity = tolower(complainant_ethnicity),
         complainant_ethnicity = case_when(
           complainant_ethnicity == "b" ~ "black",
           complainant_ethnicity == "w" ~ "white",
           str_detect(complainant_ethnicity, "unknown|unkown") ~ "unknown",
           complainant_ethnicity == "o" ~ "unknown",
           TRUE ~ complainant_ethnicity
         ),
         poc = complainant_ethnicity %in% c("black", "asian", "indian","hispanic"),
         bad = str_detect(tag,"domestic violence|battery|rape|assault|violence against juvenile"),
         sustain = disposition == 'sustained'
  )

# N Allegation
nrow(df)

# N Allegation Violent 
nrow(df %>% filter(bad == TRUE))

# All Allegation Sustain Rate
df %>%
  tabyl(disposition)

# All Allegation Public Rate
df %>%
  tabyl(incident_type)

# All Allegation Sustain Public vs. Internal Rates
df %>%
  tabyl(sustain,incident_type) %>%
  adorn_percentages()

# Types of Violent Allegations
df %>%
  filter(bad == TRUE) %>%
  tabyl(tag)

# Rate of Violent Allegations per Year
df %>%
  tabyl(year,bad) %>%
  adorn_percentages()

# Paragraph Description of violent allegations 
df %>%
  filter(bad == TRUE) %>%
  tabyl(paragraph_violation)

# Paragraph Description of violent allegations by tag
df %>%
  filter(bad == TRUE) %>%
  tabyl(paragraph_violation, tag)

# Dispositions given to violent allegations
df %>%
  filter(bad == TRUE) %>%
  tabyl(disposition)

# Sustain rate for each violent allegation 
df %>%
  filter(bad == TRUE) %>%
  mutate(sustained = disposition == "sustained") %>%
  tabyl(tag, sustained) %>%
  adorn_percentages()

# Sustain rate for each violent allegation internal vs. external
df %>%
  filter(bad == TRUE) %>%
  mutate(sustained = disposition == "sustained") %>%
  tabyl(incident_type,sustained,tag)

# Rate of POC violated
df %>%
  filter(!is.na(complainant_ethnicity)) %>%
  tabyl(bad, poc) %>%
  adorn_percentages()

# Top 20 allegations
df %>%
  tabyl(allegation) %>%
  arrange(-n) %>%
  mutate(percent = paste0(100*round(percent,4), "%")) %>%
  head(20)

# Top 20 allegation descriptions
df %>%
  filter(allegation_desc != "missing") %>%
  tabyl(allegation_desc) %>%
  arrange(-n) %>%
  mutate(percent = paste0(100*round(percent,4), "%")) %>%
  head(20)

# Top Domestic Violence over Years
df %>%
  group_by(year) %>%
  summarize(dv_count = sum(tag == "domestic violence"),
            dv_rate = paste0(100*round(dv_count/n(),4),"%"))


# Sustain Rate of Allegations
df %>%
  mutate(grouping = case_when(
    tag %in% c("rape", "domestic violence", "battery", "assault", "violence against juvenile") ~ tag,
    TRUE ~ "other"
  )) %>%
  group_by(grouping, incident_type) %>%
  summarize(sustained = sum(sustain)/n(), .groups = "drop") %>%
  pivot_wider(names_from = incident_type, values_from = sustained) %>%
  mutate(grouping = str_to_title(grouping),
         public = paste0(100*round(`'Public Initiated`,4),"%"),
         internal = paste0(100*round(`'Rank Initiated`,4),"%")) %>%
  select(-c(`'Public Initiated`, `'Rank Initiated`))

