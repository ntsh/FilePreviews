# FilePreviews

SwiftUI file preview and thumbnail generator library 

Uses Apple's QuickLook framework to generate thumbnails and previews for local files.


## Installation

Swift Package Manager:

```
dependencies: [
    .package(url: "https://github.com/ntsh/FilePreviews.git", .upToNextMajor(from: "0.1"))
]
```

## Usage

#### Preview file in full screen: 

```
import FilePreviews

// Then somewhere in your swiftUI view
.fullScreenCover(isPresented: $showPreview) {
    PreviewController(url: fileURL, isPresented: $showPreview)
}
```

#### Create file Thumbnail:

See ThumbnailView.swift for an example:

```
public struct ThumbnailView: View {
    public let url: URL

    @StateObject var thumbnailer = Thumbnailer()

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        Group {
            if let thumbnail = thumbnailer.thumbnail {
                Image(thumbnail, scale: (UIScreen.main.scale), label: Text(thumbnailer.imageLabel))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "photo.fill")
                    .onAppear {
                        thumbnailer.generateThumbnail(url)
                    }
            }
        }
    }
}
