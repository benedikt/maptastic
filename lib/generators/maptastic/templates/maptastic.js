var Maptastic = {};

Object.extend(Maptastic, {
	
	setup: function() {
		$$("div[data-map=true]").each(function(element) {	new Maptastic.Map(element); });
	},
	
	toLatLng: function(string) {
		var coordinates = string.split(" ");
	  return new GLatLng(coordinates[0], coordinates[1]);
	}
	
});

Maptastic.Map = Class.create({
	
	initialize: function(element) {
		this.element = $(element);
		this.collectMarkers();
		
		this.map = new GMap2(this.element);
		this.setupMap();
	},
	
	setupMap: function() { 
		with(this) {
			setupCenter();
			setupZoom();
			setupControls();
			setupMarkers();
		}
	},
	
	collectMarkers: function() {
		this.markers = this.element.select("div[data-map-marker=true]");
	},
	
	setupCenter: function() {
		with(this) {
			if(element.hasAttribute("data-map-center")) {
				this.map.setCenter(Maptastic.toLatLng(element.readAttribute("data-map-center")));
			}
		}
	},
	
	setupZoom: function() {
		with(this) {
			if(element.hasAttribute("data-map-zoom")) {
				this.map.setZoom(parseInt(element.readAttribute("data-map-zoom")));
			} 
		}
	},
	
	setupControls: function() {
		with(this) {
			if(element.hasAttribute("data-map-controls")) {
				map.setUIToDefault();
			}
			
			if(element.readAttribute("data-map-controls-dragging") == "false") {
				map.disableDragging();
			}
			
			if(element.readAttribute("data-map-controls-dragging") == "false") {
				map.disableDoubleClickZoom();
				map.disableContinuousZoom();
				map.disableScrollWheelZoom();
			}
		}
	},
	
	setupMarkers: function() {
		this.markers.each(function(element) {
			var marker = new GMarker(Maptastic.toLatLng(element.readAttribute("data-map-position")));
			if(!element.empty()) marker.bindInfoWindow(element);
			this.map.addOverlay(marker);
		}.bind(this));
	}
	
});


document.observe("dom:loaded", function() { Maptastic.setup(); });