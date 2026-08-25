import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4C53A5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileSection(),
              const SizedBox(height: 30),
              _buildSettingSection(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildProfileSection() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
    child: Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/profile_picture.JPG',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSettingItem(
  BuildContext context, {
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: Icon(icon, color: const Color(0xFF4C53A5), size: 28),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF4C53A5),
        size: 16,
      ),
      onTap: onTap,
    ),
  );
}

Widget _buildSettingSection(BuildContext context) {
  return Column(
    children: [
      _buildSettingItem(
        context,
        title: 'Profile',
        icon: Icons.person_outline,
        onTap: () {
          Navigator.pushNamed(context, '/accountPage');
        },
      ),
      _buildSettingItem(
        context,
        title: 'Change Password',
        icon: Icons.lock_outline,
        onTap: () {
          // Navigasi ke halaman ubah password baru
          Navigator.pushNamed(context, 'ChangePasswordPage');
        },
      ),
      _buildSettingItem(
        context,
        title: 'Notifications',
        icon: Icons.notifications_outlined,
        onTap: () {
          Navigator.pushNamed(context, '/notifications');
        },
      ),
      _buildSettingItem(
        context,
        title: 'Help & Support',
        icon: Icons.help_outline,
        onTap: () {
          Navigator.pushNamed(context, '/help');
        },
      ),
      _buildSettingItem(
        context,
        title: 'Logout',
        icon: Icons.logout,
        onTap: () {
          _showLogoutDialog(context);
        },
      ),
    ],
  );
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Logout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              // Tutup dialog terlebih dahulu
              Navigator.of(context).pop();
              // Tampilkan SnackBar sukses logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout Successful'),
                  duration: Duration(seconds: 2),
                ),
              );
              // Segera arahkan kembali ke LoginPage menggunakan pushReplacementNamed
              Navigator.pushReplacementNamed(context, 'LoginPage');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4C53A5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
