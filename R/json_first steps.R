library(rjson)

list_1 = vector(mode="list", length = 2)

# assigning different objects to the list
list_1[[1]] = c("Rick","Dan","Michelle","Ryan")
list_1[[2]] = c("623.3","843.25","578","722.5")


myfile = toJSON(list_1)

write(myfile, "C:/Users/joachim.topper/OneDrive - NINA/work/myJSON.json")






toJSON(list(
  output_rapporter_egenskapvurderinger,
  output_rapporter_egenskapvurderinger)
)


xxx <- read.csv("C:/Users/joachim.topper/OneDrive - NINA/work/R projects/github/IBECA/output/for Mdirs infrastruktur/input_code.csv", encoding =  "Latin-1")



json1 <- 
  '
  {
    "input": {
      "kode": [
        {
          "navn": "Steg 1 - ANO-data handling",
          "link": "1 ANO_data handling.R"
        },
        {
          "navn": "GitHub repo Darwin Core",
          "link": "https://github.com/tdwg/dwc"
        }
      ],
      "datasett": [
        {
          "navn": "Artsdata",
          "link": "ArtsData.txt",
          "kilde": "ANO",
          "periodeStart": "2019-01-01 00:00:00",
          "periodeSlutt": "2020-12-31 00:00:00",
          "type": "Rådata"
        },
        {
          "navn": "Seapop data",
          "link": "https://github.com/LivingNorway/LivingNorwayData/blob/master/data/Seapop.rda",
          "kilde": "ANO",
          "periodeStart": "2019-01-01 00:00:00",
          "periodeSlutt": "2020-12-31 00:00:00",
          "type": "Rådata"
        }
      ]
    },
    "output": {
      "indikatorVurderinger": [
        {
          "indikatorReferanseUid": "ndvi-nedre",
          "nedreKonfidensIntervalGrense": 0.882203318,
          "tilstandsverdi": 0.88318022,
          "ovreKonfidensIntervalGrense": 0.884195685,
          "periodeStart": "2016-01-01 00:00:00",
          "periodeSlutt": "2020-12-31 23:59:00",
          "geografiskOmradeReferanseUid": "hele-norge-2020"
        }
      ],
      "rapporter": [
        {
          "link": "https://brage.nina.no/nina-xmlui/handle/11250/2739886",
          "navn": "Tilstand skog for hele Norge",
          "beskrivelse": "Økologisk tilstand i skog for hele Norge",
          "tilstandsverdi": 0.421766554,
          "nedreKonfidensIntervalGrense": 0.412341227,
          "ovreKonfidensIntervalGrense": 0.430873023,
          "dato": "2021-04-27 00:00:00.0000000",
          "geografiskOmradeReferanseUid": "hele-norge-2020",
          "okosystemReferanseUid": "skog",
          "egenskapVurderinger": [
            {
              "egenskapReferanseUid": "primaerproduksjon",
              "benyttetIndikatorVurderinger": [
                {
                  "indikatorReferanseUid": "ndvi-nedre",
                  "periodeStart": "2016-01-01 00:00:00",
                  "periodeSlutt": "2020-12-31 23:59:00",
                  "geografiskOmradeReferanseUid": "hele-norge-2020",
                  "vekting": 1
                }
              ],
              "aggregertTilstandsverdi": 0.699858067064885,
              "nedreKonfidensIntervalGrense": 0.692996333236414,
              "ovreKonfidensIntervalGrense": 0.707048753794416
            }
          ]
        }
      ]
    }
  }
'

xxx <- fromJSON(json1)

str(xxx)


