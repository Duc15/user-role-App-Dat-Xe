import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global_var.dart';
import 'package:users_app/pages/about_page.dart';
import 'package:users_app/pages/trips_history_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white10,
      child: ListView(
        children: [
          const Divider(
            height: 1,
            color: Colors.grey,
            thickness: 1,
          ),

          //header
          Container(
            color: Colors.white,
            height: 160,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/avatarman.png",
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Hồ sơ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Divider(
            height: 1,
            color: Colors.black,
            thickness: 1,
          ),

          const SizedBox(
            height: 10,
          ),

          //body
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => TripsHistoryPage()));
            },
            //lịh sử
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.history,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Lịch sử",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          //giới thiệu
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => AboutPage()));
            },
            //avatar
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Giới thiệu",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => LoginScreen()));
            },
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Đăng xuất",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
