import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
final ImagePicker picker = ImagePicker();

Future<void> abrirCamera() async {
  final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

  if (imagem != null) {
    var uri = Uri.parse('http://192.168.0.7:8000/docs/uploadfile/');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imagem.path));
    var response = await request.send();

    if (response.statusCode == 200){
      print('Imagem enviada para a API');
    }


    print(imagem.path);
  }
}