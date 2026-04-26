import 'package:assigmment_app/models/subject.dart';

class SubjectController {
  SubjectController._();

  static final SubjectController instance = SubjectController._();

  final List<Subject> subjects = const [
    Subject(
      name: 'Mobile App Development',
      code: 'MAD301',
      description:
          'Focuses on building and deploying cross-platform mobile applications using modern frameworks.',
      objectives:
          'Design intuitive mobile UIs, manage app state, integrate APIs, and publish production-ready apps.',
      schedule: 'Mon 10:00 AM - 12:00 PM | Lab: Wed 2:00 PM - 4:00 PM',
    ),
    Subject(
      name: 'Software Re-engineering',
      code: 'SRE302',
      description:
          'Covers legacy software modernization, reverse engineering, and architecture refactoring strategies.',
      objectives:
          'Analyze existing systems, recover design artifacts, and incrementally migrate to maintainable solutions.',
      schedule: 'Tue 1:00 PM - 3:00 PM | Tutorial: Thu 11:00 AM - 12:00 PM',
    ),
    Subject(
      name: 'MIS',
      code: 'MIS303',
      description:
          'Introduces management information systems for data-driven planning and enterprise decision support.',
      objectives:
          'Model business processes, evaluate information flows, and apply MIS tools for organizational insights.',
      schedule: 'Fri 9:00 AM - 11:00 AM | Seminar: Fri 11:15 AM - 12:00 PM',
    ),
  ];
}
