import 'package:flutter/material.dart';
import 'package:quran_app/data/list_lessons_data.dart';
import 'package:quran_app/pages/lesson_page.dart';
import 'package:quran_app/ui/colors.dart';

Widget customLessonTile(BuildContext context, int index) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonPage(index: index),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Stack(
        children: [
          Row(
            children: [
              const Image(
                image: AssetImage('assets/images/quran-icon.png'),
                width: 45.0,
                color: primaryColor,
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listLessons[index]['title'],
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    listLessons[index]['subTitle'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'صفحه ',
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
                  ),
                  Text(
                    listLessons[index]['pageNumber'],
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
