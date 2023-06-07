import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_api_app/api/controller/auth_api_controller.dart';
import 'package:vp18_api_app/api/controller/users_api_controller.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/api/models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/images_screen"),
            icon: const Icon(Icons.image_sharp),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UsersApiController().fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(snapshot.data![index].image),
                  ),
                  title: Row(
                    children: [
                      Text(snapshot.data![index].firstName),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(snapshot.data![index].lastName),
                    ],
                  ),
                  subtitle: Text(snapshot.data![index].email),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "NO DATA",
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    ProcessResponse processResponse = await AuthApiController().logout();
    if (processResponse.success) {
      Navigator.pushReplacementNamed(context, "/login_screen");

    }
  }
}
