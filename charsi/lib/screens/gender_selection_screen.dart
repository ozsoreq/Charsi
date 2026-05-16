import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../painters/character_painter.dart';
import '../providers/character_provider.dart';
import 'character_name_screen.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> with SingleTickerProviderStateMixin {
  Gender? _selected;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onSelect(Gender gender) {
    setState(() => _selected = gender);
  }

  void _onContinue() {
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick a character!', style: GoogleFonts.nunito()),
          backgroundColor: const Color(0xFFFF6B9D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    context.read<CharacterProvider>().setGender(_selected!);
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CharacterNameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final playerName = context.read<CharacterProvider>().character.playerName;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF0F5), Color(0xFFE8F4FD)],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Text(
                  'Hi, $playerName!',
                  style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose your character',
                  style: GoogleFonts.nunito(fontSize: 17, color: Colors.grey[500], fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: _GenderCard(
                            label: 'Girl',
                            emoji: '👧',
                            gender: Gender.female,
                            isSelected: _selected == Gender.female,
                            gradientColors: const [Color(0xFFFFB3D1), Color(0xFFFF6B9D)],
                            outfit: const OutfitConfig(),
                            onTap: () => _onSelect(Gender.female),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _GenderCard(
                            label: 'Boy',
                            emoji: '👦',
                            gender: Gender.male,
                            isSelected: _selected == Gender.male,
                            gradientColors: const [Color(0xFF9BB8FF), Color(0xFF4A90D9)],
                            outfit: const OutfitConfig(
                              hairStyle: HairStyle.shortStraight,
                              dressStyle: DressStyle.none,
                              topStyle: TopStyle.tshirt,
                              topColor: Color(0xFF4A90D9),
                              pantsStyle: PantsStyle.jeans,
                              pantsColor: Color(0xFF2C5F8A),
                              shoesStyle: ShoesStyle.sneakers,
                              shoesColor: Color(0xFFFFFFFF),
                            ),
                            onTap: () => _onSelect(Gender.male),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selected != null ? _onContinue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B9D),
                        disabledBackgroundColor: Colors.grey[300],
                        foregroundColor: Colors.white,
                        elevation: _selected != null ? 6 : 0,
                        shadowColor: const Color(0xFFFF6B9D).withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800),
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
}

class _GenderCard extends StatefulWidget {
  final String label;
  final String emoji;
  final Gender gender;
  final bool isSelected;
  final List<Color> gradientColors;
  final OutfitConfig outfit;
  final VoidCallback onTap;

  const _GenderCard({
    required this.label,
    required this.emoji,
    required this.gender,
    required this.isSelected,
    required this.gradientColors,
    required this.outfit,
    required this.onTap,
  });

  @override
  State<_GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<_GenderCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleCtrl.forward(),
      onTapUp: (_) {
        _scaleCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _scaleCtrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isSelected ? widget.gradientColors.last : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isSelected
                    ? widget.gradientColors.last.withOpacity(0.3)
                    : Colors.black.withOpacity(0.08),
                blurRadius: widget.isSelected ? 20 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: CustomPaint(
                    painter: CharacterPainter(outfit: widget.outfit, gender: widget.gender),
                    size: Size.infinite,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: widget.isSelected
                      ? LinearGradient(colors: widget.gradientColors)
                      : LinearGradient(colors: [Colors.grey[100]!, Colors.grey[200]!]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      widget.label,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: widget.isSelected ? Colors.white : Colors.grey[600],
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
