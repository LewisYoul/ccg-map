<template>
  <div id='map'>
    <MapOverlayContainer @unselectCcg="unselectCcg" :ccgs="ccgs"/>
  </div>
</template>

<script>
import mapboxgl from 'mapbox-gl';
import MapOverlayContainer from './MapOverlayContainer.vue'

export default {
  name: 'Map',

  components: { MapOverlayContainer },

  data() {
    return {
      map: undefined,
      hoveredStateId: undefined,
      sourceLayer: 'ccgs',
      ccgs: []
    }
  },

  methods: {
    unselectCcg(id) {
      this.ccgs = this.ccgs.filter(ccg => ccg.id !== id);
      this.setFeatureState(id, { clicked: false })
    },

    setFeatureState(id, state) {
      this.map.setFeatureState(
        { source: 'ccgs', sourceLayer: this.sourceLayer, id: id },
        state
      );
    },

    ccgIdsInclude(ccgId) {
      return this.ccgs.filter(ccg => ccgId == ccg.id).length > 0;
    },

    ccgIdsExclude(ccgId) {
      return !this.ccgIdsInclude(ccgId);
    },
  },

  created() {
    window.addEventListener('DOMContentLoaded', () => {
    mapboxgl.accessToken = 'pk.eyJ1IjoibGV3aXN5b3VsIiwiYSI6ImNqYzM3a3lndjBhOXQyd24zZnVleGh3c2kifQ.qVH2-BA02t3p62tG72-DZA';

    this.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v10',
      center: [0.12, 52.00],
      zoom: 6,
    });

    let self = this

    this.map.on('load', function() {
        self.map.addSource('ccgs', {
          'type': 'vector',
          'url': 'mapbox://lewisyoul.2r8pdl3o',
          'generateId': true
        });

        self.map.addLayer({
          'id': 'fill',
          'type': 'fill',
          'source': 'ccgs',
          'source-layer': self.sourceLayer,
          'paint': {
            'fill-color': [
                'case',
                ['boolean', ['feature-state', 'clicked'], false], 'pink',
                [ '==', ['get', 'cycles'], "0"], "lightgrey",
                [ '==', ['get', 'cycles'], "1"], "lightblue",
                [ '==', ['get', 'cycles'], "2"], "cadetblue",
                [ '==', ['get', 'cycles'], "3"], "steelblue",
                'aliceblue'
            ],
            'fill-opacity': [
              'case',
              ['boolean', ['feature-state', 'hover'], false],
              0.9,
              0.5
            ]
          },
        });

        self.map.addLayer({
          'id': 'line',
          'type': 'line',
          'source': 'ccgs',
          'source-layer': self.sourceLayer,
          'paint': {
            'line-color': 'grey',
            'line-width': 1
          },
          'filter': ['==', '$type', 'Polygon']
        });

        let popup = new mapboxgl.Popup({
          closeButton: false,
          closeOnClick: false
        });

        self.map.on('mousemove', 'fill', function(e) {
          const ccgName = self.map.queryRenderedFeatures(e.point)[0].properties.ccg18nm

          popup
            .setLngLat(e.lngLat)
            .setHTML(ccgName)
            .addTo(self.map);

          self.map.getCanvas().style.cursor = 'pointer';
          if (e.features.length > 0) {
            if (self.hoveredStateId) {
              self.setFeatureState(self.hoveredStateId, { hover: false })
            }
            self.hoveredStateId = e.features[0].id;
            self.setFeatureState(self.hoveredStateId, { hover: true })
          }
        });

          self.map.on('click', 'fill', (e) => {
            const ccg = Object.assign({}, e.features[0].properties, { id: e.features[0].id });

            if (self.ccgIdsExclude(ccg.id) && self.ccgs.length < 3) {

              self.ccgs.push(ccg);

              self.setFeatureState(ccg.id, { clicked: true })
            } else {
              self.ccgs = self.ccgs.filter(el => ccg.id !== el.id);

              self.setFeatureState(ccg.id, { clicked: false })
            }
          })

          self.map.on('mouseleave', 'fill', () => {
            self.map.getCanvas().style.cursor = '';
            self.setFeatureState(self.hoveredStateId, { hover: false })
            popup.remove()
          })
        })
    });
  }
}
</script>

<style>
  #map {
    position: absolute;
    top: 80px;
    bottom:0;
    left: 0;
    right: 0;
    width: 100%;
    z-index: 1;
  }

  .mapboxgl-popup {
    max-width: 400px;
    font: 12px/20px 'Helvetica Neue', Arial, Helvetica, sans-serif;
  }
</style>
