# Invitation Template System

## Overview

The template system allows inviters to select from pre-designed invitation templates and customize them with their event details. The system provides a seamless flow from template selection to event creation with live preview.

## Architecture

### 1. **Models** (`lib/models/`)

#### `invitation_template.dart`
Defines the template structure with:
- **InvitationTemplate**: Core template model with properties:
  - `id`: Unique identifier
  - `name`: Display name
  - `description`: Template description
  - `category`: Template category (Birthday, Wedding, Corporate, etc.)
  - `layout`: Visual layout type (Centered, Card, Split, etc.)
  - `colorScheme`: Color palette with primary, secondary, background, text, and accent colors
  - `isPremium`: Premium template flag

- **TemplateCategory** enum: Birthday, Wedding, Corporate, Casual, Formal, Holiday
- **TemplateLayout** enum: Centered, LeftAligned, Card, FullImage, Split
- **TemplateColorScheme**: Pre-defined color palettes (Elegant, Vibrant, Soft, Gold, Forest, Ocean)

#### `event_model.dart`
Event model with template support:
- Stores event details (name, host, date, time, location, description)
- **`templateId`**: Links event to its template
- Helper methods for formatted dates and date checking

### 2. **Providers** (`lib/providers/`)

#### `template_provider.dart`
Riverpod providers for template management:
- **`templateProvider`**: Provides all available templates (14 templates across 6 categories)
- **`templateByIdProvider`**: Get specific template by ID
- **`templatesByCategoryProvider`**: Filter templates by category

### 3. **Views** (`lib/views/`)

#### `template_selection_view.dart`
Template browsing interface:
- **Category Filter**: Horizontal scrollable chips for filtering by category
- **Template Grid**: 2-column responsive grid showing template cards
- **Template Cards**: Preview cards with:
  - Color scheme preview
  - Category icon
  - Template name and description
  - Premium badge (if applicable)
- **Navigation**: Taps navigate to customization view

#### `template_customization_view.dart`
Template customization interface with **split-screen design**:

**Left Panel - Form Section:**
- Event Name (required)
- Hosted By (required)
- Date (required, with date picker)
- Time (required, with time picker)
- Location (required)
- Description (optional)
- Action buttons: "Back to Templates" and "Create Invitation"
- Real-time validation

**Right Panel - Live Preview:**
- Real-time preview of invitation as user types
- Renders template with actual layout and colors
- Updates immediately when form fields change
- Shows exactly how the final invitation will look

**Layout Rendering:**
The system supports 5 different layout types:
1. **Centered**: Icon at top, event name centered, details below
2. **Left Aligned**: Icon and title on left, professional layout
3. **Card**: Centered layout wrapped in bordered card
4. **Full Image**: Gradient background with white text
5. **Split**: Icon on left, details on right (2-column)

### 4. **Router** (`lib/router/app_router.dart`)

Updated routes:
- `/` - Home page
- `/templates` - Template selection view
- `/templates/:templateId/customize` - Template customization with specific template
- `/detail` - Demo detail view

New route helper:
```dart
AppRoutes.templates // Navigate to template selection
AppRoutes.templateCustomize(templateId) // Navigate to customization
```

## User Flow

```
Home Page
    ↓
[Get Started Free] button
    ↓
Template Selection View
    ↓
Browse templates by category
Filter by: All, Birthday, Wedding, Corporate, Casual, Formal, Holiday
    ↓
Select template
    ↓
Template Customization View
    ↓
Fill in event details (left panel)
See live preview (right panel)
    ↓
[Create Invitation]
    ↓
Event created with template
```

## Available Templates

### Birthday (3 templates)
- **Vibrant Birthday**: Colorful design with vibrant colors
- **Elegant Birthday**: Sophisticated style for milestone birthdays
- **Fun & Festive**: Playful design with soft colors

### Wedding (3 templates)
- **Classic Wedding**: Timeless elegance (Premium)
- **Golden Romance**: Luxurious gold accents (Premium)
- **Garden Wedding**: Fresh natural design

### Corporate (2 templates)
- **Professional**: Clean corporate design
- **Modern Business**: Contemporary style

