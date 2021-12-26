import 'package:flutter/material.dart';

class Imagen extends StatefulWidget {
  @override
  _ImagenState createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  
  
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
                  onPressed: (){}, 
                  child: Text('Selecciona'),
                ),
                SizedBox(height:30,),
                Center()
              ],
            )
          )
        ],
      ),
    );
  }


}