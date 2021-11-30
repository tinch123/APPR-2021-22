# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Indeks inflacije v Sloveniji in Evropi
V svojem projektu pri predmetu APPR bom analizirala spremembo indeksa inflacije v Sloveniji in v Evropi.
Inflacija označuje rast ravni cen na splošno, stopnja rasti inflacije pa prikazuje spremembo ravni cen. V Sloveniji se za merilo inflacije uporablja indeks cen življenjskih potrebščin, s katerim merimo spremembe  cen izdelkov in storitev glede na sestavo izdatkov, ki jih domače prebivalstvo namenja za nakupe predmetov končne porabe doma in v tujini.
Analizirala bom spremembo indeksa inflacije v Sloveniji, mesečno od leta 2007 do 2021 in povprečne letne stopnje rasti cen življenjskih potrebščin v Sloveniji (2007-2020) in pa drugod po Evropi (2009-2020).

Tabela 1: Indeks inflacije, Slovenija, mesečno
 * meseci
 * mesečni indeks
 * letni indeks
 * povprečni letni indeks

Tabela 2: Povprečne letne stopnje rasti cen življenjskih potrebščin 
 * leta
 * življenske potrebščine
 * stopnje rasti cen

Tabela 3:
 * leta
 * Evropske države
 * stopnje rasti cen

viri:
https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/H281S.px/table/tableViewLayout2/
https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/H174S.px/table/tableViewLayout2/
https://ec.europa.eu/eurostat/databrowser/view/TEC00118__custom_1679917/default/table?lang=en

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Potrebne knjižnice so v datoteki `lib/libraries.r`
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).
