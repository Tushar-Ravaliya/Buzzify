import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/controller/profile_controller.dart';
import 'package:buzzify/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),

        centerTitle: true,
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.isEditing
                  ? controller.toggleEditing
                  : controller.toggleEditing,
              child: Text(controller.isEditing ? 'Cancel' : 'Edit'),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Profile Header
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    user.displayName.isNotEmpty
                        ? user.displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: user.isOnline
                        ? AppTheme.successColor.withValues(alpha: 0.1)
                        : AppTheme.textSecondaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: user.isOnline
                              ? AppTheme.successColor
                              : AppTheme.textSecondaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        user.isOnline ? 'Online' : 'Offline',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: user.isOnline
                              ? AppTheme.successColor
                              : AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.getJoinedData(),
                  style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 24),

                // Personal Information Card
                Obx(
                  () => Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.displayNameController,
                            enabled: controller.isEditing,
                            decoration: InputDecoration(
                              labelText: 'Display Name',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.emailController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              helperText: 'Email cannot be changed',
                            ),
                          ),
                          if (controller.isEditing) ...[
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : controller.updateProfile,
                                child: controller.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text("Save Changes"),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.security,
                          color: AppTheme.primaryColor,
                        ),
                        title: Text('Change Password'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed('/change-Password'),
                      ),
                      Divider(height: 1, color: Theme.of(context).dividerColor),
                      ListTile(
                        leading: Icon(
                          Icons.delete_forever,
                          color: AppTheme.errorColor,
                        ),
                        title: Text('Delete Account'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: controller.deleteAccount,
                      ),
                      Divider(height: 1, color: Theme.of(context).dividerColor),
                      Obx(() {
                        final themeController = Get.find<ThemeController>();
                        return ListTile(
                          leading: Icon(
                            themeController.isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: AppTheme.primaryColor,
                          ),
                          title: Text(
                            themeController.isDarkMode
                                ? 'Light Mode'
                                : 'Dark Mode',
                          ),
                          trailing: Switch(
                            value: themeController.isDarkMode,
                            onChanged: (_) => themeController.toggleTheme(),
                            activeColor: AppTheme.primaryColor,
                          ),
                          onTap: () => themeController.toggleTheme(),
                        );
                      }),
                      Divider(height: 1, color: Theme.of(context).dividerColor),
                      ListTile(
                        leading: Icon(Icons.logout, color: AppTheme.errorColor),
                        title: Text('Sign Out'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: controller.signOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
