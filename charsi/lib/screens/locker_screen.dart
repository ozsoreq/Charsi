import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../painters/character_painter.dart';
import '../providers/character_provider.dart';

class LockerScreen extends StatelessWidget {
  const LockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, provider, _) {
        final outfits = provider.character.savedOutfits;
        final gender = provider.character.gender;
        final currentOutfit = provider.character.currentOutfit;

        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                          ),
                          child: const Icon(Icons.arrow_back_rounded, size: 22, color: Color(0xFF2D2D2D)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Locker',
                            style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
                          ),
                          Text(
                            '${outfits.length} outfit${outfits.length == 1 ? '' : 's'} saved',
                            style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF4A90D9), Color(0xFF6BB6FF)]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.checkroom_rounded, color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (outfits.isEmpty)
                  Expanded(child: _EmptyLocker())
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: outfits.length,
                      itemBuilder: (ctx, i) {
                        final outfit = outfits[i];
                        final isWearing = outfit.outfitName == currentOutfit.outfitName &&
                            outfit.dressColor.toARGB32() == currentOutfit.dressColor.toARGB32();
                        return _OutfitCard(
                          outfit: outfit,
                          gender: gender,
                          isWearing: isWearing,
                          onWear: () {
                            provider.applyOutfitFromLocker(outfit);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Wearing "${outfit.outfitName}"!', style: GoogleFonts.nunito()),
                                backgroundColor: const Color(0xFF4A90D9),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                        );
                      },
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

class _OutfitCard extends StatelessWidget {
  final OutfitConfig outfit;
  final Gender gender;
  final bool isWearing;
  final VoidCallback onWear;

  const _OutfitCard({
    required this.outfit,
    required this.gender,
    required this.isWearing,
    required this.onWear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isWearing ? const Color(0xFFFF6B9D) : Colors.transparent,
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isWearing
                ? const Color(0xFFFF6B9D).withOpacity(0.2)
                : Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isWearing)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)]),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Text(
                'Currently Wearing',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomPaint(
                painter: CharacterPainter(outfit: outfit, gender: gender),
                size: Size.infinite,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
            child: Column(
              children: [
                Text(
                  outfit.outfitName,
                  style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF2D2D2D)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isWearing ? null : onWear,
                    style: TextButton.styleFrom(
                      backgroundColor: isWearing ? Colors.grey[100] : const Color(0xFFFF6B9D).withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: Text(
                      isWearing ? 'Wearing' : 'Wear it!',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isWearing ? Colors.grey[400] : const Color(0xFFFF6B9D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyLocker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF4A90D9).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.checkroom_rounded, size: 50, color: Color(0xFF4A90D9)),
          ),
          const SizedBox(height: 20),
          Text(
            'Your locker is empty!',
            style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize your character and save\nyour outfits here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey[400]),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B9D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
            label: Text('Customize now', style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
