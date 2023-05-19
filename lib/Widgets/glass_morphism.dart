import 'dart:ui';

import 'package:flutter/material.dart';

 glassMorphism(BuildContext context,{required Widget child}) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.transparent),
        height: MediaQuery.of(context).size.height*0.09,
        width: MediaQuery.of(context).size.width*0.7,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05)
                      ])),
            ),
            Center(child: child,)
          ],
        ),
      ),
    );
  }

