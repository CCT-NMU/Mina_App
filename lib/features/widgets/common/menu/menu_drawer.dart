import 'package:flutter/material.dart';
import 'package:mina_app/features/note_taking/note_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/features/auth/bloc/auth_bloc.dart';
import 'package:mina_app/features/settings/view/settings_view.dart';
import 'package:mina_app/features/statistics/view/statistics_view.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Extract user info from the authentication state
          String displayName = 'User';
          String email = '';
          String initials = 'U';

          if (state is AuthAuthenticated) {
            // Get user info from Supabase user object
            final user = state.user;

            // Try to get display name from user metadata or profile
            if (state.profile != null && state.profile!['name'] != null) {
              displayName = state.profile!['name'];
            } else if (user.userMetadata?['name'] != null) {
              displayName = user.userMetadata!['name'];
            } else if (user.email != null) {
              // Fallback to email username part
              displayName = user.email!.split('@')[0];
            }

            email = user.email ?? '';
            initials =
                displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
          }

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(displayName),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    initials,
                    style: const TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Statistics'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StatisticsView()),
                  );
                },
              ),
              ListTile(
            leading: const Icon(Icons.padding_rounded),
            title: const Text('Notes'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotesView()),
              );
            },
          ),
          ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsView()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign Out'),
                onTap: () {
                  // Trigger sign out through BLoC
                  context.read<AuthBloc>().add(AuthSignOutRequested());
                  Navigator.pop(context); // Close drawer
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
