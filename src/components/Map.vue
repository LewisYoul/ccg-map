<template>
  <div id='map'>
  <transition name="slide">
    <MapOverlay
      @closed="unselectCcg"
      v-if="computedCcg"
      :ccg="computedCcg"
    />
  </transition>
  </div>
</template>

<script>
import mapboxgl from 'mapbox-gl';
import MapOverlay from './MapOverlay.vue'

export default {
  name: 'Map',

  components: { MapOverlay },

  data() {
    return {
      map: undefined,
      selectedCcg: undefined,
      hoveredStateId: undefined,
      clickedStateId: undefined,
      sourceLayer: 'ccgs',
    }
  },

  computed: {
    computedCcg: function() {
      console.log(this.selectedCcg)
      return this.selectedCcg;
    }
  },

  methods: {
    unselectCcg() {
      this.map.setFeatureState(
        { source: 'ccgs', sourceLayer: this.sourceLayer, id: this.clickedStateId },
        { clicked: false }
      );

      this.selectedCcg = undefined;
      this.clickedStateId = undefined;
    }
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

        // console.log(map.getStyle().sources)

        self.map.addLayer({
          'id': 'fill',
          'type': 'fill',
          'source': 'ccgs',
          'source-layer': self.sourceLayer,
          'paint': {
            'fill-color': [
                'case',
                ['boolean',['feature-state', 'clicked'], false],
                'pink', // if selected true, paint in blue
                '#64bdbb' // else paint in gray
            ],
            'fill-opacity': [
              'case',
              ['boolean', ['feature-state', 'hover'], false],
              1,
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

        self.map.on('mousemove', 'fill', function(e) {
          self.map.getCanvas().style.cursor = 'pointer';
          if (e.features.length > 0) {
            if (self.hoveredStateId) {
              self.map.setFeatureState(
                { source: 'ccgs', sourceLayer: self.sourceLayer, id: self.hoveredStateId },
                { hover: false }
              );
            }
            self.hoveredStateId = e.features[0].id;
            self.map.setFeatureState(
              { source: 'ccgs', sourceLayer: self.sourceLayer, id: self.hoveredStateId },
              { hover: true }
            );
          }
        });

          self.map.on('click', 'fill', (e) => {
            if (self.clickedStateId) {
              self.map.setFeatureState(
                { source: 'ccgs', sourceLayer: self.sourceLayer, id: self.clickedStateId },
                { clicked: false }
              );
            }

            const ccg = e.features[0].properties;

            if (!(self.clickedStateId == e.features[0].id)) {
              self.clickedStateId = e.features[0].id;

              self.selectedCcg = ccg;

              self.map.setFeatureState(
                { source: 'ccgs', sourceLayer: self.sourceLayer, id: self.clickedStateId },
                { clicked: true }
              );
            } else {
              self.selectedCcg = undefined;
              self.clickedStateId = undefined;
            }
          })

          self.map.on('mouseleave', 'fill', () => {
            self.map.setFeatureState(
              { source: 'ccgs', sourceLayer: self.sourceLayer, id: self.hoveredStateId },
              { hover: false }
            );
          })
        })
    });
  }
}
</script>

<style>
  /* .map-container {
    height: 100vh;
    width: 100vw;
  } */

  #map {
    position:absolute;
    top:0; bottom:0; left: 0; right: 0; width:100%; height: 100%;
    width: 100%;
    height: 100%;
  }

  .mapboxgl-popup {
    max-width: 400px;
    font: 12px/20px 'Helvetica Neue', Arial, Helvetica, sans-serif;
  }
</style>
