import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //****************************************************************************
      // the app bar at the top
      appBar: AppBar(
        // the color of the bar
        backgroundColor: Colors.green.shade200,
        // the leading Icon ( menu )
        leading: IconButton(
          icon: Icon(Icons.menu) ,
          onPressed: () {
            // display a material banner
            ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                    content: Text("Menu"),
                    actions: [IconButton(onPressed: (){
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                        icon: Icon(Icons.close_outlined , color: Colors.teal,))],
                ),
            );// scaffold messenger of material banner
          }, // onPressed for the menu icon button
        ),
        //---------------------------
        //title of the page
        title: Text('Home page' ,
                style: GoogleFonts.poppins(),
        ),
        //---------------------------
        // action icons (on the right)
        actions: <Widget> [
          // search icon
          IconButton(onPressed: () {}, // $%#$%#$%@@%#$%#@#$ do i do a snack bar here ??
              icon: Icon(Icons.search_rounded)
          ),
        ],
        //----------------------------
        // bottom of the app bar
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(15.0),
            child: Container(
              color: Colors.green.shade200,
              height: 15.0,
              width: double.infinity,
            ),
        ),
        //----------------------------
      ),
      //*********************************************************************************
      // body of the page
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
            Image( image:
            AssetImage("assets/images/logoMod.jpg")),
                Text("Balance:")
              ],
            ),
          ),

        ),
      ),
      //**********************************************************************************
    );
  } // Widget build
} // My home page class

