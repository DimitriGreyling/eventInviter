import 'package:flutter/material.dart';
import 'dart:io';
import '../models/invitation_template.dart';
import '../models/event_model.dart';

/// Reusable widget that renders an invitation based on template and event data
class InvitationRenderer extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final double? width;
  final double? height;
  final bool isPreview;

  const InvitationRenderer({
    super.key,
    required this.template,
    this.event,
    this.width,
    this.height,
    this.isPreview = false,
  });

  // Get effective color scheme (template colors or customized colors)
  TemplateColorScheme get _effectiveColorScheme {
    final customization = event?.customization;
    if (customization == null) return template.colorScheme;
    
    return TemplateColorScheme(
      primary: customization.customPrimaryColor ?? template.colorScheme.primary,
      secondary: template.colorScheme.secondary,
      background: customization.customBackgroundColor ?? template.colorScheme.background,
      textPrimary: template.colorScheme.textPrimary,
      textSecondary: template.colorScheme.textSecondary,
      accent: customization.customAccentColor ?? template.colorScheme.accent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage = event?.customization?.backgroundImagePath;
    final colorScheme = _effectiveColorScheme;
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.background,
        image: backgroundImage != null
            ? DecorationImage(
                image: FileImage(File(backgroundImage)),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              )
            : null,
        borderRadius: BorderRadius.circular(isPreview ? 8 : 16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isPreview ? 8 : 16),
        child: _buildLayout(colorScheme),
      ),
    );
  }

  Widget _buildLayout(TemplateColorScheme colorScheme) {
    switch (template.layout) {
      case TemplateLayout.centered:
        return _CenteredLayout(
          template: template,
          event: event,
          isPreview: isPreview,
          colorScheme: colorScheme,
        );
      case TemplateLayout.leftAligned:
        return _LeftAlignedLayout(
          template: template,
          event: event,
          isPreview: isPreview,
          colorScheme: colorScheme,
        );
      case TemplateLayout.card:
        return _CardLayout(
          template: template,
          event: event,
          isPreview: isPreview,
          colorScheme: colorScheme,
        );
      case TemplateLayout.fullImage:
        return _FullImageLayout(
          template: template,
          event: event,
          isPreview: isPreview,
          colorScheme: colorScheme,
        );
      case TemplateLayout.split:
        return _SplitLayout(
          template: template,
          event: event,
          isPreview: isPreview,
          colorScheme: colorScheme,
        );
    }
  }
}

