# Creating Different Layout Templates

## Overview

The invitation template system now supports **5 distinct visual layouts**, each rendered by the `InvitationRenderer` widget. This guide explains how each layout works and how to create new ones.

## Available Layouts

### 1. **Centered Layout** (`TemplateLayout.centered`)
Classic, symmetric design with all content centered.

**Visual Structure:**
```
    ══════════
       🎉
    Event Name
    ─────────
    Hosted by Name
    📅 Date
    🕐 Time
    📍 Location
    ══════════
```

**Best For:** Formal events, weddings, elegant invitations

**Features:**
- Decorative gradient borders (top & bottom)
- Large centered event name
- Accent line separator
- Vertical icon placement
- Italic host name

---

### 2. **Left Aligned Layout** (`TemplateLayout.leftAligned`)
Professional asymmetric design.

**Visual Structure:**
```
🎉  Event Name
─────
Hosted by Name
📅 Date
🕐 Time
📍 Location
```

**Best For:** Corporate events, professional gatherings

**Features:**
- Icon in colored box (left side)
- Left-aligned text
- Horizontal accent line
- Clean, business-like appearance

---

### 3. **Card Layout** (`TemplateLayout.card`)
Elevated card with decorative border and corners.

**Visual Structure:**
```
┌──────────────────┐
│  ┐          ┌    │
│      🎉          │
│   Event Name     │
│  Hosted by Name  │
│   📅 Date        │
│  └          ┘    │
└──────────────────┘
```

**Best For:** Birthday parties, casual celebrations

**Features:**
- White card with colored border
- Decorative corner elements
- Box shadow for elevation
- Centered content within card
- Border matches template primary color

---

### 4. **Full Image Layout** (`TemplateLayout.fullImage`)
Gradient background with white text overlay.

**Visual Structure:**
```
╔══════════════════╗
║  ⚪ (glowing)    ║
║    🎉           ║
║   Event Name    ║
║  Hosted by Name ║
║   📅 Date       ║
║                 ║
╚══════════════════╝
```

**Best For:** Holiday events, festive celebrations, premium invitations

**Features:**
- Full gradient background (primary → secondary → accent)
- White text for high contrast
- Glowing icon effect
- Text shadows for depth
- Immersive design

---

### 5. **Split Layout** (`TemplateLayout.split`)
Two-column design with colored sidebar.

**Visual Structure:**
```
┌─────┬──────────────┐
│     │ Event Name   │
│ 🎉  │ ─────        │
│     │ Hosted by    │
│     │ 📅 Date      │
│     │ 🕐 Time      │
└─────┴──────────────┘
```

**Best For:** Modern events, tech meetups, conferences

**Features:**
- Vertical gradient sidebar (1/3 width)
- Large centered icon on sidebar
- Content on right (2/3 width)
- Modern, magazine-style layout
- Left-aligned text content

---

## The InvitationRenderer Widget

### Usage

```dart
InvitationRenderer(
  template: myTemplate,         // Required: InvitationTemplate
  event: myEvent,               // Optional: EventModel (for data)
  isPreview: false,             // Optional: true for small preview
  width: 400,                   // Optional: fixed width
  height: 600,                  // Optional: fixed height
)
```

### Parameters

- **`template`** (required): The `InvitationTemplate` defining colors, layout, category
- **`event`** (optional): The `EventModel` with actual event data. If null, shows placeholder text
- **`isPreview`** (default: false): 
  - `true` = Miniature version (0.4x scale) for template selection cards
  - `false` = Full size for customization and final display
- **`width`** / **`height`** (optional): Fixed dimensions

### Automatic Features

The renderer automatically:
- ✅ Applies template color scheme
- ✅ Scales elements for preview mode
- ✅ Shows placeholder text when event data is missing
- ✅ Handles all 5 layout types
- ✅ Adds decorative elements per layout
- ✅ Responsive to container size

---

## Creating a New Layout

### Step 1: Add Layout Type to Enum

Edit `lib/models/invitation_template.dart`:

```dart
enum TemplateLayout {
  centered,
  leftAligned,
  card,
  fullImage,
  split,
  myNewLayout, // Add here
}
```

### Step 2: Create Layout Widget

Add to `lib/widgets/invitation_renderer.dart`:

