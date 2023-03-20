import Foundation
import QuickLookThumbnailing

public class Thumbnailer {
    public init() {}

    public func generateThumbnail(_ url: URL, size: CGSize = CGSize(width: 400, height: 400)) async -> CGImage? {
        let scale = await Screen.scale
        let request = QLThumbnailGenerator.Request(
            fileAt: url,
            size: size,
            scale: scale,
            representationTypes: .all)
        let representation = try? await QLThumbnailGenerator.shared.generateBestRepresentation(for: request)
        return representation?.cgImage
    }
}

extension Thumbnailer: ObservableObject {}
