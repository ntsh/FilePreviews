import Foundation
import QuickLook


public class Thumbnailer: ObservableObject {
    @MainActor @Published var thumbnail: CGImage?
    @MainActor @Published var imageLabel = "Thumbnail" // Potentially generate this based on image content

    public func generateThumbnail(_ url: URL, size: CGSize = CGSize(width: 400, height: 400)) {
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: (UIScreen.main.scale), representationTypes: .all)
        let generator = QLThumbnailGenerator.shared

        Task {
            let representation = try? await generator.generateBestRepresentation(for: request)
            await MainActor.run {
                thumbnail = representation?.cgImage
            }
        }
    }
}
