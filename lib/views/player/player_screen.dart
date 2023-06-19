import 'package:flutist/utils/colors.dart';
import 'package:flutist/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PlayerScreen extends StatelessWidget {
  final String musicName;
  final String artistName;

  const PlayerScreen({
    Key? key,
    required this.musicName,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    )),
                child: Column(
                  children: [
                    Text(
                      "musicName",
                      style: AppStyles.textStyle(
                        color: AppColors.bgDarkColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      artistName,
                      style: AppStyles.textStyle(
                        color: AppColors.bgDarkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '0.0',
                          style: AppStyles.textStyle(
                            color: AppColors.bgDarkColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            thumbColor: AppColors.sliderColor,
                            activeColor: AppColors.sliderColor,
                            inactiveColor: AppColors.bgColor,
                            value: 0.0,
                            onChanged: (value) {},
                          ),
                        ),
                        Text(
                          '04.00',
                          style: AppStyles.textStyle(
                            color: AppColors.bgDarkColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: AppColors.bgDarkColor,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.bgColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: AppColors.bgDarkColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
