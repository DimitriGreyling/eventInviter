import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Customization data for invitation appearance
@immutable
class InvitationCustomization {
  final String? backgroundImagePath;
  final List<String>? carouselImagePaths;  // Multiple images for carousel
  final Color? customPrimaryColor;
  final Color? customAccentColor;
  final Color? customBackgroundColor;
  final double? fontSize;
  final String? fontFamily;
  
  const InvitationCustomization({
    this.backgroundImagePath,
    this.carouselImagePaths,
    this.customPrimaryColor,
    this.customAccentColor,
    this.customBackgroundColor,
    this.fontSize,
    this.fontFamily,
  });

  InvitationCustomization copyWith({
    String? backgroundImagePath,
    List<String>? carouselImagePaths,
    Color? customPrimaryColor,
    Color? customAccentColor,
    Color? customBackgroundColor,
    double? fontSize,
    String? fontFamily,
  }) {
    return InvitationCustomization(
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
      carouselImagePaths: carouselImagePaths ?? this.carouselImagePaths,
      customPrimaryColor: customPrimaryColor ?? this.customPrimaryColor,
      customAccentColor: customAccentColor ?? this.customAccentColor,
      customBackgroundColor: customBackgroundColor ?? this.customBackgroundColor,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}

/// Event model with template support
@immutable
class EventModel {
  final String id;
  final String name;
  final String hostName;
  final String description;
  final DateTime date;
  final String time;
  final String location;
  final String templateId;
  final DateTime createdAt;
  final InvitationCustomization? customization;

  const EventModel({
    required this.id,
    required this.name,
    required this.hostName,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.templateId,
    required this.createdAt,
    this.customization,
  });

  EventModel copyWith({
    String? id,
    String? name,
    String? hostName,
    String? description,
    DateTime? date,
    String? time,
    String? location,
    String? templateId,
    DateTime? createdAt,
    InvitationCustomization? customization,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hostName: hostName ?? this.hostName,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      templateId: templateId ?? this.templateId,
      createdAt: createdAt ?? this.createdAt,
      customization: customization ?? this.customization,
    );
  }

  /// Formatted date string
  String get formattedDate {
    return '${date.month}/${date.day}/${date.year}';
  }

  /// Check if event is in the past
  bool get isPast {
    return date.isBefore(DateTime.now());
  }

  /// Check if event is today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
