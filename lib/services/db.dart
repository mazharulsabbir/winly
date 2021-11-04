import 'package:get_storage/get_storage.dart';
import 'package:winly/globals/configs/constans.dart';

final _box = GetStorage();

class ThemeServiceDB {
  static getDarkModeValue() => _box.read<bool>(Keys.darkModeKey) ?? false;
  static setDarkModeValue(bool v) => _box.write(Keys.darkModeKey, v);
}
