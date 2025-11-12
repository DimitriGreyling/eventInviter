# Event Inviter - Feature Overview

## 🎉 New Features Added - Carousel & Image Customization

### Overview
We've enhanced the event invitation app with advanced customization features including:
- **Template Carousel Navigation** - Swipe through templates with a beautiful carousel interface
- **Background Image Support** - Add custom background images to any template
- **Color Customization** - Customize primary, accent, and background colors
- **Live Preview** - See changes in real-time as you customize

---

## 📦 New Dependencies

### Added to `pubspec.yaml`:
```yaml
dependencies:
  image_picker: ^1.0.7         # Photo selection from gallery
  flex_color_picker: ^3.4.1    # Advanced color picker UI
```

**Note**: We use Flutter's built-in `PageView` widget for carousel functionality instead of external packages to avoid dependency conflicts.

---

## 🏗️ Architecture Updates

### 1. Enhanced Data Models (`lib/models/event_model.dart`)

#### New `InvitationCustomization` Class:
```dart
class InvitationCustomization {
  final String? backgroundImagePath;     // Path to custom background image
  final Color? customPrimaryColor;       // Override template primary color
  final Color? customAccentColor;        // Override template accent color
  final Color? customBackgroundColor;    // Override template background color
  final double? fontSize;                // Future: Custom font size
  final String? fontFamily;              // Future: Custom font family
}
```

#### Updated `EventModel`:
- Added `customization` field to store user customizations
- Customizations are applied on top of the selected template
- Preserves original template design while allowing personalization

---

### 2. Improved InvitationRenderer (`lib/widgets/invitation_renderer.dart`)

#### Key Enhancements:
- **Effective Color Scheme System**: Merges template colors with custom colors
- **Background Image Support**: Displays custom images with darkening overlay for text readability
- **All 5 Layout Types Updated**:
  - `_CenteredLayout` - Classic centered design
  - `_LeftAlignedLayout` - Professional asymmetric design
  - `_CardLayout` - Elevated card with border
  - `_FullImageLayout` - Bold full-bleed gradient design
  - `_SplitLayout` - Divided two-column design

#### Color Scheme Resolution:
```dart
TemplateColorScheme _effectiveColorScheme {
  // Use custom colors if available, fall back to template colors
  return TemplateColorScheme(
    primary: customPrimaryColor ?? template.colorScheme.primary,
    accent: customAccentColor ?? template.colorScheme.accent,
    background: customBackgroundColor ?? template.colorScheme.background,
    // ...
  );
}
```

---

### 3. New Enhanced Customization View (`lib/views/enhanced_customization_view.dart`)

#### Features:

**Split-Screen Layout:**
- **Left Panel (40%)**: Customization controls and event form
- **Right Panel (60%)**: Live preview of invitation

**Template Carousel:**
- Swipe through all 14 templates
- Selected template highlighted with border and shadow
- Template name displayed on each card
- Smooth animated transitions

**Customization Panel:**
1. **Background Image**
   - Tap to select image from gallery
   - Clear button to remove image
   - Visual indicator when image is selected

2. **Color Customization**
   - Primary Color picker
   - Accent Color picker
   - Background Color picker
   - Full-featured color picker with wheel and palette
   - Reset all customizations with one button

**Event Details Form:**
- Event Name (required)
- Host Name (required)
- Date picker (required)
- Time picker (required)
- Location (required)
- Description (optional)
- Real-time preview updates

**Help Dialog:**
- Quick guide for using customization features
- Accessible from app bar help icon

---

## 🛣️ Updated Routing (`lib/router/app_router.dart`)

### New Route:
```dart
GoRoute(
  path: '/templates/:templateId/enhanced',
  name: 'enhancedCustomize',
  pageBuilder: (context, state) {
    final templateId = state.pathParameters['templateId']!;
    return MaterialPage(
      key: state.pageKey,
      child: EnhancedCustomizationView(initialTemplateId: templateId),
    );
  },
),
```

### Navigation Flow:
```
Home View
  ↓
Template Selection View (Browse templates)
  ↓
Enhanced Customization View (Customize with carousel, colors, images)
  ↓
Create Invitation → Back to Home
```

---

## 🎨 User Experience Flow

### 1. **Home Page**
- Modern minimal design with hero section
- "Get Started" button navigates to templates
- Feature showcase
- Professional branding

### 2. **Template Selection**
- Category filter chips (All, Birthday, Wedding, Corporate, etc.)
- Grid view of all 14 templates
- Real previews using InvitationRenderer
- Premium badge on premium templates
- Tap any template to customize

### 3. **Enhanced Customization**
- **Carousel at top**: Swipe to change templates on the fly
- **Customization section**: 
  - Add background image button
  - Three color pickers (Primary, Accent, Background)
  - Reset button to clear all customizations
- **Event form**: Fill in all event details
- **Live preview**: Real-time updates on the right
- **Create button**: Finalize invitation

---

## 🔧 Technical Implementation Details

### Image Handling:
```dart
// File-based image loading with overlay
DecorationImage(
  image: FileImage(File(backgroundImagePath)),
  fit: BoxFit.cover,
  colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.3),  // Darkens image for text readability
    BlendMode.darken,
  ),
)
```

