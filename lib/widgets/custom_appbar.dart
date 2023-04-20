import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/data/list_lessons_data.dart';
import 'package:quran_app/ui/colors.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final int index;
  final AudioPlayer audioPlayer;
  const CustomAppbar({
    super.key,
    required this.index,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 28.0, left: 20.0, bottom: 4.0),
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              await audioPlayer.stop();
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              listLessons[index]['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              const Text(
                'صفحه ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              Text(
                listLessons[index]['pageNumber'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
