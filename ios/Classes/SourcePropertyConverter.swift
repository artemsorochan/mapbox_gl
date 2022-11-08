import Foundation
import MapboxMaps

class SourcePropertyConverter {
    class func interpretTileOptions(properties: [String: Any]) -> [TileSourceOption: Any] {
        var options = [TileSourceOption: Any]()

        if let bounds = properties["bounds"] as? [Double] {
            options[.coordinateBounds] =
                NSValue(mglCoordinateBounds: boundsFromArray(coordinates: bounds))
        }
        if let minzoom = properties["minzoom"] as? Double {
            options[.minimumZoomLevel] = minzoom
        }
        if let maxzoom = properties["maxzoom"] as? Double {
            options[.maximumZoomLevel] = maxzoom
        }
        if let tileSize = properties["tileSize"] as? Double {
            options[.tileSize] = Int(tileSize)
        }
        if let scheme = properties["scheme"] as? String {
            let system: TileCoordinateSystem = (scheme == "tms" ? .TMS : .XYZ)
            options[.tileCoordinateSystem] = system.rawValue
        }
        return options
        // TODO: attribution not implemneted for IOS
    }

    class func buildRasterTileSource(identifier: String,
                                     properties: [String: Any]) -> RasterTileSource?
    {
        if let rawUrl = properties["url"] as? String, let url = URL(string: rawUrl) {
            return RasterTileSource(identifier: identifier, configurationURL: url)
        }
        if let tiles = properties["tiles"] as? [String] {
            let options = interpretTileOptions(properties: properties)
            return RasterTileSource(
                identifier: identifier,
                tileURLTemplates: tiles,
                options: options
            )
        }
        return nil
    }

    class func buildVectorTileSource(identifier: String,
                                     properties: [String: Any]) -> VectorTileSource?
    {
        if let rawUrl = properties["url"] as? String, let url = URL(string: rawUrl) {
            return VectorTileSource(identifier: identifier, configurationURL: url)
        }
        if let tiles = properties["tiles"] as? [String] {
            return VectorTileSource(
                identifier: identifier,
                tileURLTemplates: tiles,
                options: interpretTileOptions(properties: properties)
            )
        }
        return nil
    }

    class func buildRasterDemSource(identifier: String,
                                    properties: [String: Any]) -> RasterDEMSource?
    {
        if let rawUrl = properties["url"] as? String, let url = URL(string: rawUrl) {
            return RasterDEMSource(identifier: identifier, configurationURL: url)
        }
        if let tiles = properties["tiles"] as? [String] {
            return RasterDEMSource(
                identifier: identifier,
                tileURLTemplates: tiles,
                options: interpretTileOptions(properties: properties)
            )
        }
        return nil
    }

    class func interpretShapeOptions(properties: [String: Any]) -> [ShapeSourceOption: Any] {
        var options = [ShapeSourceOption: Any]()

        if let maxzoom = properties["maxzoom"] as? Double {
            options[.maximumZoomLevel] = maxzoom
        }

        if let buffer = properties["buffer"] as? Double {
            options[.buffer] = buffer
        }
        if let tolerance = properties["tolerance"] as? Double {
            options[.simplificationTolerance] = tolerance
        }

        if let cluster = properties["cluster"] as? Bool {
            options[.clustered] = cluster
        }
        if let clusterRadius = properties["clusterRadius"] as? Double {
            options[.clusterRadius] = clusterRadius
        }
        if let clusterMaxZoom = properties["clusterMaxZoom"] as? Double {
            options[.maximumZoomLevelForClustering] = clusterMaxZoom
        }

        // TODO: clusterProperties not implemneted for IOS

        if let lineMetrics = properties["lineMetrics"] as? Bool {
            options[.lineDistanceMetrics] = lineMetrics
        }
        return options
    }

    class func buildShapeSource(identifier: String, properties: [String: Any]) -> ShapeSource? {
        let options = interpretShapeOptions(properties: properties)
        if let data = properties["data"] as? String, let url = URL(string: data) {
            return ShapeSource(identifier: identifier, url: url, options: options)
        }
        if let data = properties["data"] {
            do {
                let geoJsonData = try JSONSerialization.data(withJSONObject: data)
                let shape = try Shape(data: geoJsonData, encoding: String.Encoding.utf8.rawValue)
                return ShapeSource(identifier: identifier, shape: shape, options: options)
            } catch {}
        }
        return nil
    }

    class func buildImageSource(identifier: String, properties: [String: Any]) -> ImageSource? {
        if let rawUrl = properties["url"] as? String, let url = URL(string: rawUrl),
           let coordinates = properties["coordinates"] as? [[Double]]
        {
            return ImageSource(
                identifier: identifier,
                coordinateQuad: quadFromArray(coordinates: coordinates),
                url: url
            )
        }
        return nil
    }

    class func addShapeProperties(properties: [String: Any], source: ShapeSource) {
        do {
            if let data = properties["data"] as? String {
                let parsed = try Shape(
                    data: data.data(using: .utf8)!,
                    encoding: String.Encoding.utf8.rawValue
                )
                source.shape = parsed
            }
        } catch {}
    }

    class func quadFromArray(coordinates: [[Double]]) -> CoordinateQuad {
        return CoordinateQuad(
            topLeft: CLLocationCoordinate2D(
                latitude: coordinates[0][1],
                longitude: coordinates[0][0]
            ),
            bottomLeft: CLLocationCoordinate2D(
                latitude: coordinates[3][1],
                longitude: coordinates[3][0]
            ),
            bottomRight: CLLocationCoordinate2D(
                latitude: coordinates[2][1],
                longitude: coordinates[2][0]
            ),
            topRight: CLLocationCoordinate2D(
                latitude: coordinates[1][1],
                longitude: coordinates[1][0]
            )
        )
    }

    class func boundsFromArray(coordinates: [Double]) -> CoordinateBounds {
        return CoordinateBounds(
            sw: CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]),
            ne: CLLocationCoordinate2D(latitude: coordinates[3], longitude: coordinates[2])
        )
    }
}
