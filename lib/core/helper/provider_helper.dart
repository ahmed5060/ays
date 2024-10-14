import 'package:courses_app/providers/auth_provider.dart';
import 'package:courses_app/providers/books_provider.dart';
import 'package:courses_app/providers/courses_provider.dart';
import 'package:courses_app/providers/quiz_provider.dart';
import 'package:courses_app/providers/testimonials_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../providers/chat_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/notes_provider.dart';
import '../../providers/notifications_provider.dart';
import '../../providers/training_quiz_provider.dart';
import '../../providers/videos_provider.dart';

class ProviderHelper {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider.value(
      value: NavigationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: AuthProvider(),
    ),
    ChangeNotifierProvider.value(
      value: QuizProvider(),
    ),
    ChangeNotifierProvider.value(
      value: CoursesProvider(),
    ),
    ChangeNotifierProvider.value(
      value: TestimonialsProvider(),
    ),
    ChangeNotifierProvider.value(
      value: NotificationsProvider(),
    ),
    ChangeNotifierProvider.value(
      value: BooksProvider(),
    ),
    ChangeNotifierProvider.value(
      value: VideosProvider(),
    ),
    ChangeNotifierProvider.value(
      value: NotesProvider(),
    ),
    ChangeNotifierProvider.value(
      value: TrainingQuizProvider(),
    ),
    ChangeNotifierProvider.value(
      value: ChatProvider(),
    ),
  ];
}
