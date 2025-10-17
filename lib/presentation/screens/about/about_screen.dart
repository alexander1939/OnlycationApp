import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = const [
      {'name': 'Gustavo Alexander Medina Cifuentes', 'image': 'assets/images/tavazo.jpeg'},
      {'name': 'Gael Espinosa Fernandez', 'image': 'assets/images/yo.jpg'},
      {'name': 'Jesus Guzman Jimenez', 'image': 'assets/images/chus.jpeg'},
      {'name': 'Roberto Carlos Nuñez Cruz', 'image': 'assets/images/rober.jpeg'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
        backgroundColor: const Color(0xFF68B2C9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final m = members[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF8ED4BE),
                child: ClipOval(
                  child: Image.asset(
                    m['image']!,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const FlutterLogo(size: 36),
                  ),
                ),
              ),
              title: Text(
                m['name']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D8FA8),
                ),
              ),
              subtitle: const Text(
                'Desarrollador',
                style: TextStyle(color: Color(0xFF444444)),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: members.length,
      ),
    );
  }
}
