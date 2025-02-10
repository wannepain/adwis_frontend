import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String imageUrl;
  const UserImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          padding: EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            child: ImageFiltered(
              imageFilter: ColorFilter.mode(
                Color.fromRGBO(252, 254, 255, 1),
                BlendMode.darken,
              ),
              child: Image.network(
                fit: BoxFit.cover,
                imageUrl,
                width: MediaQuery.sizeOf(context).width - 48,
                height: MediaQuery.sizeOf(context).width - 48,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
