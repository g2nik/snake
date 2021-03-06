import 'package:shared_preferences/shared_preferences.dart';


//This class allows to set preferences, variables accesible from every screen of the app
class Preferences {

  static Future<bool> getFirstTime() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      return _prefs.getBool("firstTime");
    } catch (e) {
      print("Error getting first time");
    }
    return true;
  }

  static Future setFirstTime(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool("firstTime", value);
  }

  static Future<int> getRows() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("rows");
  }

  static Future setRows(int value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setInt("rows", value);
  }

  static Future<int> getColumns() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("columns");
  }

  static Future setColumns(int value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setInt("columns", value);
  }

  static Future<int> getSpeed() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("speed");
  }

  static Future setSpeed(int value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setInt("speed", value);
  }

  static Future<int> getHighScore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("highScore");
  }

  static Future setHighScore(int value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setInt("highScore", value);
  }

  static Future<bool> getSwipe() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("swipe");
  }

  static Future setSwipe(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool("swipe", value);
  }

  static Future<String> getCurrentBodyUnlockable() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("currentBody");
  }

  static Future setCurrentBodyUnlockable(String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString("currentBody", value);
  }

  static Future<String> getCurrentHeadUnlockable() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("currentHead");
  }

  static Future setCurrentHeadUnlockable(String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString("currentHead", value);
  }

  static Future<List<dynamic>> getAllPreferences() async {
    List<dynamic> preferences = [];
    preferences.add(await getRows());
    preferences.add(await getColumns());
    preferences.add(await getSpeed());
    preferences.add(await getHighScore());
    preferences.add(await getCurrentBodyUnlockable());
    preferences.add(await getCurrentHeadUnlockable());
    preferences.add(await getSwipe());
    return preferences;
  }

  static Future<List<dynamic>> getUnlockables() async {
    List<dynamic> unlockables = [];
    unlockables.add(await getHighScore());
    unlockables.add(await getCurrentBodyUnlockable());
    unlockables.add(await getCurrentHeadUnlockable());
    return unlockables;
  }

  static Future<bool> setDefaultPreferences() async {
    print("Setting default preferences");
    await setFirstTime(false);
    await setRows(18);
    await setColumns(10);
    await setSpeed(500);
    await setHighScore(0);
    await setSwipe(true);
    await setCurrentBodyUnlockable("none");
    await setCurrentHeadUnlockable("none");
    return true;
  }
}
