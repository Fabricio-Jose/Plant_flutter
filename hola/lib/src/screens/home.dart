//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState(); 
}

class _HomeScreenState extends State<HomeScreen>{
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usando camra flutter'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _optionsDialogBox,
        ),
    );
  }

  void _openCamera() async {
    PickedFile picture = await imagePicker.getImage(source: ImageSource.camera);
  }

  void _openGallery() async {
    PickedFile picture = await imagePicker.getImage(source: ImageSource.gallery);
  }


  Future<void> _optionsDialogBox(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Tomar fotografia'),
                  onTap: _openCamera,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('abrir galeria'),
                  onTap: _openGallery,
                )//
              ],
            ),
          ),
        );
      }
    );
  }

}