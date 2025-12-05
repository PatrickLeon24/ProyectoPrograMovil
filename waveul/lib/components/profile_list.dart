import 'package:flutter/material.dart';
import 'package:waveul/models/user.dart';

class ProfilesList extends StatelessWidget {
  final List<User> profiles;
  final Function(int userId, bool follow)? onToggleFollow;

  const ProfilesList({super.key, required this.profiles, this.onToggleFollow});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profiles.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final user = profiles[i];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),

          leading: CircleAvatar(
            radius: 24,
            backgroundImage:
                user.profileImage != null
                    ? NetworkImage(user.profileImage!)
                    : AssetImage("assets/images/Profile_icon.jpg")
                        as ImageProvider,
          ),

          title: Text(
            "${user.name} ${user.lastName}",
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),

          subtitle: Text(
            "@${user.username}",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  final newFollow = !user.following;
                  onToggleFollow?.call(user.id, newFollow);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        user.following
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        user.following
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    user.following ? "Siguiendo" : "Seguir",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.shadow,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.shadow,
                ),
                onPressed: () {},
              ),
            ],
          ),

          onTap: () {},
        );
      },
    );
  }
}
