import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _rangeKey = 'selected_range';

  Future<void> saveSelectedRange(String range) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_rangeKey, range);
  }

  Future<String?> getSelectedRange() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rangeKey);
  }
}
