class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺s", "English", 'en'),
      LanguageData("us", "ዐማርኛ", "am"),
    ];
  }
}
