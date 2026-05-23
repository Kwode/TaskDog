import 'package:flutter/material.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({super.key, required this.icon, required this.text, required this.subtitle,  required this.onTap, required this.isSelected});

  final IconData icon;
  final String text;
  final String subtitle;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.grey : Color.fromRGBO(30, 58, 138, 1.0),
            width: isSelected ? 3 : 1
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //icon
              Icon(icon, color: Color.fromRGBO(30, 58, 138, 1.0), size: 45,),
              //title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(30, 58, 138, 1.0),
                      )),
                  //subtitle
                  Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600]
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
