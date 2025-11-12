import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/invitation_template.dart';

/// Provider for available invitation templates
final templateProvider = Provider<List<InvitationTemplate>>((ref) {
  return _defaultTemplates;
});

/// Provider to get template by ID
final templateByIdProvider = Provider.family<InvitationTemplate?, String>((ref, id) {
  final templates = ref.watch(templateProvider);
  try {
    return templates.firstWhere((template) => template.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider to filter templates by category
final templatesByCategoryProvider = Provider.family<List<InvitationTemplate>, TemplateCategory?>((ref, category) {
  final templates = ref.watch(templateProvider);
  if (category == null) return templates;
  return templates.where((template) => template.category == category).toList();
});

/// Default templates collection
const List<InvitationTemplate> _defaultTemplates = [
  // Birthday Templates
  InvitationTemplate(
    id: 'birthday_vibrant',
    name: 'Vibrant Birthday',
    description: 'Colorful and fun design perfect for birthday celebrations',
    category: TemplateCategory.birthday,
    layout: TemplateLayout.centered,
    colorScheme: TemplateColorScheme.vibrant,
  ),
  InvitationTemplate(
    id: 'birthday_elegant',
    name: 'Elegant Birthday',
    description: 'Sophisticated style for milestone birthdays',
    category: TemplateCategory.birthday,
    layout: TemplateLayout.card,
    colorScheme: TemplateColorScheme.elegant,
  ),
  InvitationTemplate(
    id: 'birthday_fun',
    name: 'Fun & Festive',
    description: 'Playful design with bright colors',
    category: TemplateCategory.birthday,
    layout: TemplateLayout.split,
    colorScheme: TemplateColorScheme.soft,
  ),

  // Wedding Templates
  InvitationTemplate(
    id: 'wedding_classic',
    name: 'Classic Wedding',
    description: 'Timeless elegance for your special day',
    category: TemplateCategory.wedding,
    layout: TemplateLayout.centered,
    colorScheme: TemplateColorScheme.elegant,
    isPremium: true,
  ),
  InvitationTemplate(
    id: 'wedding_gold',
    name: 'Golden Romance',
    description: 'Luxurious gold accents for a glamorous wedding',
    category: TemplateCategory.wedding,
    layout: TemplateLayout.card,
    colorScheme: TemplateColorScheme.gold,
    isPremium: true,
  ),
  InvitationTemplate(
    id: 'wedding_garden',
    name: 'Garden Wedding',
    description: 'Fresh and natural design for outdoor ceremonies',
    category: TemplateCategory.wedding,
    layout: TemplateLayout.fullImage,
    colorScheme: TemplateColorScheme.forest,
  ),

  // Corporate Templates
  InvitationTemplate(
    id: 'corporate_professional',
    name: 'Professional',
    description: 'Clean and corporate design for business events',
    category: TemplateCategory.corporate,
    layout: TemplateLayout.leftAligned,
    colorScheme: TemplateColorScheme.elegant,
  ),
  InvitationTemplate(
    id: 'corporate_modern',
    name: 'Modern Business',
    description: 'Contemporary style for corporate gatherings',
    category: TemplateCategory.corporate,
    layout: TemplateLayout.card,
    colorScheme: TemplateColorScheme.ocean,
  ),

  // Casual Templates
  InvitationTemplate(
    id: 'casual_party',
    name: 'Casual Party',
    description: 'Relaxed and friendly design for informal gatherings',
    category: TemplateCategory.casual,
    layout: TemplateLayout.centered,
    colorScheme: TemplateColorScheme.soft,
  ),
  InvitationTemplate(
    id: 'casual_beach',
    name: 'Beach Party',
    description: 'Ocean-inspired design for beach events',
    category: TemplateCategory.casual,
    layout: TemplateLayout.split,
    colorScheme: TemplateColorScheme.ocean,
  ),

  // Formal Templates
  InvitationTemplate(
    id: 'formal_gala',
    name: 'Gala Night',
    description: 'Sophisticated design for formal events',
    category: TemplateCategory.formal,
    layout: TemplateLayout.card,
    colorScheme: TemplateColorScheme.elegant,
    isPremium: true,
  ),
  InvitationTemplate(
    id: 'formal_black_tie',
    name: 'Black Tie',
    description: 'Elegant design for black-tie affairs',
    category: TemplateCategory.formal,
    layout: TemplateLayout.centered,
    colorScheme: TemplateColorScheme.gold,
    isPremium: true,
  ),

  // Holiday Templates
  InvitationTemplate(
    id: 'holiday_festive',
    name: 'Festive Holiday',
    description: 'Cheerful design for holiday celebrations',
    category: TemplateCategory.holiday,
    layout: TemplateLayout.centered,
    colorScheme: TemplateColorScheme.forest,
  ),
  InvitationTemplate(
    id: 'holiday_winter',
    name: 'Winter Wonderland',
    description: 'Cool tones for winter holiday events',
    category: TemplateCategory.holiday,
    layout: TemplateLayout.fullImage,
    colorScheme: TemplateColorScheme.soft,
  ),
];
