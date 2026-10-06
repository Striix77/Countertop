# Organic design system — iOS/SwiftUI brief

Binding visual style for this app. Take every color, font, spacing value, radius
and shadow from `OrganicTheme.swift`. Never hard-code a hex, a font name, or a
px value the tokens already carry. If something is missing from the tokens, add
it to `OrganicTheme.swift` rather than inlining it at the call site.

## Setup

1. Add `OrganicTheme.swift` to the target.
2. Download Caprasimo and Figtree from Google Fonts, add the `.ttf` files to the
   bundle (target membership on), and list them in `Info.plist` under
   `UIAppFonts`. Verify the PostScript names match
   `Organic.Font.headingName` / `bodyName` — print
   `UIFont.familyNames` once if a font renders as system.
3. Set the app background to `Organic.Color.bg` at the root, not per screen.

## Direction

Warm, rounded, a little playful. Cream-and-sand ground, terracotta accent, sage
second accent. Caprasimo display headings over Figtree body. 16pt radii that
grow into pills and soft circular shapes.

- Left-aligned, asymmetric layouts. Flush-left headings; content hugs the
  leading edge with whitespace trailing.
- Over-round: `Radius.lg` for containers, `Capsule()` for buttons and inputs.
- Soft shapes — circles and blobs — as decoration and as image masks.
- Sage (`Color.Accent2.*`) is a genuine second voice, not just a highlight.
- Photographs go through `.washed()` so they sit back into the page.

## Color use

- 100–300 for tinted fills, subtle borders, pressed backgrounds.
- 500 as the role's base.
- 700–900 for text on tinted fills and for pressed states.
- Prefer a ramp step over an ad-hoc opacity or blend.
- The accent-to-ground pair is ~3:1 — fine for icons, large text and chrome,
  not for body copy. Paragraph text in the accent uses `Accent.n700`.

## Type scale

| Role | Token | Size |
| --- | --- | --- |
| Display | `Font.h1` | 42 |
| Screen title | `Font.h2` | 32 |
| Section | `Font.h3` | 25 |
| Card title | `Font.h4` | 20 |
| Label | `Font.h5` | 16 |
| Eyebrow | `Font.h6` | 13, uppercase, tracking 0.08em |
| Body | `Font.bodyM` | 15 |
| Caption | `Font.caption` | 11 |

Headings only in Caprasimo. Everything else Figtree.

## Components provided

`OrganicPrimaryButton` / `OrganicSecondaryButton` (ButtonStyles),
`OrganicCard`, `OrganicTag`, `.organicShadow(_:)`, `.washed()`.

Build new components from the tokens in the same shape rather than restyling
system controls inline.

## States

Every interactive element gets a pressed state one ramp step past its base
(`Accent.n600` on the light ground). Disabled drops to 45% opacity. Hit targets
never below 44pt.

## Don't

- Sharp corners or hairline-only geometry.
- Desaturating the palette into greys — warmth is the point.
- Condensed or geometric display faces; Caprasimo is the only display voice.
- Crowding; the rounded shapes need air to read as soft.

## Reference

`styles.css` in this folder is the web source of truth for the tokens. When the
two disagree, the CSS wins — re-port the changed values into
`OrganicTheme.swift`.
