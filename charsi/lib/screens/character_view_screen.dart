import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../painters/character_painter.dart';
import '../providers/character_provider.dart';
import 'customize_screen.dart';
import 'locker_screen.dart';

class CharacterViewScreen extends StatefulWidget {
  const CharacterViewScreen({super.key});

  @override
  State<CharacterViewScreen> createState() => _CharacterViewScreenState();
}

class _CharacterViewScreenState extends State<CharacterViewScreen> with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _bounceAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut),
    );
    _bounceCtrl.forward();
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  void _goToCustomize() {
    context.read<CharacterProvider>().beginCustomization();
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomizeScreen()));
  }

  void _goToLocker() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const LockerScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, provider, _) {
        final character = provider.character;
        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          body: SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.characterName,
                            style: GoogleFonts.nunito(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                          Text(
                            '${character.playerName}\'s character',
                            style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey[400], fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Locker button
                      _IconButton(
                        icon: Icons.checkroom_rounded,
                        tooltip: 'Locker',
                        color: const Color(0xFF4A90D9),
                        onTap: _goToLocker,
                      ),
                      const SizedBox(width: 10),
                      // Edit button
                      _IconButton(
                        icon: Icons.edit_rounded,
                        tooltip: 'Customize',
                        color: const Color(0xFFFF6B9D),
                        onTap: _goToCustomize,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Character card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ScaleTransition(
                      scale: _bounceAnim,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 30,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            children: [
                              // Background decoration
                              Positioned.fill(
                                child: CustomPaint(painter: _BackgroundPainter()),
                              ),
                              // Character
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CustomPaint(
                                  painter: CharacterPainter(
                                    outfit: character.currentOutfit,
                                    gender: character.gender,
                                  ),
                                  size: Size.infinite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Bottom action hints
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HintChip(icon: Icons.edit_rounded, label: 'Customize', color: const Color(0xFFFF6B9D), onTap: _goToCustomize),
                      const SizedBox(width: 12),
                      _HintChip(icon: Icons.checkroom_rounded, label: 'My Locker', color: const Color(0xFF4A90D9), onTap: _goToLocker),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const _IconButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.25), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _HintChip({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.nunito(color: color, fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFF5F9).withOpacity(0.8);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.12), 60, paint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.88), 80, paint);
    final paint2 = Paint()..color = const Color(0xFFEEF6FF).withOpacity(0.8);
    canvas.drawCircle(Offset(size.width * 0.05, size.height * 0.3), 45, paint2);
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) => false;
}
