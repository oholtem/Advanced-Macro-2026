# ***************************************************************************
# *** Advanced Macroeconomics
# *** Figures for Chapter 1
# *** Oliver Holtemoeller
# *** This version: Winter 2026/2027
# *** UTF-8
# ***************************************************************************

library(tidyverse)
library(this.path)
library(ggthemes)
library(scales)
library(readxl)

rm(list=ls())

MyDir <- this.dir()
setwd(MyDir)

source("../MyColors.R")

# Read Penn World Table 11 -----
# Download the PWT Excel file from https://www.rug.nl/ggdc/productivity/pwt/?lang=en and provide path
PWT_Path <- "../../../Local/"
FileName <- paste(PWT_Path, "pwt110.xlsx", sep = "")

PWT110 <- read_excel(FileName,
                     sheet="Data",
                     range="A1:AY13691",
                     col_types = c(rep("text",3),
                                   rep("numeric",29),
                                   rep("text",5),
                                   rep("numeric",14)))

# Cross-Country Differences in Per Capita Output and Income -----
breaks <- c(0, 1000, 10000, 20000, 30000, 40000, 50000, 60000, Inf)
custom_labels <- c(
  "< 1,000", "1,000-10,000", "10,000-20,000", "20,000-30,000",
  "30,000-40,000", "40,000-50,000", "50,000-60,000", "> 60,000"
)

CGDPPC_2023 <- PWT110 %>% 
  filter(year == 2023) %>% 
  mutate(gdppc = cgdpe/pop) %>% 
  select(countrycode, country, gdppc) %>%
  mutate(cgdppc_bin = cut(gdppc, breaks = breaks, include.lowest = TRUE, right = FALSE))

