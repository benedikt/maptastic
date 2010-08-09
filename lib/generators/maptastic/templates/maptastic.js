var Maptastic = {};

Object.extend(Maptastic, {

  setup: function() {
    $$("div[data-map=true]").each(function(element) {  new Maptastic.Map(element); });
  },

  toLatLng: function(string) {
    var coordinates = string.split(" ");
    return new google.maps.LatLng(coordinates[0], coordinates[1]);
  }

});

Maptastic.Map = Class.create({

  initialize: function(element) {
    this.element = $(element);
    this.collectMarkers();

    this.mapOptions = {
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    this.setupMap();

    this.map = new google.maps.Map(this.element, this.mapOptions);

    this.setupMarkers();
  },

  setupMap: function() {
    with(this) {
			setupCenter();
      setupZoom();
      setupControls();
    }
  },

  collectMarkers: function() {
    this.markers = this.element.select("div[data-map-marker=true]");
  },

  setupCenter: function() {
    with(this) {
      mapOptions['center'] = Maptastic.toLatLng(element.readAttribute("data-map-center"));
    }
  },

  setupZoom: function() {
    with(this) {
      if(element.hasAttribute("data-map-zoom")) {
        mapOptions['zoom'] = parseInt(element.readAttribute("data-map-zoom"));
      }
    }
  },

  setupControls: function() {
    with(this) {
      mapOptions['disableDefaultUI'] = !element.hasAttribute("data-map-controls")

      if(element.readAttribute("data-map-controls-dragging") == "false") {
        mapOptions['draggable'] = false;
      }

      if(element.readAttribute("data-map-controls-zooming") == "false") {
        mapOptions['scrollwheel'] = false;
        mapOptions['disableDoubleClickZoom'] = false;
      }
    }
  },

  setupMarkers: function() {
    this.markers.each(function(element) {

      var marker = new google.maps.Marker({
        position: Maptastic.toLatLng(element.readAttribute("data-map-position")),
        map: this.map,
        title: "Hello World!"
      });

      if(!element.empty()) {
        var infoWindow = new google.maps.InfoWindow({
          content: element.innerHTML
        });

        google.maps.event.addListener(marker, 'click', function() {
          infoWindow.open(this.map, marker);
        }.bind(this));
      }

    }.bind(this));
  }

});

document.observe("dom:loaded", function() { Maptastic.setup(); });
