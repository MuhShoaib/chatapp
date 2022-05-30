import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageHandler extends GetxController {
  final box = GetStorage();

  setEmail(String email) {
    var result = box.write('email', email);

    print(result);
  }

  getEmail() {
    var result = box.read('email');

    return result;
  }

  removeEmail() {
    box.remove('email');
  }
}
