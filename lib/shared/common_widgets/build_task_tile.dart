import 'package:flutter/material.dart';

class BuildTaskTile extends StatelessWidget {
  const BuildTaskTile(
      {Key? key,
      required this.color,
      required this.startTime,
      required this.title,
      required this.isCompleted})
      : super(key: key);
  final int color;
  final String startTime;
  final String title;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Color(
            color,
          ),
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    startTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  color: isCompleted
                      ? Colors.white
                      : Color(
                          color,
                        ),
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
