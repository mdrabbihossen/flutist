import 'package:flutist/utils/colors.dart';
import 'package:flutist/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgDarkColor,
        leading: const Icon(
          Icons.sort_rounded,
          color: AppColors.whiteColor,
        ),
        title: Text(
          "Flutist",
          style: AppStyles.textStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: AppColors.bgColor,
                leading: const Icon(
                  Icons.music_note,
                  color: AppColors.whiteColor,
                  size: 32,
                ),
                title: Text(
                  "Music Name",
                  style: AppStyles.textStyle(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  "Artist Name",
                  style: AppStyles.textStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: const Icon(
                  Icons.play_arrow,
                  color: AppColors.whiteColor,
                  size: 26,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
