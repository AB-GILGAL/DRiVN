// import 'package:drivn_customer/utils/export.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AppImagePicker{
  ImageSource source;

  AppImagePicker({required this.source});

  pick({onPick})async{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if(image != null){
      onPick(File(image.path));
    }else{
      onPick(null);
    }
  }
}