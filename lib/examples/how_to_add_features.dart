// Example: How to add an Event feature to your app

// Step 1: Create Event Model (lib/models/event_model.dart)
/*
class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<String> invitedUsers;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.invitedUsers,
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    List<String>? invitedUsers,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      invitedUsers: invitedUsers ?? this.invitedUsers,
    );
  }
}
*/

// Step 2: Create Event ViewModel (lib/view_models/event_view_model.dart)
/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';

class EventViewModel extends StateNotifier<List<EventModel>> {
  EventViewModel() : super([]);

  void addEvent(EventModel event) {
    state = [...state, event];
  }

  void removeEvent(String eventId) {
    state = state.where((event) => event.id != eventId).toList();
  }

  void updateEvent(EventModel updatedEvent) {
    state = [
      for (final event in state)
        if (event.id == updatedEvent.id) updatedEvent else event
    ];
  }

  void inviteUser(String eventId, String userId) {
    state = [
      for (final event in state)
        if (event.id == eventId)
          event.copyWith(
            invitedUsers: [...event.invitedUsers, userId],
          )
        else
          event
    ];
  }
}

final eventViewModelProvider =
    StateNotifierProvider<EventViewModel, List<EventModel>>((ref) {
  return EventViewModel();
});
*/

// Step 3: Create Event List View (lib/views/event_list_view.dart)
/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/event_view_model.dart';
import '../router/app_router.dart';

class EventListView extends ConsumerWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: events.isEmpty
          ? const Center(
              child: Text('No events yet. Create your first event!'),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.description),
                    trailing: Text(
                      '${event.date.day}/${event.date.month}/${event.date.year}',
                    ),
                    onTap: () {
                      // Navigate to event detail
                      // context.push('/event/${event.id}');
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create event screen
          // context.push(AppRoutes.createEvent);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/

// Step 4: Add route in app_router.dart
/*
GoRoute(
  path: '/events',
  name: 'events',
  pageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const EventListView(),
  ),
),
GoRoute(
  path: '/event/:id',
  name: 'eventDetail',
  pageBuilder: (context, state) {
    final eventId = state.pathParameters['id']!;
    return MaterialPage(
      key: state.pageKey,
      child: EventDetailView(eventId: eventId),
    );
  },
),
*/

// Step 5: Navigate to events
/*
// From any view:
ElevatedButton(
  onPressed: () => context.push('/events'),
  child: const Text('View Events'),
)
*/

// This is just a template file showing how to extend the app.
// Remove this file once you understand the pattern!
void main() {
  print('This file is for reference only - see comments for examples');
}
