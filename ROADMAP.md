# Countertop — roadmap

_Written 2026-10-05, from the state of `ui/home`._

## Where the project actually is

The skeleton is in better shape than the app. MVVM-R is wired end to end —
`Router` owns navigation state, `Route`/`SheetRoute` carry ids not models,
`RouteView` is the single place a route becomes a screen, and `AppContainer`
builds every view model. The design system (`OrganicTheme.swift`) is complete
and the fonts are registered. It builds.

What's missing is the product:

- **Home** is the only real screen — header, search, a card grid with favorite
  hearts (in progress, uncommitted).
- **Detail** and **Settings** are placeholder `Text` views.
- **`RecipeListEntry` is the only model.** There are no ingredients, no steps,
  no macros. The README promises "recipes and their macros"; the model carries
  `caloriesPerServing` and nothing else.
- **Nothing persists.** `live()` runs on `InMemoryRecipeRepository`, so every
  launch starts from the same three samples. `BundledRecipeRepository` is
  written but there's no `recipes.json` for it to read, and it's commented out
  in `AppContainer.live()` behind a TODO.
- **No way to add a recipe.** That's the TODO gating the repository switch.
- **No test target.**

## Order of work

### 0 — Finish and clean up what's open (half a day)

The uncommitted favorites work has a real bug: `HomeViewModel.init` does
`self.favoritesStore = .init()`, so every view model gets its own store. Detail
will never agree with Home about what's favorited, and the state dies with the
screen. Move `FavoritesStore` into `AppContainer` and inject it.

Also while you're in there:

- `gridColumns` is two `.adaptive(minimum: 160)` columns. `.adaptive` already
  fills the row on its own, so two of them subdivide and give an unpredictable
  column count. Use one `.adaptive`, or two `.flexible()`.
- The card is a `VStack` with `.onTapGesture`. Make it a `Button` with a card
  style so it gets a pressed state (the design brief asks for one on every
  interactive element) and reads as a button to VoiceOver.
- `isLoading` and `loadFailed` are tracked in the view model and ignored by the
  view. Render them, plus an empty state for "no recipes" and "no search hits".
- Drop the commented-out block in `HomeScreen.body`.
- Search placeholder says "recipes or ingredients"; `matches(_:)` only checks
  the title. Either fix the copy now or leave it until step 1 gives you
  ingredients to search. (The `.lowercased()` inside
  `localizedCaseInsensitiveContains` is redundant either way.)

### 1 — Make the model real (the keystone)

Everything below is blocked on this, so do it first.

Split the model in two:

- `Recipe` — the full record: title, image, servings, ingredients, steps,
  macros (protein / carbs / fat / kcal per serving), prep and cook time, notes.
- `RecipeListEntry` — keep it as the grid's projection, derived from `Recipe`.

Add `Ingredient` (name, quantity, unit) and `Macros` as their own types.
Extend `RecipeRepository` with whatever Detail needs, and update both
repositories plus `.samples`.

This is also the moment the README stops being a lie.

### 2 — Detail screen

The biggest visible hole. Hero pattern or image, title, macro breakdown,
ingredients, steps, favorite toggle. A servings stepper that rescales
ingredient quantities is the feature that makes this app worth opening — do it
here rather than deferring it.

### 3 — Persistence

`RecipeRepository` exists precisely for this seam, so this should touch no
feature code. Add a SwiftData-backed implementation, seed it from
`recipes.json` on first launch (which also gives `BundledRecipeRepository` its
missing file), and flip `AppContainer.live()` over. Persist favorites too —
`UserDefaults` is fine at this size, as the comment in `FavoritesStore` says.

### 4 — Add / edit a recipe

The TODO in `AppContainer`. New routes (`.addRecipe`, `.editRecipe(id:)`), a
form with dynamic ingredient and step rows, a photo picker, macro entry.
Needs steps 1 and 3 done to be worth anything.

### 5 — Favorites and search as real surfaces

A favorites filter (chip or tab), sort options, and search that actually
reaches ingredients now that they exist.

### 6 — Settings

Units (metric / imperial), default servings, daily macro targets, about and
licenses. Small, and it stops the sheet being an empty box.

### 7 — Polish before you'd show anyone

- **Add a test target** — there is none. `HomeViewModel`, `DetailViewModel` and
  the repositories are all plain and easy to cover.
- **Dynamic Type.** `Organic.Font` builds every face with
  `.custom(name, size:)` and no `relativeTo:`, so nothing scales with the
  user's text size. Switching to `.custom(_:size:relativeTo:)` is a one-file
  change and worth doing before more screens bake in fixed sizes.
- Error and empty states across every screen, not just Home.
- Launch screen.

## Suggested sequencing

| When | Work |
| --- | --- |
| Now | Step 0 — land the favorites branch cleanly |
| Next | Step 1 — the real `Recipe` model |
| Then | Step 2 — Detail screen |
| After | Step 3 — persistence, then step 4 — add/edit |
| Later | Steps 5–7 |

Steps 0–2 are what turn this from a scaffold into something you can use. 3 and
4 make it yours rather than a demo. 5–7 are what you do before anyone else
sees it.
