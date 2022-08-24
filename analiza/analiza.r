# 4. faza: Napredna analiza podatkov

library(ggplot2)
library(GGally)
library(mgcv)

#Napovedi s kvadratno regresijo

#Napoved za povprečni mesečni indeks cen v Sloveniji za leti 2023 i
slovenija_mesec_indeks <- slovenija_mesecno %>% filter(Leto %in% c(2022,2021,2020,2019,2018,2017,2016,2015,2014)) %>% select(Leto, Mesec,`Mesečni indeks (mesec / prejšnji mesec)`)
slovenija_mesec_indeks <- aggregate(x=slovenija_mesec_indeks$`Mesečni indeks (mesec / prejšnji mesec)`, 
                       by = list(slovenija_mesec_indeks$Leto),
                       FUN=mean)
prilagodi <- lm(data = slovenija_mesec_indeks, `x`~I(Group.1^2) +Group.1)
graf5 <- data.frame(Group.1 = seq(2023, 2024, 1))
napoved <- mutate(graf5, napovedan_indeks=predict(prilagodi,graf5))

graf_regres <- ggplot(slovenija_mesec_indeks, aes(x=Group.1, y=`x`))+
  geom_point() + geom_smooth(method = lm, formula =y~ x + I(x^2), fullrange = TRUE, color = 'blue')+
  geom_point(data = napoved, aes(x=Group.1, y=napovedan_indeks), color='red', size = 2) 
graf_regres  


#Napoved po mesecih za leto 2022
evropa_povprecno <- evropa[-c(270:9684),] %>% filter(Leto == 2022) %>% na.omit()
evropa_povprecno$Mesec <- as.numeric(evropa_povprecno$Mesec)
prilagodi2 <- lm(data = evropa_povprecno, `indeks`~I(Mesec^2) +Mesec)
graf6 <- data.frame(Mesec = seq(5, 6, 1))
napoved2 <- mutate(graf6, napovedan_indeks2=predict(prilagodi2,graf6))

graf_regres2 <- ggplot(evropa_povprecno, aes(x=Mesec, y=`indeks`))+
  geom_point() + geom_smooth(method = lm, formula =y~ x + I(x^2), fullrange = TRUE, color = 'blue')+
  geom_point(data = napoved2, aes(x=Mesec, y=napovedan_indeks2), color='red', size = 2) 
graf_regres2  
