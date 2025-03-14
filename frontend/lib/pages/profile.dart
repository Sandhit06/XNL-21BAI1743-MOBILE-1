import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve user details from Firebase
    final User? user = FirebaseAuth.instance.currentUser;
    final String displayName = user?.displayName ?? "User";
    final String email = user?.email ?? "No Email";

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // Implement navigation to the previous screen
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.teal, // Changed to Teal
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    buildProfileAvatar(user),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.teal),
                        onPressed: () {
                          // Implement profile picture change functionality
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Personal Information
              ProfileInfoField(
                label: 'Name',
                value: displayName,
                icon: Icons.person,
                onPressed: () {
                  // Implement name edit functionality
                },
              ),
              ProfileInfoField(
                label: 'Email',
                value: email,
                icon: Icons.email,
                onPressed: () {
                  // Implement email edit functionality
                },
              ),
              ProfileInfoField(
                label: 'Phone',
                value: '+1234567890',
                icon: Icons.phone,
                onPressed: () {
                  // Implement phone edit functionality
                },
              ),
              const SizedBox(height: 20),

              // Security Settings
              buildListTile(Icons.lock, "Security Settings"),
              buildListTile(Icons.pie_chart, "Financial Management"),
              buildListTile(Icons.support_agent, "Customer Support"),
              buildListTile(Icons.notifications, "Notification Settings"),

              const SizedBox(height: 20),

              // Logout Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  // Add navigation to login screen if needed
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a profile avatar that displays the user's Google account photo,
  /// or a default gradient avatar if no photo is available.
  Widget buildProfileAvatar(User? user) {
    final String? photoUrl = user?.photoURL;

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(photoUrl),
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
      );
    }
  }

  /// A reusable function to create list tiles for settings.
  Widget buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
      onTap: () {
        // Implement navigation
      },
    );
  }
}

/// A reusable profile information field widget.
class ProfileInfoField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onPressed;

  const ProfileInfoField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal), // Changed to Teal
      title: Text(label),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Colors.teal), // Changed to Teal
        onPressed: onPressed,
      ),
    );
  }
}
