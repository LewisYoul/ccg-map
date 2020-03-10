r = Typhoeus.get('https://ons-inspire.esriuk.com/arcgis/rest/services/Health_Boundaries/Clinical_Commissioning_Groups_April_2018_Boundaries/MapServer/1/query?where=1%3D1&outFields=objectid,ccg18cd,ccg18nm,shape&outSR=4326&f=json')
r = JSON.parse(r.body)
