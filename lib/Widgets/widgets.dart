import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget mytext(Color color, String text, FontWeight? weight) {
  return Text(
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    text,
    style: GoogleFonts.poppins(color: color, fontWeight: weight),
  );
}
