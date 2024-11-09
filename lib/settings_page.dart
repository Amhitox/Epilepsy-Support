import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart' show ThemeProvider;

class SettingsPage extends StatefulWidget {
  final Function(int) onScreenChange;

  const SettingsPage({super.key, required this.onScreenChange});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Mock user data - replace with actual user data management
  Map<String, dynamic> userData = {
    'name': 'Amhita Marouane',
    'email': 'amhitasao@gmail.com',
    'phone': '+212 622107249',
    'emergencyContact': '+1 987 654 3210',
    'emergencyName': 'Mother',
    'profileImage': 'assets/profile.png', // Add a default profile image to assets
  };

  bool seizureAlerts = true;
  bool locationSharing = true;
  bool medicationReminders = true;

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userData['name']);
    final emailController = TextEditingController(text: userData['email']);
    final phoneController = TextEditingController(text: userData['phone']);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    userData['name'] = nameController.text;
                    userData['email'] = emailController.text;
                    userData['phone'] = phoneController.text;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmergencyContactDialog() {
    final nameController = TextEditingController(text: userData['emergencyName']);
    final phoneController = TextEditingController(text: userData['emergencyContact']);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Emergency Contact',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Contact Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Contact Phone',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    userData['emergencyName'] = nameController.text;
                    userData['emergencyContact'] = phoneController.text;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Colors.deepPurple.shade300),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userData['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userData['email'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Settings Sections
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    const Text(
                      'Profile Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person, color: Colors.deepPurple),
                            title: const Text('Edit Profile'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: _showEditProfileDialog,
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.emergency, color: Colors.deepPurple),
                            title: const Text('Emergency Contact'),
                            subtitle: Text(userData['emergencyName']),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: _showEmergencyContactDialog,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Notifications Section
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          SwitchListTile(
                            secondary: const Icon(Icons.notifications_active, color: Colors.deepPurple),
                            title: const Text('Seizure Alerts'),
                            value: seizureAlerts,
                            onChanged: (bool value) {
                              setState(() {
                                seizureAlerts = value;
                              });
                            },
                          ),
                          const Divider(),
                          SwitchListTile(
                            secondary: const Icon(Icons.location_on, color: Colors.deepPurple),
                            title: const Text('Location Sharing'),
                            value: locationSharing,
                            onChanged: (bool value) {
                              setState(() {
                                locationSharing = value;
                              });
                            },
                          ),
                          const Divider(),
                          SwitchListTile(
                            secondary: const Icon(Icons.medication, color: Colors.deepPurple),
                            title: const Text('Medication Reminders'),
                            value: medicationReminders,
                            onChanged: (bool value) {
                              setState(() {
                                medicationReminders = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Appearance Section
                    const Text(
                      'Appearance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Consumer<ThemeProvider>(
                            builder: (context, themeProvider, _) {
                              return SwitchListTile(
                                secondary: Icon(
                                  themeProvider.isDarkMode 
                                    ? Icons.dark_mode 
                                    : Icons.light_mode,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Dark Mode'),
                                subtitle: Text(
                                  themeProvider.isDarkMode 
                                    ? 'Switch to light mode' 
                                    : 'Switch to dark mode'
                                ),
                                value: themeProvider.isDarkMode,
                                onChanged: (_) {
                                  themeProvider.toggleTheme();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Additional Options
                    const Text(
                      'Additional Options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.help_outline, color: Colors.deepPurple),
                            title: const Text('Help & Support'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Add help & support functionality
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.privacy_tip_outlined, color: Colors.deepPurple),
                            title: const Text('Privacy Policy'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Add privacy policy functionality
                            },
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.logout, color: Colors.red),
                            title: const Text('Log Out'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Add logout functionality
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 