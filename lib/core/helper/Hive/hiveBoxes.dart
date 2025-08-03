class HiveBoxes {
  // Theme-related keys
  static Theme theme = Theme();

  // Locale and Language-related keys
  static Localization locale = Localization();

  static Categories categories = Categories();
}

class Theme {
  String box = 'ThemeBox';
  String isDarkKey = 'isDark';
}

class Localization {
  String box = 'LocaleBox';
  String languageCodeKey = 'languageCode';
}

class Categories{
  String box = 'CategoriesBox';
  String categoriesKey = 'CategoriesList';
}