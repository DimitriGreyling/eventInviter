# 🎠 Image Carousel Feature

## Overview
You can now add **multiple images as a carousel/slideshow** directly on your invitation cards! This feature allows guests to swipe through multiple photos within the invitation itself.

## ✨ Features

### 1. **Multi-Image Selection**
- Select multiple images at once from your gallery
- Add up to 10+ images for the carousel
- Preview thumbnails of all selected images

### 2. **Auto-Play Slideshow**
- Images automatically transition every 3 seconds
- Smooth fade animations between images
- Loops continuously through all images

### 3. **Manual Navigation**
- Left/right arrow buttons to navigate
- Swipe gestures supported
- Page indicators show current position

### 4. **Smart Display**
- Single image: Shows without carousel controls
- Multiple images: Full carousel with indicators and arrows
- Empty: Gracefully hidden (no placeholder)

## 🎯 How to Use

### Adding Carousel Images

1. **Open Customization View**
   - Navigate to template selection
   - Choose a template
   - Opens enhanced customization view

2. **Find "Image Carousel" Section**
   - Located in "Customize Style" panel
   - Look for 📚 Photo Library icon

3. **Select Multiple Images**
   - Click the **"Add images"** button (📷+ icon)
   - Multi-select images from your gallery
   - Hold Ctrl/Cmd to select multiple
   - Click "Open" or "Select"

4. **Manage Images**
   - **Preview**: Horizontal scrollable thumbnail list
   - **Remove Single**: Click ❌ on any thumbnail
   - **Clear All**: Click "Clear all" button (🗑️ icon)

5. **See Live Preview**
   - Preview updates instantly on the right
   - Carousel appears below event title
   - Try the arrows and indicators!

### Carousel Controls

**In Preview:**
- **◀️ Left Arrow**: Previous image
- **▶️ Right Arrow**: Next image
- **⬤ Indicators**: Show position (white = current)
- **Auto-play**: Changes every 3 seconds

## 📐 Technical Details

### Positioning
The carousel appears in the invitation at this location:
```
┌─────────────────────┐
│   Event Icon        │
│   Event Name        │
│   Hosted by...      │
│                     │
│   🎠 CAROUSEL 🎠    │  ← Here!
│                     │
│   📅 Date           │
│   🕐 Time           │
│   📍 Location       │
└─────────────────────┘
```

### Size & Dimensions
- **Height**: 180px (scales in preview)
- **Width**: Full container width
- **Aspect Ratio**: Cover (fills space)
- **Border Radius**: 12px rounded corners

### Timing
- **Auto-play interval**: 3 seconds
- **Transition duration**: 500ms
- **Smooth easing**: `Curves.easeInOut`

### Image Loading
- **Format support**: JPG, PNG, GIF
- **Error handling**: Shows broken image icon
- **File source**: Local file system
- **Optimization**: Flutter Image widget caching

## 🎨 Customization Options

### Current Settings
```dart
InvitationImageCarousel(
  imagePaths: [...],          // Your selected images
  height: 180,                // Fixed height
  borderRadius: 12px,         // Rounded corners
  autoPlay: true,             // Auto-advance enabled
  showIndicators: true,       // Show page dots
  autoPlayDuration: 3s,       // 3 seconds per image
)
```

### Future Enhancements (Coming Soon)
- [ ] Adjustable auto-play speed
- [ ] Caption text per image
- [ ] Different transition effects (fade, slide, zoom)
- [ ] Thumbnail grid view option
- [ ] Video support

## 🧪 Testing the Feature

### Test Scenario 1: Basic Carousel
1. Add 3-5 images to carousel
2. Fill event details
3. Check preview panel
4. **Verify**:
   - ✅ Images appear in carousel
   - ✅ Auto-play works (changes every 3s)
   - ✅ Arrows navigate correctly
   - ✅ Indicators show current position

### Test Scenario 2: Single Image
1. Add only 1 image to carousel
2. Check preview
3. **Verify**:
   - ✅ Image displays
   - ✅ No arrows or indicators shown
   - ✅ No auto-play (just static image)

