import SwiftUI

/// Organic design system — tokens ported from styles.css (source of truth).
/// Keep this file in sync with the CSS token block; do not hard-code values elsewhere.
public enum Organic {

    // MARK: - Color

    public enum Color {
        public static let bg      = SwiftUI.Color(hex: 0xF5EAD8)
        public static let surface = SwiftUI.Color(hex: 0xEBDDC5)
        public static let text    = SwiftUI.Color(hex: 0x201E1D)
        public static let accent  = SwiftUI.Color(hex: 0xC67139)
        public static let accent2 = SwiftUI.Color(hex: 0x7A8A5E)
        public static let divider = SwiftUI.Color(hex: 0x201E1D).opacity(0.16)
        public static let muted   = SwiftUI.Color(hex: 0x201E1D).opacity(0.55)

        /// Tonal ramps. 100–300 tinted fills, hovers, subtle borders.
        /// 500 base. 700–900 text on tinted fills and pressed states.
        public enum Neutral {
            public static let n100 = SwiftUI.Color(hex: 0xF9F4ED)
            public static let n200 = SwiftUI.Color(hex: 0xEEE7DB)
            public static let n300 = SwiftUI.Color(hex: 0xDCD3C4)
            public static let n400 = SwiftUI.Color(hex: 0xC0B6A5)
            public static let n500 = SwiftUI.Color(hex: 0xA19786)
            public static let n600 = SwiftUI.Color(hex: 0x82796A)
            public static let n700 = SwiftUI.Color(hex: 0x645C50)
            public static let n800 = SwiftUI.Color(hex: 0x474238)
            public static let n900 = SwiftUI.Color(hex: 0x2E2B25)
        }

        public enum Accent {
            public static let n100 = SwiftUI.Color(hex: 0xFFF2EB)
            public static let n200 = SwiftUI.Color(hex: 0xFFE1D0)
            public static let n300 = SwiftUI.Color(hex: 0xFFC6A5)
            public static let n400 = SwiftUI.Color(hex: 0xF6A06B)
            public static let n500 = SwiftUI.Color(hex: 0xD67F48)
            public static let n600 = SwiftUI.Color(hex: 0xB2622D)
            public static let n700 = SwiftUI.Color(hex: 0x8C491A)
            public static let n800 = SwiftUI.Color(hex: 0x643312)
            public static let n900 = SwiftUI.Color(hex: 0x402310)
        }

        public enum Accent2 {
            public static let n100 = SwiftUI.Color(hex: 0xF0FAE1)
            public static let n200 = SwiftUI.Color(hex: 0xE1EECC)
            public static let n300 = SwiftUI.Color(hex: 0xCCDBB2)
            public static let n400 = SwiftUI.Color(hex: 0xAEBF92)
            public static let n500 = SwiftUI.Color(hex: 0x8FA073)
            public static let n600 = SwiftUI.Color(hex: 0x728157)
            public static let n700 = SwiftUI.Color(hex: 0x56633F)
            public static let n800 = SwiftUI.Color(hex: 0x3D472B)
            public static let n900 = SwiftUI.Color(hex: 0x272E1B)
        }
    }

    // MARK: - Type
    // Caprasimo (display) over Figtree (body). The bundled faces and their
    // PostScript names live in Fonts.swift; sizes and roles live here.

    public enum Font {
        public static let headingName = Typeface.caprasimo.postScriptName
        public static let bodyName    = Typeface.figtreeRegular.postScriptName
        public static let bodySemi    = Typeface.figtreeSemiBold.postScriptName
        public static let bodyBold    = Typeface.figtreeBold.postScriptName

        public static func heading(_ size: CGFloat) -> SwiftUI.Font {
            .custom(headingName, size: size)
        }
        public static func body(_ size: CGFloat, bold: Bool = false, semibold: Bool = false) -> SwiftUI.Font {
            .custom(bold ? bodyBold : (semibold ? bodySemi : bodyName), size: size)
        }

        // Scale, matched to the web h1–h6 / body sizes.
        public static var h1: SwiftUI.Font { heading(42) }
        public static var h2: SwiftUI.Font { heading(32) }
        public static var h3: SwiftUI.Font { heading(25) }
        public static var h4: SwiftUI.Font { heading(20) }
        public static var h5: SwiftUI.Font { heading(16) }
        public static var h6: SwiftUI.Font { heading(13) }   // uppercase, 0.08em tracking
        public static var subHeading: SwiftUI.Font { body(20) }
        public static var body: SwiftUI.Font { body(18) }
        public static var bodySmall: SwiftUI.Font { body(14) }
        public static var caption: SwiftUI.Font { body(11) }
    }

    // MARK: - Space (density 1.10×)

    public enum Space {
        public static let s1: CGFloat = 4.4
        public static let s2: CGFloat = 8.8
        public static let s3: CGFloat = 13.2
        public static let s4: CGFloat = 17.6
        public static let s6: CGFloat = 26.4
        public static let s8: CGFloat = 35.2
    }

    // MARK: - Radius

    public enum Radius {
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 16
        public static let lg: CGFloat = 28
        public static let pill: CGFloat = 999
    }

    // MARK: - Pattern
    // Decorative fills that stand in for photography. Diagonal stripes read as
    // soft awning cloth against the rounded shapes.

    public enum Pattern {
        public static let stripeWidth: CGFloat = 10
        public static let stripeGap: CGFloat = 8
        /// Negative tilts the stripes top-left → bottom-right; flip the sign to mirror.
        public static let stripeAngle = Angle(degrees: 45)
    }

    // MARK: - Elevation

