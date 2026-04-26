import 'package:assigmment_app/models/subject.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Subject subject;

  const DetailScreen({super.key, required this.subject});

  IconData _iconForSubject(String code) {
    if (code.startsWith('MAD')) return Icons.phone_android;
    if (code.startsWith('SRE')) return Icons.build_circle_outlined;
    return Icons.insights_outlined;
  }

  Color _colorForSubject(BuildContext context, String code) {
    if (code.startsWith('MAD')) return Colors.teal;
    if (code.startsWith('SRE')) return Colors.deepOrange;
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _colorForSubject(context, subject.code);

    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              subject.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                avatar: const Icon(Icons.book_outlined, size: 18),
                label: Text(subject.code),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: [
                    accentColor.withValues(alpha: 0.85),
                    accentColor.withValues(alpha: 0.55),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _iconForSubject(subject.code),
                      size: 52,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Subject Banner Placeholder',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(subject.description),
                    const SizedBox(height: 12),
                    Text(
                      'Objectives',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(subject.objectives),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schedule Details',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.schedule_outlined, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(subject.schedule)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
