import Foundation
import SwiftUI

@MainActor
class Screen {
    static var scale: CGFloat {
#if os(iOS)
        let scale = UIScreen.main.scale
#elseif os(macOS)
        let scale = NSScreen.main!.backingScaleFactor
#endif
        return scale
    }
}
