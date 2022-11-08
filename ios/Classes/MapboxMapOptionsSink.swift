
import MapboxMaps

protocol MapboxMapOptionsSink {
    func setCameraTargetBounds(bounds: CoordinateBounds?)
    func setCompassEnabled(compassEnabled: Bool)
    func setStyleString(styleString: String)
    func setMinMaxZoomPreference(min: Double, max: Double)
    func setRotateGesturesEnabled(rotateGesturesEnabled: Bool)
    func setScrollGesturesEnabled(scrollGesturesEnabled: Bool)
    func setTiltGesturesEnabled(tiltGesturesEnabled: Bool)
    func setTrackCameraPosition(trackCameraPosition: Bool)
    func setZoomGesturesEnabled(zoomGesturesEnabled: Bool)
    func setMyLocationEnabled(myLocationEnabled: Bool)
    func setMyLocationTrackingMode(myLocationTrackingMode: UserTrackingMode)
    func setMyLocationRenderMode(myLocationRenderMode: MyLocationRenderMode)
    func setLogoViewMargins(x: Double, y: Double)
    func setCompassViewPosition(position: OrnamentPosition)
    func setCompassViewMargins(x: Double, y: Double)
    func setAttributionButtonMargins(x: Double, y: Double)
    func setAttributionButtonPosition(position: OrnamentPosition)
}