P_CGDPPC <- ggplot(CGDPPC_2023, aes(x = cgdppc_bin)) +
  geom_bar(fill = BfBlue, color = "white") +
  scale_x_discrete(labels = custom_labels) +
  labs(
    title = "Distribution of Countries by Per Capita GDP, 2023",
    x = "GDP per Capita (2021 USD)",
    y = "Number of Countries",
    caption = "PWT 11.0"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

P_CGDPPC

ggsave(
  filename = "../../figures/Chapter-01/fig_Distribution-by-CGDPPC.pdf",
  plot = P_CGDPPC,
  device = "pdf",
  width = 15,
  height = 15/1.6,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)

# Evolution of Per Capita Output and Income over Time -----
# Download GMD data from https://www.globalmacrodata.com/data.html
# and provide path
GMD_Path <- "../../../Local/"
FileName <- paste(GMD_Path, "GMD.csv", sep = "")
GMD <- read_csv(FileName)

GDPPC <- GMD %>% 
  filter(ISO3 %in% c("USA", "GBR", "JPN"), year < 2026) %>%
  mutate(rGDP_USD_pc = log(rGDP_USD/pop)) %>% 
  select(countryname, ISO3, year, rGDP_USD_pc) %>% 
  drop_na(rGDP_USD_pc)

P_GDPPC <- ggplot(data = GDPPC, mapping = aes(x=make_date(year=year), y=rGDP_USD_pc)) +
  geom_line(mapping = aes(color=countryname), linewidth = 1.5) +
  theme_minimal() +
  scale_color_manual(values = c(BfVermillon, BfReddishPurple, BfBlue)) +
  scale_x_date(date_labels = "%_Y") +
  scale_y_continuous(labels = scales::number_format(big.mark = ",",
                                                    decimal.mark = "."), limits = c(6,12)) +
  labs(title = "Long-run Growth of GDP per Capita",
       x = "",
       y = "Log per Capita GDP in 2015 USD",
       color = "",
       caption = "Global Macro Database")
  
P_GDPPC

ggsave(
  filename = "../../figures/Chapter-01/fig_Long-run-Growth.pdf",
  plot = P_GDPPC,
  device = "pdf",
  width = 15,
  height = 15/1.6,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)

GDPPC <- GMD %>% 
  filter(ISO3 %in% c("DEU", "GBR", "FRA", "ITA"), year < 2026) %>%
  mutate(rGDP_USD_pc = log(rGDP_USD/pop)) %>% 
  select(countryname, ISO3, year, rGDP_USD_pc) %>% 
  drop_na(rGDP_USD_pc)

P_GDPPC <- ggplot(data = GDPPC, mapping = aes(x=make_date(year=year), y=rGDP_USD_pc)) +
  geom_line(mapping = aes(color=countryname), linewidth = 1.5) +
  theme_minimal() +
  scale_color_manual(values = c(BfSkyBlue, BfOrange, BfBluishGreen, BfReddishPurple)) +
  scale_x_date(date_labels = "%_Y") +
  scale_y_continuous(labels = scales::number_format(big.mark = ",",
                                                    decimal.mark = "."), limits = c(6,12)) +
  labs(title = "Long-run Growth of GDP per Capita",
       x = "",
       y = "Log per Capita GDP in 2015 USD",
       color = "",
       caption = "Global Macro Database")

P_GDPPC

ggsave(
  filename = "../../figures/Chapter-01/fig_Long-run-Growth-EU.pdf",
  plot = P_GDPPC,
  device = "pdf",
  width = 15,
  height = 15/1.6,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)

# Money Supply and Inflation -----
MONEY <- GMD %>% 
  select(countryname, ISO3, year, M1, CPI) %>% 
  filter(!(ISO3 %in% c("CSK", "YMD", "DDR", "FLK", "GUF", "GLP", "VAT", "MTQ", "ANT", "NIU", "REU", "BLM", "SUN", "SHN", "SPM", "WLF", "ESH", "YUG"))) %>% 
  group_by(countryname, ISO3) %>% 
  summarise(M1 = 100*(M1[year==2024]/M1[year==1970])^(1/(2024-1970))-100,
            CPI = 100*(CPI[year==2024]/CPI[year==1970])^(1/(2024-1970))-100) %>% 
  ungroup() %>% 
  drop_na(M1, CPI)

P_MONEY <- ggplot(data = MONEY, mapping = aes(x=M1, y=CPI)) +
  geom_point(size = 2.5, color = BfBlue) +
  geom_abline(intercept = 0, slope = 1, linewidth = 1.25, color = BfSkyBlue) +
  scale_y_continuous(limits = c(0,100)) +
  scale_x_continuous(limits = c(0,100)) +
  theme_minimal() +
  labs(title = "Money Growth and Inflation in 50 Countries, 1970-2024",
       x = "Money growth (M1, %)",
       y = "Inflation (CPI, %)",
       caption = "Global Macro Database") 
P_MONEY

ggsave(
  filename = "../../figures/Chapter-01/fig_Money-Growth.pdf",
  plot = P_MONEY,
  device = "pdf",
  width = 15,
  height = 15,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)

# Government Debt -----
GOVDEBT <- GMD %>% 
  filter(ISO3 %in% c("USA", "GBR", "JPN"), year < 2026) %>%
  select(countryname, ISO3, year, govdebt_GDP) %>% 
  drop_na(govdebt_GDP)

P_GOVDEBT <- ggplot(data = GOVDEBT, mapping = aes(x=make_date(year=year), y=govdebt_GDP)) +
  geom_line(mapping = aes(color=countryname), linewidth = 1.5) +
  theme_minimal() +
  scale_color_manual(values = c(BfVermillon, BfReddishPurple, BfBlue)) +
  scale_x_date(date_labels = "%_Y") +
  scale_y_continuous(labels = scales::number_format(big.mark = ",",
                                                    decimal.mark = ".")) +
  labs(title = "Government Debt",
       x = "",
       y = "Percent of GDP",
       color = "",
       caption = "Global Macro Database")

P_GOVDEBT

ggsave(
  filename = "../../figures/Chapter-01/fig_Government-Debt.pdf",
  plot = P_GOVDEBT,
  device = "pdf",
  width = 15,
  height = 15/1.6,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)

GOVDEBT <- GMD %>% 
  filter(ISO3 %in% c("DEU", "GBR", "FRA", "ITA"), year < 2026) %>%
  select(countryname, ISO3, year, govdebt_GDP) %>% 
  drop_na(govdebt_GDP)

P_GOVDEBT <- ggplot(data = GOVDEBT, mapping = aes(x=make_date(year=year), y=govdebt_GDP)) +
  geom_line(mapping = aes(color=countryname), linewidth = 1.5) +
  theme_minimal() +
  scale_color_manual(values = c(BfSkyBlue, BfOrange, BfBluishGreen, BfReddishPurple)) +
  scale_x_date(date_labels = "%_Y") +
  scale_y_continuous(labels = scales::number_format(big.mark = ",",
                                                    decimal.mark = ".")) +
  labs(title = "Government Debt",
       x = "",
       y = "Percent of GDP",
       color = "",
       caption = "Global Macro Database")

P_GOVDEBT

ggsave(
  filename = "../../figures/Chapter-01/fig_Government-Debt-EU.pdf",
  plot = P_GOVDEBT,
  device = "pdf",
  width = 15,
  height = 15/1.6,
  units = "cm",
  dpi = 300,
  limitsize = TRUE
)
