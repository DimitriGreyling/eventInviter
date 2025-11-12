import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../models/event_model.dart';
import '../providers/template_provider.dart';
import '../widgets/invitation_renderer.dart';

/// Enhanced customization view with carousel, image picker, and style customization
class EnhancedCustomizationView extends ConsumerStatefulWidget {
  final String initialTemplateId;

  const EnhancedCustomizationView({
    super.key,
    required this.initialTemplateId,
  });

  @override
  ConsumerState<EnhancedCustomizationView> createState() =>
      _EnhancedCustomizationViewState();
}

class _EnhancedCustomizationViewState
    extends ConsumerState<EnhancedCustomizationView> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _hostNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  // Customization state
  String? _selectedImagePath;
  Color? _customPrimaryColor;
  Color? _customAccentColor;
  Color? _customBackgroundColor;
  
  // Current selected template
  late String _selectedTemplateId;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    _selectedTemplateId = widget.initialTemplateId;
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _hostNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
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
        _dateController.text = '${picked.month}/${picked.day}/${picked.year}';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invitation created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/');
    }
  }

  EventModel _buildEventModel() {
    // Always return an EventModel for preview, use defaults if fields are empty
    return EventModel(
      id: 'preview',
      name: _eventNameController.text.isEmpty 
          ? 'Event Name' 
          : _eventNameController.text,
      hostName: _hostNameController.text.isEmpty 
          ? 'Host Name' 
          : _hostNameController.text,
      description: _descriptionController.text,
      date: _selectedDate ?? DateTime.now().add(const Duration(days: 7)),
      time: _timeController.text.isEmpty 
          ? '7:00 PM' 
          : _timeController.text,
      location: _locationController.text.isEmpty 
          ? 'Event Location' 
          : _locationController.text,
      templateId: _selectedTemplateId,
      createdAt: DateTime.now(),
      customization: InvitationCustomization(
        backgroundImagePath: _selectedImagePath,
        customPrimaryColor: _customPrimaryColor,
        customAccentColor: _customAccentColor,
        customBackgroundColor: _customBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final templates = ref.watch(templateProvider);
    final currentTemplate = ref.watch(templateByIdProvider(_selectedTemplateId));
    final theme = Theme.of(context);

    if (currentTemplate == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Template Not Found')),
        body: const Center(child: Text('Template not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Customize Your Invitation'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Form and Customization
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
                      // Template Carousel
                      const Text(
                        'Choose Template',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedTemplateId = templates[index].id;
                            });
                          },
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            final template = templates[index];
                            final isSelected = template.id == _selectedTemplateId;
                            return AnimatedScale(
                              scale: isSelected ? 1.0 : 0.9,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : Colors.grey[300]!,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: theme.colorScheme.primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          )
                                        ]
                                      : null,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Stack(
                                    children: [
                                      InvitationRenderer(
                                        template: template,
                                        isPreview: true,
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            template.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Customization Options
                      _buildCustomizationSection(theme),
                      const SizedBox(height: 32),

                      // Event Details Form
                      const Text(
                        'Event Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildEventForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Right Panel - Live Preview
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Live Preview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_selectedImagePath != null || 
                          _customPrimaryColor != null ||
                          _customAccentColor != null ||
                          _customBackgroundColor != null)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedImagePath = null;
                              _customPrimaryColor = null;
                              _customAccentColor = null;
                              _customBackgroundColor = null;
                            });
                          },
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text('Reset Style'),
                        ),
                    ],
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
                          child: InvitationRenderer(
                            key: ValueKey('${_selectedTemplateId}_${_eventNameController.text}_${_customPrimaryColor}_${_customAccentColor}_${_selectedImagePath}'),
                            template: currentTemplate,
                            event: _buildEventModel(),
                            isPreview: false,
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

  Widget _buildCustomizationSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customize Style',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        
        // Background Image
        Card(
          child: ListTile(
            leading: Icon(
              Icons.image,
              color: theme.colorScheme.primary,
            ),
            title: const Text('Background Image'),
            subtitle: Text(
              _selectedImagePath == null ? 'No image selected' : 'Image selected',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedImagePath != null)
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => setState(() => _selectedImagePath = null),
                  ),
                IconButton(
                  icon: const Icon(Icons.add_photo_alternate),
                  onPressed: _pickImage,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Color Customization
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Colors',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildColorOption(
                  'Primary Color',
                  _customPrimaryColor,
                  (color) => setState(() => _customPrimaryColor = color),
                ),
                const SizedBox(height: 8),
                _buildColorOption(
                  'Accent Color',
                  _customAccentColor,
                  (color) => setState(() => _customAccentColor = color),
                ),
                const SizedBox(height: 8),
                _buildColorOption(
                  'Background Color',
                  _customBackgroundColor,
                  (color) => setState(() => _customBackgroundColor = color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(
    String label,
    Color? currentColor,
    Function(Color?) onColorSelected,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 13)),
        ),
        GestureDetector(
          onTap: () async {
            Color? selectedColor = await _showColorPickerDialog(
              currentColor ?? Colors.blue,
            );
            if (selectedColor != null) {
              onColorSelected(selectedColor);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: currentColor ?? Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[400]!),
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (currentColor != null)
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => onColorSelected(null),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Future<Color?> _showColorPickerDialog(Color initialColor) async {
    Color selectedColor = initialColor;
    
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: selectedColor,
              onColorChanged: (Color color) {
                selectedColor = color;
              },
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
                ColorPickerType.primary: true,
                ColorPickerType.accent: false,
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(selectedColor),
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventForm() {
    return Column(
      children: [
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
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter event name' : null,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _hostNameController,
          decoration: InputDecoration(
            labelText: 'Hosted By *',
            hintText: 'Your name',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter host name' : null,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date *',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Select date' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time *',
                  prefixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Select time' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            labelText: 'Location *',
            hintText: 'Event venue',
            prefixIcon: const Icon(Icons.location_on),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter location' : null,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Description (Optional)',
            hintText: 'Additional details',
            prefixIcon: const Icon(Icons.description),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 24),
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
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _createInvitation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customization Guide'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '📋 Templates',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Swipe through the carousel to choose different templates.'),
              SizedBox(height: 12),
              Text(
                '🎨 Colors',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Tap color boxes to customize primary, accent, and background colors.'),
              SizedBox(height: 12),
              Text(
                '🖼️ Background',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Add a background image for a personalized touch.'),
              SizedBox(height: 12),
              Text(
                '👁️ Preview',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('See real-time changes on the right side as you customize.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
