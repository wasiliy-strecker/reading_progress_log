import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:strick_haekelbuch/core/files/photo_capture_factory_native.dart';

void main() {
  test('Android image picker is configured to use the photo picker', () {
    final implementation = ImagePickerAndroid();

    configureAndroidPhotoPicker(implementation);

    expect(implementation.useAndroidPhotoPicker, isTrue);
  });
}