```dart
class _MyNewLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;

  const _MyNewLayout({
    required this.template,
    required this.event,
    required this.isPreview,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Padding(
      padding: EdgeInsets.all(isPreview ? 16 : 32),
      child: Column(
        children: [
          // Your custom layout here
          Icon(
            template.category.icon,
            size: 48 * scale,
            color: template.colorScheme.primary,
          ),
          // ... more widgets
        ],
      ),
    );
  }
}
```

### Step 3: Add to Switch Statement

In `InvitationRenderer._buildLayout()`:

```dart
Widget _buildLayout() {
  switch (template.layout) {
    case TemplateLayout.centered:
      return _CenteredLayout(...);
    // ... other cases
    case TemplateLayout.myNewLayout:
      return _MyNewLayout(template: template, event: event, isPreview: isPreview);
  }
}
```

### Step 4: Create Templates Using New Layout

In `lib/providers/template_provider.dart`:

```dart
const InvitationTemplate(
  id: 'my_template',
  name: 'My New Template',
  description: 'Description',
  category: TemplateCategory.birthday,
  layout: TemplateLayout.myNewLayout, // Use new layout
  colorScheme: TemplateColorScheme.vibrant,
),
```

---

## Layout Design Best Practices

### 1. **Responsive Scaling**
Always multiply sizes by `scale` variable:
```dart
final scale = isPreview ? 0.4 : 1.0;
fontSize: 24 * scale,
padding: EdgeInsets.all(16 * scale),
```

### 2. **Use Template Colors**
Access colors from template:
```dart
color: template.colorScheme.primary,      // Main color
color: template.colorScheme.accent,       // Highlight color
color: template.colorScheme.background,   // Background
color: template.colorScheme.textPrimary,  // Main text
color: template.colorScheme.textSecondary, // Secondary text
```

### 3. **Handle Missing Data**
Show placeholders when event data is absent:
```dart
Text(event?.name ?? 'Event Name')
```

### 4. **Include Event Details**
Use the `_EventDetails` component for consistency:
```dart
if (!isPreview && event != null)
  _EventDetails(
    template: template,
    event: event!,
    scale: scale,
    useWhiteText: false, // true for dark backgrounds
  ),
```

### 5. **Preview vs Full Size**
- **Preview mode**: Show only essential elements (icon, name)
- **Full size**: Show all event details (date, time, location, description)

---

## Color Scheme Combinations

Mix and match color schemes with layouts for variety:

```dart
// Elegant corporate invitation
layout: TemplateLayout.leftAligned,
colorScheme: TemplateColorScheme.elegant,

// Fun birthday party
layout: TemplateLayout.card,
colorScheme: TemplateColorScheme.vibrant,

// Luxury wedding
layout: TemplateLayout.centered,
colorScheme: TemplateColorScheme.gold,

// Beach party
layout: TemplateLayout.fullImage,
colorScheme: TemplateColorScheme.ocean,
```

---

## Advanced Customization

### Adding Decorative Elements

The renderer includes helper widgets:

**Decorative Corners:**
```dart
_DecorativeCorner(
  color: template.colorScheme.accent,
  scale: scale,
  flip: true,    // Mirror horizontally
  rotate: true,  // Mirror vertically
)
```

**Gradient Borders:**
```dart
Container(
  width: 60 * scale,
  height: 2,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        template.colorScheme.primary,
        template.colorScheme.accent,
      ],
    ),
  ),
)
```

**Accent Lines:**
```dart
Container(
  width: 80 * scale,
  height: 3,
  decoration: BoxDecoration(
    color: template.colorScheme.accent,
    borderRadius: BorderRadius.circular(2),
  ),
)
```

---

## Testing Your Layout

1. **Add template to provider** with your new layout
2. **Browse templates** - Your layout appears in the grid
3. **Select template** - Opens customization view
4. **Fill in details** - Live preview updates in real-time
5. **Check preview mode** - Verify miniature version looks good

---

## Summary

You now have:
- ✅ **5 professional layouts** ready to use
- ✅ **Reusable renderer widget** for consistency
- ✅ **Scalable previews** for selection screen
- ✅ **Live customization** with real-time updates
- ✅ **Easy extensibility** to add more layouts

Each layout can be combined with any of the 6 color schemes, giving you **30 unique template variations** out of the box!

To add more variety:
1. Create new color schemes
2. Design new layouts
3. Mix and match
4. Add category-specific styling

The system is fully modular and designed for easy expansion! 🎨✨