    public struct Shadow {
        public let color: SwiftUI.Color
        public let radius: CGFloat
        public let y: CGFloat

        public static let sm = Shadow(color: SwiftUI.Color(hex: 0x2E2B25).opacity(0.14), radius: 2,  y: 1)
        public static let md = Shadow(color: SwiftUI.Color(hex: 0x2E2B25).opacity(0.16), radius: 10, y: 3)
        public static let lg = Shadow(color: SwiftUI.Color(hex: 0x2E2B25).opacity(0.22), radius: 32, y: 12)
    }
}

// MARK: - Helpers

public extension Color {
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >>  8) & 0xFF) / 255,
            blue:  Double( hex        & 0xFF) / 255,
            opacity: 1
        )
    }
}

public extension View {
    /// The warm ground every screen sits on. Applied once in `RouteView`, so
    /// screens never set their own background — scroll containers stay
    /// transparent and let this show through.
    func organicScreen() -> some View {
        self
            .scrollContentBackground(.hidden)
            .background(Organic.Color.bg.ignoresSafeArea())
            .toolbarBackground(Organic.Color.bg, for: .navigationBar)
    }

    func organicShadow(_ s: Organic.Shadow) -> some View {
        shadow(color: s.color, radius: s.radius, x: 0, y: s.y)
    }

    /// Photographs sit back into the warm ground rather than on top of it.
    func washed() -> some View {
        self.saturation(0.6)
            .contrast(0.85)
            .brightness(0.06)
            .opacity(0.94)
    }
}

// MARK: - Components

public struct OrganicPrimaryButton: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Organic.Font.heading(14))
            .foregroundStyle(Organic.Color.bg)
            .padding(.horizontal, Organic.Space.s4)
            .padding(.vertical, Organic.Space.s3)
            .background(configuration.isPressed ? Organic.Color.Accent.n600 : Organic.Color.accent)
            .clipShape(Capsule())
    }
}

public struct OrganicSecondaryButton: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Organic.Font.heading(14))
            .foregroundStyle(Organic.Color.Accent.n700)
            .padding(.horizontal, Organic.Space.s4)
            .padding(.vertical, Organic.Space.s3)
            .background(configuration.isPressed ? Organic.Color.Accent.n200 : Organic.Color.Accent.n100)
            .overlay(Capsule().strokeBorder(Organic.Color.Accent.n300, lineWidth: 1))
            .clipShape(Capsule())
    }
}

public struct OrganicCard<Content: View>: View {
    let content: Content
    public init(@ViewBuilder content: () -> Content) { self.content = content() }
    public var body: some View {
        content
            .padding(Organic.Space.s6)
            .background(Organic.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: Organic.Radius.lg, style: .continuous))
            .organicShadow(.sm)
    }
}

/// Evenly spaced parallel bars, tilted. Bars are laid out across the shape's
/// diagonal so the pattern covers the rect at any angle.
public struct OrganicDiagonalStripes: Shape {
    public var width: CGFloat
    public var gap: CGFloat
    public var angle: Angle

    public init(
        width: CGFloat = Organic.Pattern.stripeWidth,
        gap: CGFloat = Organic.Pattern.stripeGap,
        angle: Angle = Organic.Pattern.stripeAngle
    ) {
        self.width = width
        self.gap = gap
        self.angle = angle
    }

    public func path(in rect: CGRect) -> Path {
        let period = width + gap
        guard period > 0 else { return Path() }

        // Cover the diagonal in both axes so a rotated bar never falls short.
        let span = hypot(rect.width, rect.height)
        var bars = Path()
        var x = -span / 2
        while x < span / 2 {
            bars.addRect(CGRect(x: x, y: -span / 2, width: width, height: span))
            x += period
        }

        return bars
            .applying(CGAffineTransform(rotationAngle: angle.radians))
            .applying(CGAffineTransform(translationX: rect.midX, y: rect.midY))
    }
}

/// Tinted ground with tilted stripes over it — the recipe thumbnail placeholder.
public struct OrganicStripePattern: View {
    let base: Color
    let stripe: Color
    let width: CGFloat
    let gap: CGFloat
    let angle: Angle

    public init(
        base: Color = Organic.Color.Accent.n200,
        stripe: Color = Organic.Color.Accent.n300,
        width: CGFloat = Organic.Pattern.stripeWidth,
        gap: CGFloat = Organic.Pattern.stripeGap,
        angle: Angle = Organic.Pattern.stripeAngle
    ) {
        self.base = base
        self.stripe = stripe
        self.width = width
        self.gap = gap
        self.angle = angle
    }

    public var body: some View {
        base.overlay {
            OrganicDiagonalStripes(width: width, gap: gap, angle: angle)
                .fill(stripe)
        }
    }
}

public struct OrganicTag: View {
    public enum Tone { case accent, accent2, neutral }
    let text: String
    let tone: Tone
    public init(_ text: String, tone: Tone = .neutral) { self.text = text; self.tone = tone }

    var fill: Color {
        switch tone {
        case .accent:  return Organic.Color.Accent.n200
        case .accent2: return Organic.Color.Accent2.n200
        case .neutral: return Organic.Color.Neutral.n200
        }
    }
    var ink: Color {
        switch tone {
        case .accent:  return Organic.Color.Accent.n700
        case .accent2: return Organic.Color.Accent2.n700
        case .neutral: return Organic.Color.Neutral.n700
        }
    }
    public var body: some View {
        Text(text)
            .font(Organic.Font.body(12, semibold: true))
            .foregroundStyle(ink)
            .padding(.horizontal, Organic.Space.s3)
            .padding(.vertical, Organic.Space.s1)
            .background(fill, in: Capsule())
    }
}
