import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard(
   
     {super.key,
     required this.color,
    required this.title, 
    required  this.onTap,
    
     });

  final Color color;
  final String title;
final  Function() onTap;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: new InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
               children: <Widget>[
                
               Center(
                 child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.5,
                      ),
                    ),
               ),
                              Text(
                  '02/08/2020',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w100,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

final email = TextField(
  autofocus: false,
  style: const TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
  decoration: InputDecoration(
    filled: true,
    suffixIcon: const Icon(Icons.search),
    fillColor: Colors.white,
    hintText: 'Search the file by name or type.',
    contentPadding: const EdgeInsets.all(15),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(25.7),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(25.7),
    ),
  ),
);