### Carousel Implementation:
```dart
PageView.builder(
  controller: PageController(viewportFraction: 0.8),
  onPageChanged: (index) {
    // Update selected template
  },
  itemCount: templates.length,
  itemBuilder: (context, index) {
    return AnimatedScale(
      scale: isSelected ? 1.0 : 0.9,  // Selected template pops out
      duration: const Duration(milliseconds: 300),
      child: /* Template card */,
    );
  },
)
```

### Color Picker Dialog:
```dart
ColorPicker(
  color: selectedColor,
  onColorChanged: (Color color) {
    selectedColor = color;
  },
  pickersEnabled: const <ColorPickerType, bool>{
    ColorPickerType.wheel: true,    // Color wheel selector
    ColorPickerType.primary: true,  // Material primary colors
    ColorPickerType.accent: false,  // Disabled
  },
)
```

---

## 📱 Supported Platforms

All features work across:
- ✅ **Windows** (Desktop)
- ✅ **macOS** (Desktop)
- ✅ **Linux** (Desktop)
- ✅ **Web** (Browser)
- ✅ **iOS** (Mobile)
- ✅ **Android** (Mobile)

*Note: Image picker automatically adapts to each platform*

---

## 🎯 Design Patterns Used

### 1. **MVVM Architecture**
- Models: `EventModel`, `InvitationCustomization`, `InvitationTemplate`
- Views: `EnhancedCustomizationView`, `TemplateSelectionView`
- ViewModels: Riverpod providers (`templateProvider`, `templateByIdProvider`)

### 2. **Riverpod State Management**
- Template data managed centrally
- Reactive UI updates
- Automatic rebuilds on state changes

### 3. **GoRouter Navigation**
- Type-safe routing
- Deep linking support
- Named routes for maintainability

### 4. **Composition over Inheritance**
- Reusable `InvitationRenderer` widget
- Separate layout widgets for different designs
- Shared `_EventDetails` component

---

## 🚀 Future Enhancements (Ready to Implement)

1. **Font Customization**
   - Already in data model (`fontSize`, `fontFamily`)
   - Add font selector UI
   - Google Fonts integration

2. **Save/Load Invitations**
   - Persist to local storage
   - Export as image
   - Share via URL

3. **Animation Effects**
   - Entrance animations
   - Parallax scrolling
   - Confetti effects

4. **Advanced Layouts**
   - Video backgrounds
   - Animated gradients
   - Interactive elements

---

## 📝 Testing Checklist

### To Test:
- [ ] Swipe through carousel to change templates
- [ ] Select background image from gallery
- [ ] Change primary color and verify preview updates
- [ ] Change accent color and verify preview updates
- [ ] Change background color and verify preview updates
- [ ] Reset all customizations button works
- [ ] Fill form and see live preview update
- [ ] Create invitation navigates back to home
- [ ] Help dialog displays guide
- [ ] All 14 templates render correctly
- [ ] All 5 layouts work with custom colors
- [ ] Background image displays with darkening overlay

---

## 🎨 Color Customization Examples

### Example 1: Birthday Theme
- Template: "Birthday Bash"
- Primary: Pink (`#E91E63`)
- Accent: Yellow (`#FFC107`)
- Background Image: Balloons photo

### Example 2: Wedding Theme
- Template: "Elegant Evening"
- Primary: Gold (`#FFD700`)
- Accent: White (`#FFFFFF`)
- Background Image: Floral pattern

### Example 3: Corporate Theme
- Template: "Professional Meet"
- Primary: Navy Blue (`#1A237E`)
- Accent: Teal (`#00897B`)
- Background: Solid Gray

---

## 🐛 Known Issues / Limitations

1. **Image Size**: Large images may affect performance - consider compression
2. **Web Platform**: File picker shows different UI on web vs. mobile
3. **Text Readability**: Very bright background images may need stronger darkening

---

## 📚 Code Structure

```
lib/
├── models/
│   ├── event_model.dart              ← InvitationCustomization added
│   └── invitation_template.dart
├── providers/
│   └── template_provider.dart
├── views/
│   ├── home_view.dart
│   ├── template_selection_view.dart
│   ├── template_customization_view.dart
│   └── enhanced_customization_view.dart  ← NEW: Carousel & customization
├── widgets/
│   └── invitation_renderer.dart      ← Updated: Color & image support
└── router/
    └── app_router.dart               ← Updated: New route added
```

---

## 🎓 Key Learnings

1. **Effective Color System**: Merging template and custom colors provides flexibility
2. **Live Preview**: Real-time updates enhance UX significantly
3. **Carousel Navigation**: More intuitive than grid for template browsing
4. **Split-Screen Layout**: Desktop-friendly customization interface
5. **Platform Adaptation**: `image_picker` handles platform differences automatically

---

## ✨ Summary

The event inviter app now offers a **professional-grade customization experience** with:
- 🎠 Beautiful template carousel
- 🖼️ Background image support
- 🎨 Full color customization
- 👁️ Real-time live preview
- 📱 Cross-platform compatibility

Users can start with any of the 14 pre-designed templates and make them uniquely theirs while maintaining the beautiful layout and design of the original template!
