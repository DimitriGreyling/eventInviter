import 'package:flutter/material.dart';

/// Categories for invitation templates
enum TemplateCategory {
  birthday,
  wedding,
  corporate,
  casual,
  formal,
  holiday;

  String get displayName {
    switch (this) {
      case TemplateCategory.birthday:
        return 'Birthday';
      case TemplateCategory.wedding:
        return 'Wedding';
      case TemplateCategory.corporate:
        return 'Corporate';
      case TemplateCategory.casual:
        return 'Casual';
      case TemplateCategory.formal:
        return 'Formal';
      case TemplateCategory.holiday:
        return 'Holiday';
    }
  }

  IconData get icon {
    switch (this) {
      case TemplateCategory.birthday:
        return Icons.cake;
      case TemplateCategory.wedding:
        return Icons.favorite;
      case TemplateCategory.corporate:
        return Icons.business;
      case TemplateCategory.casual:
        return Icons.celebration;
      case TemplateCategory.formal:
        return Icons.local_bar;
      case TemplateCategory.holiday:
        return Icons.card_giftcard;
    }
  }
}

/// Layout style for templates
enum TemplateLayout {
  centered,
  leftAligned,
  card,
  fullImage,
  split;

  String get displayName {
    switch (this) {
      case TemplateLayout.centered:
        return 'Centered';
      case TemplateLayout.leftAligned:
        return 'Left Aligned';
      case TemplateLayout.card:
        return 'Card Style';
      case TemplateLayout.fullImage:
        return 'Full Image';
      case TemplateLayout.split:
        return 'Split Layout';
    }
  }
}

/// Color scheme for templates
class TemplateColorScheme {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;

  const TemplateColorScheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
  });

  static const elegant = TemplateColorScheme(
    primary: Color(0xFF2C3E50),
    secondary: Color(0xFF34495E),
    background: Color(0xFFECF0F1),
    textPrimary: Color(0xFF2C3E50),
    textSecondary: Color(0xFF7F8C8D),
    accent: Color(0xFFE74C3C),
  );

  static const vibrant = TemplateColorScheme(
    primary: Color(0xFFE91E63),
    secondary: Color(0xFF9C27B0),
    background: Color(0xFFFCE4EC),
    textPrimary: Color(0xFF212121),
    textSecondary: Color(0xFF757575),
    accent: Color(0xFFFF5722),
  );

  static const soft = TemplateColorScheme(
    primary: Color(0xFF90CAF9),
    secondary: Color(0xFFBBDEFB),
    background: Color(0xFFF5F5F5),
    textPrimary: Color(0xFF263238),
    textSecondary: Color(0xFF607D8B),
    accent: Color(0xFF4FC3F7),
  );

  static const gold = TemplateColorScheme(
    primary: Color(0xFFFFD700),
    secondary: Color(0xFFFFA500),
    background: Color(0xFFFFFAF0),
    textPrimary: Color(0xFF3E2723),
    textSecondary: Color(0xFF795548),
    accent: Color(0xFFFF6F00),
  );

  static const forest = TemplateColorScheme(
    primary: Color(0xFF2E7D32),
    secondary: Color(0xFF388E3C),
    background: Color(0xFFF1F8E9),
    textPrimary: Color(0xFF1B5E20),
    textSecondary: Color(0xFF558B2F),
    accent: Color(0xFF66BB6A),
  );

  static const ocean = TemplateColorScheme(
    primary: Color(0xFF0277BD),
    secondary: Color(0xFF0288D1),
    background: Color(0xFFE1F5FE),
    textPrimary: Color(0xFF01579B),
    textSecondary: Color(0xFF0288D1),
    accent: Color(0xFF29B6F6),
  );
}

/// Invitation template model
class InvitationTemplate {
  final String id;
  final String name;
  final String description;
  final TemplateCategory category;
  final TemplateLayout layout;
  final TemplateColorScheme colorScheme;
  final bool isPremium;
  final String previewImage; // Asset path or URL

  const InvitationTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.layout,
    required this.colorScheme,
    this.isPremium = false,
    this.previewImage = '',
  });

  InvitationTemplate copyWith({
    String? id,
    String? name,
    String? description,
    TemplateCategory? category,
    TemplateLayout? layout,
    TemplateColorScheme? colorScheme,
    bool? isPremium,
    String? previewImage,
  }) {
    return InvitationTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      layout: layout ?? this.layout,
      colorScheme: colorScheme ?? this.colorScheme,
      isPremium: isPremium ?? this.isPremium,
      previewImage: previewImage ?? this.previewImage,
    );
  }
}
