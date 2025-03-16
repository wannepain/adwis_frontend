import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<UserButton> createState() => _UserButtonState();
}

class _UserButtonState extends ConsumerState<UserButton> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    return IconButton(
        onPressed: () {
          // AuthService().singInGoogle();
          //navigato login page
          Navigator.pushNamed(context, "/auth");
        },
        icon: userData["photoURL"] != null && userData["photoURL"] != ""
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(8, 7, 5, 1),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userData["photoURL"],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Icon(
                Icons.account_circle,
                size: 48,
                color: Color.fromRGBO(8, 7, 5, 1),
                shadows: [
                  Shadow(
                    color: Color.fromRGBO(8, 7, 5, 1),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  )
                ],
              ));
  }
}
