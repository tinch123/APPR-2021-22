# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(tmap)



ggplot(stack())

#Graf, ki prikazuje gibanje povprečnega letnega indeksa v Sloveniji
tabela1 <- slovenija_mesecno %>% group_by(Leto) %>% summarize("Povprečni letni indeks" =mean(`Povprečni letni indeks`))
graf1 <- ggplot(tabela1, aes(x=Leto)) +
  geom_line((aes(y=`Povprečni letni indeks`)), color= "blue")+
  geom_point((aes(y=`Povprečni letni indeks`)), color= "purple")+
  ggtitle("Povprečni letni inflacijski indeks v Sloveniji") 

graf1

dev.off()


#Graf, ki primerja povprečne indekse cen Europske unije in Slovenije za leta 2015-2022
tabela2 <- evropa %>% na.omit() %>% group_by(Leto, TIME) %>% summarize("Indeks" =mean(`indeks`)) %>% filter(Leto %in% c(2022,2021,2020,2019,2018,2017,2016,2015), TIME %in% c("EU_povprečje", "Slovenia"))
tabela3 <- evropa %>% na.omit() %>% group_by(Leto, TIME) %>% summarize("Indeks" =mean(`indeks`)) %>% filter(Leto == 2021)

graf2 <- ggplot(tabela2, aes(x=Leto, y=Indeks, fill=TIME))+ geom_bar(stat="identity", position = position_dodge())+
  theme_bw()+
  #geom_line((aes(y=`Povprečni letni indeks`)), color= "blue")+
  # ylab("test") +
  # xlab()+
  ggtitle("Primerjava povprečnega inflacijskega indeksa EU in Slovenije")+
  labs(fill= "Države")
 graf2 

#Graf, ki prikazuje gibanje povprečnega indeksa na različnih področjih v EU
tabela4 <- evropa_indeks %>% group_by(Leto, Sektorji) %>% summarize("Indeks" =mean(`indeks`)) %>% filter(Leto %in% c(2022,2021,2020,2019,2018))
#ggplot(tabela4, aes(x=Leto, y =Indeks), group=Sektorji)+
#  geom_line(aes(color=Sektorji, linetype=Sektorji),lwd=1.1)+ 
#  scale_color_manual(values = c("darkred", "steelblue","red","blue","green","black","yellow","purple","orange","pink","brown","darkgreen"))
graf3 <- ggplot(data=tabela4, aes(x=Leto, y=Indeks, group=Sektorji, colour=Sektorji)) +
  geom_line() +
  geom_point()+
  ggtitle("Povprečni indeks cen v Evropi na različnih potrebščinah") 
graf3

#Graf gibanja cen življenskih potrebščin v Sloveniji
tabela5 <- slovenija_indeks[-c(1:528),] %>% filter(LETO %in% c(2022,2021,2020,2019,2018,2017,2016)) %>% mutate(`Indeksi cen življenjskih potrebščin in letne stopnje rasti cen`= as.numeric(`Indeksi cen življenjskih potrebščin in letne stopnje rasti cen`))
graf4 <- ggplot(data=tabela5, aes(x=LETO, y=`Indeksi cen življenjskih potrebščin in letne stopnje rasti cen`, group=SKUPINE, colour=SKUPINE)) +
  geom_line() +
  geom_point()+
  ggtitle("Graf gibanja cen življenskih potrebščin v Sloveniji") 
graf4  

#Zemljevidi
source('lib/uvozi.zemljevid.r')
source('lib/libraries.r', encoding = 'UTF-8')


zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
                             pot.zemljevida="OB", encoding="Windows-1250")

data("World")

svet <- tm_shape(World) + tm_polygons("HPI", border.col = "black")
evropadrzave <- World%>%filter(continent == "Europe")
names(evropadrzave)


#Zemljevid, ki prikazuje indeks cen za Evropo leta 2022
evropa2 <- read_csv2("podatki/evropa11.csv", skip=,
                    locale=locale(encoding="Windows-1250"))
evropa2 <- evropa2[-c(1:7,35),]
evropa2 <- evropa2 %>% pivot_longer(cols=2:270, names_to = "čas", values_to="indeks") %>% 
  separate(čas, sep="-", into=c("Leto", "Mesec"))
evr_cene <- evropa2 %>% group_by(Leto) %>% select(TIME, indeks) %>% filter(Leto == 2022)
evr_cene <- evr_cene  %>% drop_na()
evr_cene <- aggregate(x=evr_cene$indeks, 
                       by = list(evr_cene$TIME),
                       FUN=mean)
evr_cene[11,1] <- "Germany"
evr_cene[6,1] <- "Czech Rep."


zemljevid.evrope <- function(){
  evro <- World 
  cene <- evr_cene 
  podatki <- merge(y=cene, x=evro, by.x='name', by.y='Group.1')
  evrop <- tm_shape(podatki) + tm_polygons('x',  breaks = c(40,50,60,70,80,90,100, 110, 115, 120, 130, 150, 200, 300,400),legend.hist = TRUE)
  tmap_mode('view')
  return(evrop)
}
zemljevid.evrope()


#Zemljevid, ki prikazuje indeks cen za Evropo leta 2008
evropa3 <- read_csv2("podatki/evropa11.csv", skip=,
                     locale=locale(encoding="Windows-1250"))
evropa3 <- evropa3[-c(1:7,35),]
evropa3 <- evropa3 %>% pivot_longer(cols=2:270, names_to = "čas", values_to="indeks") %>% 
  separate(čas, sep="-", into=c("Leto", "Mesec"))
evr_cene2 <- evropa3 %>% group_by(Leto) %>% select(TIME, indeks) %>% filter(Leto == 2008)
evr_cene2 <- evr_cene2  %>% drop_na()
evr_cene2 <- aggregate(x=evr_cene2$indeks, 
                      by = list(evr_cene2$TIME),
                      FUN=mean)
evr_cene2[11,1] <- "Germany"
evr_cene2[6,1] <- "Czech Rep."

zemljevid.evrope2 <- function(){
  evro2 <- World 
  cene2 <- evr_cene2 
  podatki2 <- merge(y=cene2, x=evro2, by.x='name', by.y='Group.1')
  evrop2 <- tm_shape(podatki2) + tm_polygons('x',  breaks = c(40,50,60,70,80,90,100, 110, 115, 120, 130, 150, 200, 300,400),legend.hist = TRUE)
  tmap_mode('view')
  return(evrop2)
}
zemljevid.evrope2()


#Zemljevid, ki prikazuje inflacijski indeks (v procentnih točkah) za hrano in nealkoholne pijače za leto 2021 glede na 2020
hrana <- evropa_sektor[,-2] %>% filter(Time == 2021)
hrana <- hrana[,-2]

hrana[13,1] <- "Czech Rep."
hrana[12,1] <- "Slovakia"
hrana[35,1] <- "Turkey"


zemljevid.evrope3 <- function(){
  evro3 <- World 
  hrana1 <- hrana 
  podatki3 <- merge(y=hrana1, x=evro3, by.x='name', by.y='Country')
  evrop3 <- tm_shape(podatki3) + tm_polygons('Value',breaks = c(-10,-5,-2,-1,0,5,10,15, 20, 30, 40, 50),legend.hist = TRUE)
  tmap_mode('view')
  return(evrop3)
}
zemljevid.evrope3()
