import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/invitation_template.dart';
import '../providers/template_provider.dart';

/// View for customizing a selected template with event details
class TemplateCustomizationView extends ConsumerStatefulWidget {
  final String templateId;

  const TemplateCustomizationView({
    super.key,
    required this.templateId,
  });

  @override
  ConsumerState<TemplateCustomizationView> createState() =>
      _TemplateCustomizationViewState();
}

class _TemplateCustomizationViewState
    extends ConsumerState<TemplateCustomizationView> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _hostNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _eventNameController.dispose();
    _hostNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${picked.month}/${picked.day}/${picked.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _createInvitation() {
    if (_formKey.currentState!.validate()) {
      // TODO: Create event with template and details
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invitation created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final template = ref.watch(templateByIdProvider(widget.templateId));

    if (template == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Template Not Found')),
        body: const Center(
          child: Text('Template not found'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Customize ${template.name}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Form Section (Left)
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in your event information',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Event Name
                      TextFormField(
                        controller: _eventNameController,
                        decoration: InputDecoration(
                          labelText: 'Event Name *',
                          hintText: 'e.g., Sarah\'s Birthday Party',
                          prefixIcon: const Icon(Icons.event),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter event name';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),

                      // Host Name
                      TextFormField(
                        controller: _hostNameController,
                        decoration: InputDecoration(
                          labelText: 'Hosted By *',
                          hintText: 'Your name or organization',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter host name';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),

                      // Date
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date *',
                          hintText: 'Select date',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Time
                      TextFormField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          labelText: 'Time *',
                          hintText: 'Select time',
                          prefixIcon: const Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectTime(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a time';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Location
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Location *',
                          hintText: 'Event venue or address',
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter location';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (Optional)',
                          hintText: 'Additional event details',
                          prefixIcon: const Icon(Icons.description),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => context.pop(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(color: Colors.grey[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Back to Templates'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _createInvitation,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Create Invitation'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Preview Section (Right)
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Preview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: template.colorScheme.background,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(32),
                            child: _buildPreview(template),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(InvitationTemplate template) {
    switch (template.layout) {
      case TemplateLayout.centered:
        return _buildCenteredLayout(template);
      case TemplateLayout.leftAligned:
        return _buildLeftAlignedLayout(template);
      case TemplateLayout.card:
        return _buildCardLayout(template);
      case TemplateLayout.fullImage:
        return _buildFullImageLayout(template);
      case TemplateLayout.split:
        return _buildSplitLayout(template);
    }
  }

  Widget _buildCenteredLayout(InvitationTemplate template) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          template.category.icon,
          size: 64,
          color: template.colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          _eventNameController.text.isEmpty
              ? 'Your Event Name'
              : _eventNameController.text,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: template.colorScheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: template.colorScheme.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Hosted by ${_hostNameController.text.isEmpty ? "Your Name" : _hostNameController.text}',
          style: TextStyle(
            fontSize: 18,
            color: template.colorScheme.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        _buildEventDetails(template),
      ],
    );
  }

  Widget _buildLeftAlignedLayout(InvitationTemplate template) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              template.category.icon,
              size: 48,
              color: template.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _eventNameController.text.isEmpty
                    ? 'Your Event Name'
                    : _eventNameController.text,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: template.colorScheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 3,
          color: template.colorScheme.accent,
        ),
        const SizedBox(height: 24),
        Text(
          'Hosted by ${_hostNameController.text.isEmpty ? "Your Name" : _hostNameController.text}',
          style: TextStyle(
            fontSize: 16,
            color: template.colorScheme.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        _buildEventDetails(template),
      ],
    );
  }

  Widget _buildCardLayout(InvitationTemplate template) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: template.colorScheme.primary.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: _buildCenteredLayout(template),
    );
  }

  Widget _buildFullImageLayout(InvitationTemplate template) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            template.colorScheme.primary,
            template.colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            template.category.icon,
            size: 64,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Text(
            _eventNameController.text.isEmpty
                ? 'Your Event Name'
                : _eventNameController.text,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Hosted by ${_hostNameController.text.isEmpty ? "Your Name" : _hostNameController.text}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 32),
          _buildEventDetails(template, useWhiteText: true),
        ],
      ),
    );
  }

  Widget _buildSplitLayout(InvitationTemplate template) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: template.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Icon(
                template.category.icon,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _eventNameController.text.isEmpty
                      ? 'Your Event Name'
                      : _eventNameController.text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: template.colorScheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hosted by ${_hostNameController.text.isEmpty ? "Your Name" : _hostNameController.text}',
                  style: TextStyle(
                    fontSize: 14,
                    color: template.colorScheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                _buildEventDetails(template),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventDetails(InvitationTemplate template,
      {bool useWhiteText = false}) {
    final textColor = useWhiteText ? Colors.white : template.colorScheme.textPrimary;
    final iconColor = useWhiteText ? Colors.white70 : template.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_dateController.text.isNotEmpty)
          _DetailRow(
            icon: Icons.calendar_today,
            text: _dateController.text,
            iconColor: iconColor,
            textColor: textColor,
          ),
        if (_timeController.text.isNotEmpty) ...[
          const SizedBox(height: 12),
          _DetailRow(
            icon: Icons.access_time,
            text: _timeController.text,
            iconColor: iconColor,
            textColor: textColor,
          ),
        ],
        if (_locationController.text.isNotEmpty) ...[
          const SizedBox(height: 12),
          _DetailRow(
            icon: Icons.location_on,
            text: _locationController.text,
            iconColor: iconColor,
            textColor: textColor,
          ),
        ],
        if (_descriptionController.text.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            _descriptionController.text,
            style: TextStyle(
              fontSize: 14,
              color: useWhiteText ? Colors.white70 : template.colorScheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;

  const _DetailRow({
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
