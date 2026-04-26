import 'package:assigmment_app/controllers/auth_controller.dart';
import 'package:assigmment_app/controllers/subject_controller.dart';
import 'package:assigmment_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.currentUser;
    final subjects = SubjectController.instance.subjects;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: Center(
          child: FilledButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Go to Login'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await AuthController.instance.logout();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person, size: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Your Subjects',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: subjects.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Card(
                    child: ListTile(
                      title: Text(subject.name),
                      subtitle: Text(subject.code),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(subject: subject),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name: ${user.fullName}'),
                    const SizedBox(height: 8),
                    Text('Email: ${user.email}'),
                    const SizedBox(height: 8),
                    Text('Gender: ${user.gender.label}'),
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
