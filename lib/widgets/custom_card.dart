import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    required this.onClick,
    required this.iconData,
    required this.iconColor,
  });

  final String title;
  final String description;
  final Function onClick;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),

      child: InkWell(
        onTap: () =>  onClick(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(iconData, size: 28.0, color: iconColor),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.0,color: Colors.black54,),
            ],
          ),
        ),
      ),
    );
  }
}