# 2. faza: Uvoz podatkov
source('lib/libraries.r')

library(readr)
library(tidyr)
library(dplyr)
library(readxl)

slsl <- locale("sl", decimal_mark=",", grouping_mark=".")

#1. tabela z mesečnimi indeksi in povprečnimi letnimi indeksi
slovenija_mesecno <- read_csv2("podatki/slovenija11.csv", skip=, na=c("", "..."),
                               locale=locale(encoding="Windows-1250")) %>% separate(MESEC, sep="M", into=c("Leto", "Mesec"))
slovenija_mesecno$Leto <- as.numeric(slovenija_mesecno$Leto)


#2. tabela z indeksi cen v Evropi
evropa <- read_csv2("podatki/evropa11.csv", skip=,
                    locale=locale(encoding="Windows-1250"))
evropa <- evropa[-c(1,2,4,5,6,7,35),]
evropa[1,] <- evropa %>% filter(TIME == "European Union - 27 countries (from 2020)") %>% mutate(TIME = "EU_povprečje")
evropa <- evropa %>% pivot_longer(cols=2:270, names_to = "čas", values_to="indeks") %>% 
          separate(čas, sep="-", into=c("Leto", "Mesec"))


#3. tabela z indeksi inflacije na različnih sektorjih v Evropskih državah
evropa_indeks <- read_csv("podatki/evropaindex.csv", na=c("", "..."),
                          locale=locale(encoding="Windows-1250"))
evropa_indeks[1,1] <- "Hrana in brezalkoholne pijače"
evropa_indeks[2,1] <- "Alkoholne pijače in tobak"
evropa_indeks[3,1] <- "Oblačila in obutev"
evropa_indeks[4,1] <- "Stanovanja, voda, električna energija, plin in drugo gorivo"
evropa_indeks[5,1] <- "Stanovanjska in gospodinjska oprema in tekoče vzdrževanje stanovanj"
evropa_indeks[6,1] <- "Zdravstvo"
evropa_indeks[7,1] <- "Prevoz"
evropa_indeks[8,1] <- "Komunikacije"
evropa_indeks[9,1] <- "Rekreacija in kultura"
evropa_indeks[10,1] <- "Izobraževanje"
evropa_indeks[11,1] <- "Restavracije in hoteli"
evropa_indeks[12,1] <- " Raznovrstno blago in storitve"

evropa_indeks <- evropa_indeks %>% pivot_longer(cols=2:246, names_to = "čas", values_to="indeks")  %>% 
          separate(čas, sep="-", into=c("Leto", "Mesec"))


#4. tabela z indeksom cen na različnih sektorjih v Sloveniji
slovenija_indeks <- read_csv2("podatki/sloindeks.csv", na=c("", "..."),
                             locale=locale(encoding="Windows-1250"))


#5. tabela z odstotno spremembo glede na prejšnje leto za Evropo
evropa_sektor <- read_csv("podatki/evropasektor.csv", na=c("", "..."),
                          locale=locale(encoding="Windows-1250"))
evropa_sektor <- evropa_sektor[,-c(1,3,5:9,11:16,18:19),drop=FALSE] 



 