import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../painters/character_painter.dart';
import '../providers/character_provider.dart';
import 'character_view_screen.dart';

class CharacterNameScreen extends StatefulWidget {
  const CharacterNameScreen({super.key});

  @override
  State<CharacterNameScreen> createState() => _CharacterNameScreenState();
}

class _CharacterNameScreenState extends State<CharacterNameScreen> with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animCtrl;
  late Animation<double> _characterAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _characterAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.elasticOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate()) return;
    context.read<CharacterProvider>().setCharacterName(_nameCtrl.text.trim());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const CharacterViewScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CharacterProvider>();
    final gender = provider.character.gender;
    final outfit = provider.character.currentOutfit;

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
          child: Column(
            children: [
              const SizedBox(height: 28),
              Text(
                'Name your character',
                style: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
              ),
              const SizedBox(height: 4),
              Text(
                'Give them a special name!',
                style: GoogleFonts.nunito(fontSize: 16, color: Colors.grey[500], fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Center(
                  child: ScaleTransition(
                    scale: _characterAnim,
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: CustomPaint(
                          painter: CharacterPainter(outfit: outfit, gender: gender),
                          size: const Size(double.infinity, 340),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameCtrl,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
                    decoration: InputDecoration(
                      hintText: gender == Gender.female ? 'e.g. Luna' : 'e.g. Leo',
                      hintStyle: GoogleFonts.nunito(fontSize: 22, color: Colors.grey[400], fontWeight: FontWeight.w600),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Color(0xFFFF6B9D), width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B9D),
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: const Color(0xFFFF6B9D).withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    child: Text("Meet my character!", style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800)),
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
