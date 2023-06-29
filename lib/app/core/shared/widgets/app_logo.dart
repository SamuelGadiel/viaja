import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final bool showSubtitle;

  const AppLogo({required this.showSubtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo3.png',
              height: 96,
              width: 96,
            ),
            Text(
              'Viajá',
              style: GoogleFonts.kaushanScript(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 64,
              ),
            ),
          ],
        ),
        Visibility(
          visible: showSubtitle,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'descobrindo aventuras',
              style: GoogleFonts.courgette(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        )
      ],
    );
  }
}
