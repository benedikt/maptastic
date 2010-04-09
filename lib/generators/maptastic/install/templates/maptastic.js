document.observe("dom:loaded", function() {
	$$("div[data-map=true]").each(function(element) {
		var map = new GMap2(element);
		
		if(element.hasAttribute("data-map-center") && element.hasAttribute("data-map-zoom")) {
			var zoom = parseInt(element.readAttribute("data-map-zoom"));
			var center = element.readAttribute("data-map-center").split(";");
			map.setCenter(new GLatLng(center[0], center[1]), zoom);
		}
		
		if(element.hasAttribute("data-map-controls")) {
			map.setUIToDefault();
		}
	});
});