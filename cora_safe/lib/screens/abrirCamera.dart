import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

Future<void> abrirCamera() async {
  final XFile? image = await picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    print(image.path);
  }
}