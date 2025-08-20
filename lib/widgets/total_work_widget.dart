import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

Widget showAbout({
  required String num,
  required String title,
  required String subTitle,
  required String symbol,
}) {
  return Container(
    padding: EdgeInsets.all(1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              num,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: WebColors.textColor,
              ),
            ),
            SizedBox(width: 6,),
            Text(
              symbol,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color:WebColors.buttonColor,
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(197, 255, 255, 255),
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(197, 255, 255, 255),
          ),
        ),
      ],
    ),
  );
}
