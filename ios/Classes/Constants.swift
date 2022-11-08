import MapboxMaps

/*
 * The mapping is based on the values defined here:
 *  https://docs.mapbox.com/android/api/map-sdk/8.4.0/constant-values.html
 */

class Constants {
    static let symbolIconAnchorMapping = [
        "center": IconAnchor.center,
        "left": IconAnchor.left,
        "right": IconAnchor.right,
        "top": IconAnchor.top,
        "bottom": IconAnchor.bottom,
        "top-left": IconAnchor.topLeft,
        "top-right": IconAnchor.topRight,
        "bottom-left": IconAnchor.bottomLeft,
        "bottom-right": IconAnchor.bottomRight,
    ]

    static let symbolTextJustificationMapping = [
        "auto": TextJustification.auto,
        "center": TextJustification.center,
        "left": TextJustification.left,
        "right": TextJustification.right,
    ]

    static let symbolTextAnchorMapping = [
        "center": TextAnchor.center,
        "left": TextAnchor.left,
        "right": TextAnchor.right,
        "top": TextAnchor.top,
        "bottom": TextAnchor.bottom,
        "top-left": TextAnchor.topLeft,
        "top-right": TextAnchor.topRight,
        "bottom-left": TextAnchor.bottomLeft,
        "bottom-right": TextAnchor.bottomRight,
    ]

    static let symbolTextTransformationMapping = [
        "none": TextTransform.none,
        "lowercase": TextTransform.lowercase,
        "uppercase": TextTransform.uppercase,
    ]

    static let lineJoinMapping = [
        "bevel": LineJoin.bevel,
        "miter": LineJoin.miter,
        "round": LineJoin.round,
    ]
}