json.list <- list(
  input=list(
    code=list(
      list(navn='Snødekkets varighet',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Ellenberg N',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Vinterregn',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Vegetasjonenes varmekrav',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Areal av isbreer',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Snødybde',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='NDVI',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Ellenberg L',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Fjellrype',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Smågnagere',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Lirype',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Fjellrev',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Kongeørn',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Jerv',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Naturindeks for fjell',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Rein',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Fravær av fremmede arter',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Konnektivitet',
           link='https://ninanor.github.io/IBECA/fjell.html'),
      list(navn='Areal uten tekniske inngrep',
           link='https://ninanor.github.io/IBECA/fjell.html')
      ),
    datasett=list(
      list(navn='mediansnowCover',
           link='mediansnowCover.xlsx',
           kilde='met.no',
           periodestart='1960',
           periodeslutt='2020',
           type='Modellerte klimadata'),
      list(navn='ANO data',
           link='https://kartkatalog.miljodirektoratet.no/Dataset/Details/2054',
           kilde='ANO, Miljødirektoratet',
           periodestart='2019',
           periodeslutt='2021',
           type='Rådata'),
      list(navn='Ellenberg indicator values for British plants',
           link='https://nora.nerc.ac.uk/id/eprint/6411/',
           kilde='Hill et al. 1999',
           periodestart='',
           periodeslutt='',
           type='Ekspertgenererte data'),
      list(navn='Generaliserte artslistedata NiN',
           link='',
           kilde='NiN 2.0',
           periodestart='',
           periodeslutt='',
           type='Ekspertgenererte data'),
      list(navn='winterRain_med',
           link='winterRain_med.xlsx',
           kilde='met.no',
           periodestart='1960',
           periodeslutt='2020',
           type='Modellerte klimadata'),
      list(navn='Swedish Plant indicator data',
           link='https://www.sciencedirect.com/science/article/pii/S1470160X20308621?via%3Dihub',
           kilde='Tyler et al. 2021',
           periodestart='',
           periodeslutt='',
           type='Ekspertgenererte data'),
      list(navn='Breatlas 2018/2019',
           link='https://www.nve.no/vann-og-vassdrag/vannets-kretsloep/bre/publikasjoner-publications/breatlas-glacier-inventories/',
           kilde='NVE, Sentinel-2',
           periodestart='2018',
           periodeslutt='2019',
           type='Fjernmålte data'),
      list(navn='snowDepth_med',
           link='snowDepth_med.xls',
           kilde='met.no',
           periodestart='1960',
           periodeslutt='2020',
           type='Modellerte klimadata'),
      list(navn='NDVI',
           link='https://lpdaac.usgs.gov/products/mod13q1v006/',
           kilde='MODIS',
           periodestart='2000',
           periodeslutt='2019',
           type='Fjernmålte data'),
      list(navn='fjellrype',
           link='miljodirektoratet.no',
           kilde='TOV-E',
           periodestart='2010',
           periodeslutt='2020',
           type='Rådata'),
      list(navn='smågnagere',
           link='https://www.naturindeks.no/',
           kilde='Naturindeks, TOV',
           periodestart='1990',
           periodeslutt='2019',
           type='Rådata'),
      list(navn='lirype',
           link='https://honsefugl.nina.no/Innsyn/nb',
           kilde='Hønsefuglportalen',
           periodestart='2010',
           periodeslutt='2020',
           type='Rådata'),
      list(navn='fjellrev',
           link='https://www.rovbase.no/',
           kilde='Overvåkingsprogram for fjellrev',
           periodestart='1950',
           periodeslutt='2019',
           type='Rådata'),
      list(navn='kongeørn',
           link='https://rovdata.no/',
           kilde='Rovdata',
           periodestart='2015',
           periodeslutt='2019',
           type='Rådata'),
      list(navn='jerv',
           link='https://rovdata.no/',
           kilde='Rovdata',
           periodestart='1990',
           periodeslutt='2019',
           type='Rådata'),
      list(navn='Naturindeks for fjell',
           link='https://www.naturindeks.no/',
           kilde='Naturindeks',
           periodestart='1988',
           periodeslutt='2019',
           type='Prosesserte data'),
      list(navn='rein',
           link='https://www.reinbase.no/',
           kilde='Reinbase, Kjørstad mfl. (2017)',
           periodestart='2015',
           periodeslutt='2020',
           type='Rådata'),
      list(navn='N50 kartdata',
           link='https://kartkatalog.geonorge.no/metadata/ea192681-d039-42ec-b1bc-f3ce04c189ac',
           kilde='Kartverket',
           periodestart='',
           periodeslutt='',
           type='Kartdata'),
      list(navn='Inngrepsfri natur',
           link='https://kartkatalog.geonorge.no/metadata/inngrepsfri-natur-i-norge/277bda73-b924-4a0e-b299-ea5441de2d3b',
           kilde='Miljødirektoratet',
           periodestart='1988',
           periodeslutt='2018',
           type='Kartdata')
      )
    ),
  output=list(indikatorvurderinger=list(
    list(indikatorReferanseUid='',
         nedreKonfidensIntervalGrense='',
         tilstandsverdi='',
         ovreKonfidensIntervalGrense='',
         periodeStart='',
         periodeSlutt='',
         geografiskOmradeReferanseUid='hele-norge-2020')
  ),
  rapporter=list(
    list(link='',
         navn='',
         beskrivelse='',
         tilstandsverdi=,
         nedreKonfidensIntervalGrense=,
         ovreKonfidensIntervalGrense=,
         dato='',
         geografiskOmradeReferanseUid='hele-norge-2020',
         okosystemReferanseUid='fjell',
         egenskapVurderinger=list(
           
           list(egenskapReferanseUid='primaerproduksjon',
                benyttetIndikatorVurderinger=list(
                  list(indikatorReferanseUid='aaa',
                       periodeStart='',
                       periodeSlutt='',
                       geografiskOmradeReferanseUid='hele-norge-2020',
                       vekting=1)),
                aggregertTilstandsverdi=,
                nedreKonfidensIntervalGrense=,
                ovreKonfidensIntervalGrense=)
           ,
           list(egenskapReferanseUid='biomasse',
                benyttetIndikatorVurderinger=list(
                  list(indikatorReferanseUid='aaa',
                       periodeStart='',
                       periodeSlutt='',
                       geografiskOmradeReferanseUid='hele-norge-2020',
                       vekting=1)),
                aggregertTilstandsverdi=,
                nedreKonfidensIntervalGrense=,
                ovreKonfidensIntervalGrense=)
           
           ))
    )
  )
  )
