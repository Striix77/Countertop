import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// The typefaces bundled with the app. One entry per `.ttf` in `Fonts/`
/// registered in `Info.plist` under `UIAppFonts`.
///
/// This is the only place font names are spelled out — `Organic.Font` builds on
/// it, and call sites should use the token scale there (`Font.h2`, `Font.bodyM`)
/// rather than reaching for a face directly.
public extension Organic {

    /// Raw value is the PostScript name, which for these files also matches the
    /// file name. Verified against the `name` table — see `verifyBundledFaces()`.
    enum Typeface: String, CaseIterable {

        // Display.
        case caprasimo = "Caprasimo-Regular"

        // Body — Figtree, upright.
        case figtreeLight     = "Figtree-Light"
        case figtreeRegular   = "Figtree-Regular"
        case figtreeMedium    = "Figtree-Medium"
        case figtreeSemiBold  = "Figtree-SemiBold"
        case figtreeBold      = "Figtree-Bold"
        case figtreeExtraBold = "Figtree-ExtraBold"
        case figtreeBlack     = "Figtree-Black"

        // Body — Figtree, italic.
        case figtreeLightItalic     = "Figtree-LightItalic"
        case figtreeItalic          = "Figtree-Italic"
        case figtreeMediumItalic    = "Figtree-MediumItalic"
        case figtreeSemiBoldItalic  = "Figtree-SemiBoldItalic"
        case figtreeBoldItalic      = "Figtree-BoldItalic"
        case figtreeExtraBoldItalic = "Figtree-ExtraBoldItalic"
        case figtreeBlackItalic     = "Figtree-BlackItalic"

        /// PostScript name, as passed to `Font.custom` / `UIFont(name:size:)`.
        public var postScriptName: String { rawValue }

        /// Resource name in the bundle, as listed in `Info.plist`.
        public var fileName: String { "\(rawValue).ttf" }

        public func font(_ size: CGFloat) -> SwiftUI.Font {
            .custom(rawValue, size: size)
        }

        /// The Figtree face closest to `weight`. Caprasimo ships one weight, so
        /// display type never goes through here.
        public static func figtree(_ weight: SwiftUI.Font.Weight, italic: Bool = false) -> Typeface {
            switch (weight, italic) {
            case (.ultraLight, false), (.thin, false), (.light, false): return .figtreeLight
            case (.ultraLight, true),  (.thin, true),  (.light, true):  return .figtreeLightItalic
            case (.medium, false):     return .figtreeMedium
            case (.medium, true):      return .figtreeMediumItalic
            case (.semibold, false):   return .figtreeSemiBold
            case (.semibold, true):    return .figtreeSemiBoldItalic
            case (.bold, false):       return .figtreeBold
            case (.bold, true):        return .figtreeBoldItalic
            case (.heavy, false):      return .figtreeExtraBold
            case (.heavy, true):       return .figtreeExtraBoldItalic
            case (.black, false):      return .figtreeBlack
            case (.black, true):       return .figtreeBlackItalic
            default:                   return italic ? .figtreeItalic : .figtreeRegular
            }
        }
    }
}

// MARK: - Convenience

public extension Font {
    /// `Text("hi").font(.organic(.figtreeSemiBold, 15))`
    static func organic(_ face: Organic.Typeface, _ size: CGFloat) -> Font {
        face.font(size)
    }

    /// Figtree at an arbitrary weight, for the cases the token scale doesn't cover.
    static func figtree(_ size: CGFloat, weight: Font.Weight = .regular, italic: Bool = false) -> Font {
        Organic.Typeface.figtree(weight, italic: italic).font(size)
    }
}

// MARK: - Diagnostics

#if canImport(UIKit)
public extension Organic.Typeface {

    /// Whether the face actually resolved. A `false` here means the `.ttf` is
    /// missing from the target or absent from `UIAppFonts` — text silently
    /// falls back to the system face otherwise.
    var isAvailable: Bool { UIFont(name: rawValue, size: 12) != nil }

    /// Faces that failed to register. Call once at launch in DEBUG.
    static var missing: [Organic.Typeface] { allCases.filter { !$0.isAvailable } }

    /// Traps in DEBUG if a bundled face didn't register, so a missing font
    /// shows up as a crash at launch rather than as system-font text on screen.
    static func verifyBundledFaces(file: StaticString = #fileID, line: UInt = #line) {
        let missing = Self.missing
        assert(
            missing.isEmpty,
            "Unregistered fonts: \(missing.map(\.fileName).joined(separator: ", ")). "
            + "Check target membership and the UIAppFonts array in Info.plist.",
            file: file,
            line: line
        )
    }
}
#endif
