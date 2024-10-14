class EndPoints {
  static const String baseUrl = "https://ays-academy.com/api";

  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  //
  static const String checkSection = "$baseUrl/sections/check?section_id=";
  static const String pdfsSection = "$baseUrl/content/pdfs?course_id=";
  static const String getAskOP = "$baseUrl/content/options?course_id=";
  static const String getAccessQ = "$baseUrl/ask/check?question_number=";
  static const String submitQAsk = "$baseUrl/ask";

  //
  static const String categories = "$baseUrl/categories";
  static const String getCourses = "$baseUrl/courses";
  static const String getTestimonials = "$baseUrl/testimonials";
  static const String getNotifications = "$baseUrl/notifications";
  static const String addTestimonials = "$getTestimonials/store";
  static const String updateTestimonials = "$getTestimonials/update";
  static const String getSections = "$baseUrl/sections";
  static const String getContent = "$baseUrl/content";
  static const String getBooksSections = "$getSections/books?course_id=";
  static const String getBooksSubSections = "$getSections/books?section_id=";
  static const String getBooksContent = "$getContent/books?section_id=";
  static const String getVideosSections = "$getSections/videos?course_id=";
  static const String getVideosSubSections = "$getSections/videos?section_id=";
  static const String getVideosContent = "$getContent/videos?section_id=";
  static const String getTrainingQuizzesSections =
      "$getSections/training?course_id=";
  static const String getTrainingQuizzesSubSections =
      "$getSections/training?section_id=";
  static const String getTrainingQuizzesContent =
      "$getContent/training?section_id=";
  static const String getTrainingQuizzesQuestions =
      "$getContent/training/questions?exam_id=";
  static const String getQuizzesSections = "$getSections/quizes?course_id=";
  static const String getQuizzesSubSections = "$getSections/quizes?section_id=";
  static const String getQuizzesContent = "$getContent/quizes?section_id=";
  static const String getQuizzesQuestions =
      "$getContent/quizes/questions?exam_id=";
  static const String notes = "$baseUrl/notes";
  static const String getNotes = "$notes?course_id=";
  static const String addNotes = "$notes/store";
  static const String updateNotes = "$notes/update";
  static const String mark = "$baseUrl/mark";
  static const String meeting = "$baseUrl/meeting?course_id=";
  static const String updateUser = "$baseUrl/user/update";
  static const String mainCategories = "$baseUrl/main-categories";
  static const String supCategories = "$baseUrl/sub-categories?cat_id=";
}
