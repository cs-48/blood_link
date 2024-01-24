import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        shadowColor: Colors.black,
        title: Center(
          child: Text(
            'Blood Link',
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
        ),
      ),
      body: Container(
        width: 430,
        height: 302,
        child: Stack(
          children: [
            // Positioned(
            //   left: 0,
            //   top: 0,
            //   child: Container(
            //     width: 430,
            //     height: 302,
            //     decoration: ShapeDecoration(
            //       color: Colors.white.withOpacity(0.38999998569488525),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 430,
                height: 138,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://www.xpressmedical.net/wp-content/uploads/2023/11/DONATE-BLOOD-560x315-1920w.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   left: 172,
            //   top: 275,
            //   child: Container(
            //     width: 94,
            //     height: 27,
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: NetworkImage(""),
            //         fit: BoxFit.contain,
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Color(0x3F000000),
            //           blurRadius: 4,
            //           offset: Offset(0, 4),
            //           spreadRadius: 0,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