### Test Scenario 3: No Images
1. Don't add any carousel images
2. Check preview
3. **Verify**:
   - ✅ Carousel section hidden
   - ✅ No empty placeholder
   - ✅ Event details still show

### Test Scenario 4: Image Management
1. Add 5 images
2. Remove one using ❌ button
3. Clear all using button
4. **Verify**:
   - ✅ Single removal works
   - ✅ Clear all removes everything
   - ✅ Preview updates immediately

### Test Scenario 5: With Background Image
1. Add background image
2. Add carousel images
3. **Verify**:
   - ✅ Both features work together
   - ✅ Background stays behind
   - ✅ Carousel images appear in card
   - ✅ No conflicts

## 💡 Best Practices

### Image Selection
- **Quantity**: 3-7 images is optimal
- **Quality**: Use high-resolution images (1080p+)
- **Orientation**: Portrait works best for invitations
- **Theme**: Keep consistent style/theme across images
- **File Size**: < 5MB per image recommended

### Use Cases

**Birthday Party** 🎂
- Past birthday photos
- Party venue pictures
- Birthday person's photos
- Cake & decoration ideas

**Wedding** 💍
- Engagement photos
- Venue pictures
- Save the date images
- Couple's photos together

**Corporate Event** 💼
- Company logo/branding
- Venue photos
- Speaker headshots
- Past event photos

**Baby Shower** 👶
- Ultrasound images
- Nursery photos
- Parent photos
- Gender reveal images

## 🔧 Troubleshooting

### Images Not Showing
**Problem**: Carousel appears empty
**Solutions**:
- Check file paths are valid
- Verify images exist on disk
- Try smaller file sizes
- Restart the app

### Auto-Play Not Working
**Problem**: Images don't advance
**Solutions**:
- Ensure you have 2+ images
- Check preview (not edit) mode
- Verify timer isn't paused

### Performance Issues
**Problem**: App slows down with many images
**Solutions**:
- Limit to 7-10 images max
- Reduce image file sizes
- Use compressed JPGs
- Close other apps

### Preview Not Updating
**Problem**: Changes don't appear
**Solutions**:
- Wait 1-2 seconds for rebuild
- Try adding/removing an image
- Hot reload the app (R key)

## 📊 Comparison: Background vs Carousel

| Feature | Background Image | Carousel Images |
|---------|-----------------|-----------------|
| **Purpose** | Full-card backdrop | Content slideshow |
| **Quantity** | Single image | Multiple images |
| **Visibility** | Behind all content | In content area |
| **Opacity** | Darkened (30%) | Full opacity |
| **Position** | Full background | Below header |
| **Navigation** | None | Arrows + swipe |
| **Auto-play** | N/A | Yes (3s interval) |

## 🎓 Pro Tips

1. **Combine Both Features**
   - Use background for atmosphere
   - Use carousel for storytelling
   - Example: Wedding venue background + couple photos carousel

2. **Order Matters**
   - First image shown first
   - Tell a story chronologically
   - Save best photo for last (loops back)

3. **Test on Different Sizes**
   - Preview looks different than full view
   - Test in actual invitation render
   - Check on different screen sizes

4. **Theme Consistency**
   - Match carousel images to template colors
   - Keep similar editing styles
   - Consistent aspect ratios help

5. **Performance**
   - Fewer, larger images > many small ones
   - JPG compresses better than PNG
   - Optimize before uploading

## 📱 Platform Support

- ✅ **Windows**: Fully supported
- ✅ **macOS**: Fully supported  
- ✅ **Linux**: Fully supported
- ✅ **iOS**: Supported (with image_picker)
- ✅ **Android**: Supported (with image_picker)
- ✅ **Web**: Supported (with file picker)

## 🚀 What's Next?

Future updates will include:
- Video support in carousel
- GIF animations
- Caption overlays
- Custom transition effects
- Thumbnail previews in full view
- Share carousel as animated GIF

---

**Enjoy creating dynamic, engaging invitations with the image carousel feature!** 🎉