### Casual (2 templates)
- **Casual Party**: Relaxed friendly design
- **Beach Party**: Ocean-inspired design

### Formal (2 templates)
- **Gala Night**: Sophisticated formal design (Premium)
- **Black Tie**: Elegant black-tie affair (Premium)

### Holiday (2 templates)
- **Festive Holiday**: Cheerful holiday design
- **Winter Wonderland**: Cool winter tones

## Key Features

✅ **14 Pre-designed Templates** across 6 categories
✅ **6 Color Schemes**: Elegant, Vibrant, Soft, Gold, Forest, Ocean
✅ **5 Layout Types**: Flexible visual presentations
✅ **Live Preview**: Real-time rendering as user types
✅ **Category Filtering**: Easy template discovery
✅ **Premium Templates**: Special templates marked with star badge
✅ **Responsive Design**: Works on all screen sizes
✅ **Form Validation**: Required fields and proper validation
✅ **Date/Time Pickers**: Native Flutter pickers for easy selection

## Integration Points

### To Use Templates in Your App:

1. **Navigate to Template Selection:**
```dart
context.push(AppRoutes.templates);
```

2. **Access Template Provider:**
```dart
final templates = ref.watch(templateProvider);
final template = ref.watch(templateByIdProvider('template_id'));
```

3. **Create Event with Template:**
```dart
final event = EventModel(
  id: uniqueId,
  name: eventName,
  hostName: hostName,
  // ... other fields
  templateId: selectedTemplate.id,
  createdAt: DateTime.now(),
);
```

## Customization

### Adding New Templates:
Edit `lib/providers/template_provider.dart` and add to `_defaultTemplates`:

```dart
const InvitationTemplate(
  id: 'unique_id',
  name: 'Template Name',
  description: 'Description',
  category: TemplateCategory.birthday,
  layout: TemplateLayout.centered,
  colorScheme: TemplateColorScheme.vibrant,
  isPremium: false,
),
```

### Adding New Color Schemes:
Add to `TemplateColorScheme` class in `lib/models/invitation_template.dart`:

```dart
static const myScheme = TemplateColorScheme(
  primary: Color(0xFF...),
  secondary: Color(0xFF...),
  background: Color(0xFF...),
  textPrimary: Color(0xFF...),
  textSecondary: Color(0xFF...),
  accent: Color(0xFF...),
);
```

### Adding New Layouts:
1. Add layout type to `TemplateLayout` enum
2. Implement rendering in `template_customization_view.dart`:
```dart
Widget _buildMyCustomLayout(InvitationTemplate template) {
  // Custom layout implementation
}
```

## Future Enhancements

🔮 **Planned Features:**
- Save templates to event database
- Share invitation URLs with template rendering
- Template preview images (actual screenshots)
- User-uploaded custom templates
- Template editing (modify colors, fonts)
- More layout variations
- Image upload for backgrounds
- Custom font selection
- Template favorites
- Template search
- Template analytics (most used)

## Technical Notes

- **State Management**: Riverpod providers for template state
- **Navigation**: GoRouter for declarative routing
- **Form Management**: StatefulWidget with form controllers
- **Real-time Updates**: setState triggers live preview refresh
- **Immutability**: Models are immutable with copyWith pattern
- **Type Safety**: Strong typing throughout with enums

## File Structure

```
lib/
├── models/
│   ├── invitation_template.dart  # Template models and enums
│   └── event_model.dart           # Event model with template support
├── providers/
│   └── template_provider.dart     # Template data and providers
├── views/
│   ├── template_selection_view.dart      # Browse templates
│   └── template_customization_view.dart  # Customize and preview
└── router/
    └── app_router.dart            # Routing configuration
```

## Summary

The template system provides a complete solution for creating beautiful, customizable event invitations. Users can:
1. Browse professionally designed templates
2. Filter by event type
3. Customize with their event details
4. See real-time preview
5. Create invitations instantly

The architecture is extensible, type-safe, and follows Flutter best practices with Riverpod state management and Material Design 3 principles.
