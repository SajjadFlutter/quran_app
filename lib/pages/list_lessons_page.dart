

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran_app/data/list_lessons_data.dart';
import 'package:quran_app/ui/colors.dart';
import 'package:quran_app/widgets/custom_lesson_tile.dart';

class ListLessonsPage extends StatelessWidget {
  const ListLessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.26,
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.share, color: primaryColor),
                    const SizedBox(width: 12.0),
                    Text(
                      'ارسال به دوستان',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.headset_mic_rounded, color: primaryColor),
                    const SizedBox(width: 12.0),
                    Text(
                      'پشتیبانی (سروش)',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: primaryColor,
                      size: 25.0,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'درباره ما',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text(
          'کتاب صوتی قرآن پنجم',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: 'پیامی در دسترس نیست!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey.shade700,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
          ),
          const ListLessonsWidget(),
          const ImageBookWidget(),
        ],
      ),
    );
  }
}

// List Lessons Widget
class ImageBookWidget extends StatelessWidget {
  const ImageBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: SizedBox(
          height: 155.0,
          child: Container(
            width: 118,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(0, 1.0),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/quran05.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// List Lessons Widget
class ListLessonsWidget extends StatelessWidget {
  const ListLessonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.74,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90.0, bottom: 15.0),
              child: Column(
                children: [
                  const Text(
                    'فهرست دروس',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 105.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return customLessonTile(context, index);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listLessons.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
