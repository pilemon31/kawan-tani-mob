import "package:flutter/material.dart";
import "package:flutter_kawan_tani/shared/theme.dart";
import "package:google_fonts/google_fonts.dart";

void showCustomToast(BuildContext context, String message) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.8,
      left: MediaQuery.of(context).size.width * 0.10,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: bold, color: whiteColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
