import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String backGroundImage;
  final VoidCallback onTap;

  const CourseTile({
    super.key,
    required this.title,
    required this.backGroundImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String baseUrl = "https://media.crescentlearning.org/";
     print(baseUrl+backGroundImage);
    return SizedBox(
      height: 210,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
             
              Image.network(baseUrl+backGroundImage, 
              //fit: BoxFit.fill,
              scale: 1,),
              Positioned(
                top: 8,
                right: 8,
                child: PopupMenuButton<String>(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 6,
                  color: Theme.of(context).colorScheme.surface,
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onSelected: (value) {
                    if (value == 'update') {
                      // handle update
                    } else if (value == 'delete') {
                      // handle delete
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'update',
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 10),
                          Text(
                            'Update',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuDivider(height: 8),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
