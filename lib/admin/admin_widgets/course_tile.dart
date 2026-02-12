import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String backGroundImage;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CourseTile({
    super.key,
    required this.title,
    required this.backGroundImage,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 210,
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(backGroundImage, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCircleButton(
                        context,
                        icon: Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                        onTap: onEdit,
                      ),
                      const SizedBox(width: 8),
                      _buildCircleButton(
                        context,
                        icon: Icons.delete_outline,
                        color: Colors.red,
                        onTap: onDelete,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(16, 26, 0, 16),
                    color: Colors.black.withOpacity(0.50),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}
