import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//Imagen
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//_ImagenState
class _MyHomePageState extends State<MyHomePage> {

  //File ? myhomepage = null;
  var myhomepage = File('');
  final picker = ImagePicker();

  Future setImagen(op) async{
    var pickedFile;

    
    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickedFile != null){
        //myhomepage = File(pickedFile.path);
        cortar(File(pickedFile.path));

      }else{
        //print('chale');
      }
    });
    Navigator.of(context).pop();
  }


  cortar(picked) async{
    File? cortado = await ImageCropper.cropImage(
      sourcePath: picked.path
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if(cortado != null){
      setState(() {
        myhomepage = cortado;
      });
    }
  }

  Dio dio = new Dio();

  Future<void> subir_imagen() async{
    try{
      
      //String filename = myhomepage!.path.split('/').last;

      FormData formData = new FormData.fromMap({
        
        'image': await MultipartFile.fromFile(
          myhomepage.path, //filename: filename
        )
      });

      await dio.post('http://34.72.145.97/dataMqtt/register_image',
      data: formData).then((value){
        if(value.toString() == '1'){
          print('Chale');
        }else{
          print('Foto Enviada');
        }
      });
    
    }catch(e){
      print(e.toString());
    }
  }

  opciones(context){
    showDialog(
      context: context, 
      builder: (BuildContext){
        return  AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    setImagen(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width:1, color: Colors.grey))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Tomar foto', style: TextStyle(
                            fontSize: 16
                          ),),
                        ),
                                                  Icon(Icons.camera_alt, color: Colors.blue)

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setImagen(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width:1, color: Colors.grey))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Seleccionar una foto', style: TextStyle(
                            fontSize: 16
                          ),),
                        ),
                                Icon(Icons.image, color: Colors.blue)

                      ],
                    ),
                  ),
                ),


                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Cancelar', style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),),
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione una imagen de una planta'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    opciones(context);
                  }, 
                  child: Text('Selecciona una Imagen'),
                ),
                SizedBox(height:30,),
                
                ElevatedButton(
                  onPressed: subir_imagen, 
                  child: Text('Subir una Imagen'),
                ),
                SizedBox(height:30,),
                myhomepage == null ? Center() : Image.file(myhomepage)
              ],
            )
          )
        ],
      ),
    );
  }


}

