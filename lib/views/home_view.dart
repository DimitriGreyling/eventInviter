import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../router/app_router.dart';

/// Modern minimal home page for Event Inviter
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.celebration_outlined,
                          color: theme.colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Event Inviter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        _showLoginDialog(context);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Hero Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '✨ Simple. Beautiful. Professional.',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Event Planning\nMade Effortless',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Create stunning invitations, share instantly via URL,\nand track RSVPs in real-time. Everything you need\nfor seamless event management.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showRegisterDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 18,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Get Started Free',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () => context.push(AppRoutes.detail),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 18,
                            ),
                            side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'View Demo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Features Section
              Container(
                width: double.infinity,
                color: Colors.grey[50],
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Everything You Need',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Powerful features designed for modern event planning',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        _FeatureCard(
                          icon: Icons.edit_note_outlined,
                          title: 'Easy Creation',
                          description: 'Design beautiful invitations with our intuitive interface',
                        ),
                        _FeatureCard(
                          icon: Icons.link,
                          title: 'Instant Sharing',
                          description: 'Share via URL, email, or social media instantly',
                        ),
                        _FeatureCard(
                          icon: Icons.analytics_outlined,
                          title: 'Real-time Tracking',
                          description: 'Monitor RSVPs and guest responses as they happen',
                        ),
                        _FeatureCard(
                          icon: Icons.devices_outlined,
                          title: 'Mobile First',
                          description: 'Perfect experience on any device, anywhere',
                        ),
                        _FeatureCard(
                          icon: Icons.security_outlined,
                          title: 'Secure & Private',
                          description: 'Your data is protected with industry-standard security',
                        ),
                        _FeatureCard(
                          icon: Icons.speed_outlined,
                          title: 'Lightning Fast',
                          description: 'Create and send invitations in under 2 minutes',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // How It Works Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                child: Column(
                  children: [
                    const Text(
                      'How It Works',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 60),
                    const _StepItem(
                      number: '1',
                      title: 'Create Your Event',
                      description: 'Fill in event details, date, and location',
                    ),
                    const SizedBox(height: 40),
                    const _StepItem(
                      number: '2',
                      title: 'Share Invitation',
                      description: 'Get a unique URL to share with your guests',
                    ),
                    const SizedBox(height: 40),
                    const _StepItem(
                      number: '3',
                      title: 'Track Responses',
                      description: 'Watch RSVPs come in and manage your guest list',
                    ),
                  ],
                ),
              ),

              // CTA Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Ready to Get Started?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Join thousands creating memorable events',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        _showRegisterDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 20,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Create Free Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  '© 2025 Event Inviter. Perfect for birthdays, weddings, corporate events & more.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration coming soon!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login coming soon!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

/// Minimal feature card widget
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Step item widget for how it works section
class _StepItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _StepItem({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