/// Centered layout - Classic centered design
class _CenteredLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;
  final TemplateColorScheme colorScheme;

  const _CenteredLayout({
    required this.template,
    required this.event,
    required this.isPreview,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Padding(
      padding: EdgeInsets.all(isPreview ? 16 : 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60 * scale,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.accent],
              ),
            ),
          ),
          SizedBox(height: 20 * scale),
          Icon(
            template.category.icon,
            size: 48 * scale,
            color: colorScheme.primary,
          ),
          SizedBox(height: 16 * scale),
          Text(
            event?.name ?? 'Event Name',
            style: TextStyle(
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              color: colorScheme.textPrimary,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12 * scale),
          Container(
            width: 80 * scale,
            height: 3,
            decoration: BoxDecoration(
              color: colorScheme.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Hosted by ${event?.hostName ?? "Host Name"}',
            style: TextStyle(
              fontSize: 16 * scale,
              color: colorScheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          if (!isPreview && event != null) ...[
            SizedBox(height: 24 * scale),
            _EventDetails(event: event!, scale: scale, colorScheme: colorScheme),
          ],
          SizedBox(height: 20 * scale),
          Container(
            width: 60 * scale,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.accent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Left aligned layout - Professional asymmetric design
class _LeftAlignedLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;
  final TemplateColorScheme colorScheme;

  const _LeftAlignedLayout({
    required this.template,
    required this.event,
    required this.isPreview,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Padding(
      padding: EdgeInsets.all(isPreview ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12 * scale),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  template.category.icon,
                  size: 32 * scale,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Text(
                  event?.name ?? 'Event Name',
                  style: TextStyle(
                    fontSize: 24 * scale,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Container(
            width: 100 * scale,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Hosted by ${event?.hostName ?? "Host Name"}',
            style: TextStyle(
              fontSize: 16 * scale,
              color: colorScheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (!isPreview && event != null) ...[
            SizedBox(height: 24 * scale),
            _EventDetails(event: event!, scale: scale, colorScheme: colorScheme),
          ],
        ],
      ),
    );
  }
}

/// Card layout - Elevated card with border
class _CardLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;
  final TemplateColorScheme colorScheme;

  const _CardLayout({
    required this.template,
    required this.event,
    required this.isPreview,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Container(
      margin: EdgeInsets.all(isPreview ? 8 : 16),
      padding: EdgeInsets.all(isPreview ? 16 : 32),
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border.all(
          color: colorScheme.accent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withOpacity(0.1),
            ),
            child: Icon(
              template.category.icon,
              size: 40 * scale,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(height: 20 * scale),
          Text(
            event?.name ?? 'Event Name',
            style: TextStyle(
              fontSize: 26 * scale,
              fontWeight: FontWeight.bold,
              color: colorScheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12 * scale),
          Text(
            'You\'re Invited!',
            style: TextStyle(
              fontSize: 18 * scale,
              color: colorScheme.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Hosted by ${event?.hostName ?? "Host Name"}',
            style: TextStyle(
              fontSize: 14 * scale,
              color: colorScheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (!isPreview && event != null) ...[
            SizedBox(height: 24 * scale),
            _EventDetails(event: event!, scale: scale, colorScheme: colorScheme),
          ],
        ],
      ),
    );
  }
}

/// Full image layout - Bold full-bleed design
class _FullImageLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;
  final TemplateColorScheme colorScheme;

  const _FullImageLayout({
    required this.template,
    required this.event,
    required this.isPreview,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.accent,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isPreview ? 16 : 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              template.category.icon,
              size: 60 * scale,
              color: Colors.white,
            ),
            SizedBox(height: 24 * scale),
            Text(
              event?.name ?? 'Event Name',
              style: TextStyle(
                fontSize: 32 * scale,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16 * scale),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 8 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Hosted by ${event?.hostName ?? "Host Name"}',
                style: TextStyle(
                  fontSize: 16 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (!isPreview && event != null) ...[
              SizedBox(height: 32 * scale),
              _EventDetails(
                event: event!,
                scale: scale,
                colorScheme: TemplateColorScheme(
                  primary: Colors.white,
                  secondary: Colors.white70,
                  background: Colors.transparent,
                  textPrimary: Colors.white,
                  textSecondary: Colors.white70,
                  accent: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Split layout - Divided design
class _SplitLayout extends StatelessWidget {
  final InvitationTemplate template;
  final EventModel? event;
  final bool isPreview;
  final TemplateColorScheme colorScheme;

  const _SplitLayout({
    required this.template,
    required this.event,
    required this.isPreview,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isPreview ? 0.4 : 1.0;
    
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: colorScheme.primary,
            padding: EdgeInsets.all(isPreview ? 16 : 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  template.category.icon,
                  size: 50 * scale,
                  color: Colors.white,
                ),
                SizedBox(height: 16 * scale),
                Text(
                  event?.name ?? 'Event Name',
                  style: TextStyle(
                    fontSize: 24 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: colorScheme.background,
            padding: EdgeInsets.all(isPreview ? 16 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You\'re Invited!',
                  style: TextStyle(
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.textPrimary,
                  ),
                ),
                SizedBox(height: 12 * scale),
                Text(
                  'Hosted by ${event?.hostName ?? "Host Name"}',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: colorScheme.textSecondary,
                  ),
                ),
                if (!isPreview && event != null) ...[
                  SizedBox(height: 24 * scale),
                  _EventDetails(event: event!, scale: scale, colorScheme: colorScheme),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Shared event details widget
class _EventDetails extends StatelessWidget {
  final EventModel event;
  final double scale;
  final TemplateColorScheme colorScheme;

  const _EventDetails({
    required this.event,
    required this.scale,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (event.description.isNotEmpty) ...[
          Text(
            event.description,
            style: TextStyle(
              fontSize: 14 * scale,
              color: colorScheme.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16 * scale),
        ],
        _DetailRow(
          icon: Icons.calendar_today,
          text: '${event.date.month}/${event.date.day}/${event.date.year}',
          scale: scale,
          colorScheme: colorScheme,
        ),
        SizedBox(height: 8 * scale),
        _DetailRow(
          icon: Icons.access_time,
          text: event.time,
          scale: scale,
          colorScheme: colorScheme,
        ),
        SizedBox(height: 8 * scale),
        _DetailRow(
          icon: Icons.location_on,
          text: event.location,
          scale: scale,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final double scale;
  final TemplateColorScheme colorScheme;

  const _DetailRow({
    required this.icon,
    required this.text,
    required this.scale,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16 * scale,
          color: colorScheme.accent,
        ),
        SizedBox(width: 8 * scale),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14 * scale,
              color: colorScheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
