import SwiftUI

public struct ThumbnailView: View {
    public let url: URL

    @EnvironmentObject var thumbnailGenerator: Thumbnailer
    @State var image: CGImage?

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        Group {
            if let image {
                Image(image, scale: Screen.scale, label: Text(""))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "photo.fill")
                    .task {
                        image = await thumbnailGenerator.generateThumbnail(url)
                    }
            }
        }
    }
}

struct ThumbnailView_Preview: PreviewProvider {
    static var previews: some View {
        ThumbnailView(url: URL(fileURLWithPath: ""))
            .environmentObject(Thumbnailer())
    }
}
