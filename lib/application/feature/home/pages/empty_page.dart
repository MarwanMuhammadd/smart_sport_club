import 'package:flutter/material.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/widgets/events_empty_state.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: EventsEmptyState(
                message: 'Services are not available',
                message1: 'Not available right now',
                message2: 'Coming soon',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
