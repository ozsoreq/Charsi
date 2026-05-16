import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../painters/character_painter.dart';
import '../providers/character_provider.dart';

enum _Category { dress, top, pants, shoes, hair, hat, skin }

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> with TickerProviderStateMixin {
  _Category _selectedCategory = _Category.dress;
  late TabController _tabCtrl;

  final List<Color> _palette = const [
    Color(0xFFFF6B9D), Color(0xFF4A90D9), Color(0xFFFFD93D),
    Color(0xFF6BCB77), Color(0xFF9B59B6), Color(0xFFFF8E53),
    Color(0xFF1ABC9C), Color(0xFFE74C3C), Color(0xFF2C3E50),
    Color(0xFFFFFFFF), Color(0xFF95A5A6), Color(0xFF8B5E3C),
    Color(0xFFFAD7A0), Color(0xFFAED6F1), Color(0xFFA9DFBF),
  ];

  final List<Color> _skinPalette = const [
    Color(0xFFFDEBCF), Color(0xFFF5CBA7), Color(0xFFE8B89A),
    Color(0xFFD4956A), Color(0xFFC1784A), Color(0xFF8D5524),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _Category.values.length, vsync: this);
    _tabCtrl.addListener(() {
      if (!_tabCtrl.indexIsChanging) {
        setState(() => _selectedCategory = _Category.values[_tabCtrl.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    showDialog(
      context: context,
      builder: (ctx) {
        final ctrl = TextEditingController(text: 'My Outfit');
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Save Outfit', style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: 'Outfit name',
              filled: true,
              fillColor: const Color(0xFFF8F8F8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: GoogleFonts.nunito(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B9D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final name = ctrl.text.trim().isNotEmpty ? ctrl.text.trim() : 'My Outfit';
                context.read<CharacterProvider>().saveOutfit(name);
                Navigator.pop(ctx);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"$name" saved to your locker!', style: GoogleFonts.nunito()),
                    backgroundColor: const Color(0xFFFF6B9D),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              child: Text('Save', style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }

  void _onCancel() {
    context.read<CharacterProvider>().cancelCustomization();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, provider, _) {
        final outfit = provider.draftOutfit;
        final gender = provider.character.gender;

        return Scaffold(
          backgroundColor: const Color(0xFFFAF8FF),
          body: SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _onCancel,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.close_rounded, size: 22, color: Color(0xFF666666)),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Customize',
                        style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF2D2D2D)),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _onSave,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)]),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: const Color(0xFFFF6B9D).withOpacity(0.35), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Text('Save', style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category tabs
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _Category.values.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedCategory = cat);
                          _tabCtrl.animateTo(cat.index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFF6B9D) : Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: isSelected ? const Color(0xFFFF6B9D) : const Color(0xFFE8E8E8),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [BoxShadow(color: const Color(0xFFFF6B9D).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                                : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_catEmoji(cat), style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(
                                _catLabel(cat, gender),
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : const Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 12),

                // Main content area
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: item list
                      SizedBox(
                        width: 100,
                        child: _buildItemList(provider, outfit, gender),
                      ),
                      // Right: character preview
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: CustomPaint(
                                painter: CharacterPainter(outfit: outfit, gender: gender),
                                size: Size.infinite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Color palette
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedCategory == _Category.skin ? 'Skin Tone' : 'Color',
                        style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: (_selectedCategory == _Category.skin ? _skinPalette : _palette)
                              .map((color) => _buildColorChip(color, outfit, provider))
                              .toList(),
                        ),
                      ),
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

  Widget _buildItemList(CharacterProvider provider, OutfitConfig outfit, Gender gender) {
    switch (_selectedCategory) {
      case _Category.dress:
        return _ItemList<DressStyle>(
          items: gender == Gender.female
              ? DressStyle.values
              : [DressStyle.none],
          selected: outfit.dressStyle,
          label: (s) => _dressLabel(s),
          icon: (s) => _dressIcon(s),
          color: outfit.dressColor,
          onSelect: provider.updateDraftDress,
        );
      case _Category.top:
        return _ItemList<TopStyle>(
          items: TopStyle.values,
          selected: outfit.topStyle,
          label: (s) => _topLabel(s),
          icon: (s) => _topIcon(s),
          color: outfit.topColor,
          onSelect: provider.updateDraftTop,
        );
      case _Category.pants:
        return _ItemList<PantsStyle>(
          items: PantsStyle.values,
          selected: outfit.pantsStyle,
          label: (s) => _pantsLabel(s),
          icon: (s) => _pantsIcon(s),
          color: outfit.pantsColor,
          onSelect: provider.updateDraftPants,
        );
      case _Category.shoes:
        return _ItemList<ShoesStyle>(
          items: ShoesStyle.values,
          selected: outfit.shoesStyle,
          label: (s) => _shoesLabel(s),
          icon: (s) => _shoesIcon(s),
          color: outfit.shoesColor,
          onSelect: provider.updateDraftShoes,
        );
      case _Category.hair:
        final styles = gender == Gender.female
            ? [HairStyle.longWavy, HairStyle.longStraight, HairStyle.bun, HairStyle.shortCurly, HairStyle.medium]
            : [HairStyle.shortStraight, HairStyle.shortCurly, HairStyle.medium];
        return _ItemList<HairStyle>(
          items: styles,
          selected: outfit.hairStyle,
          label: (s) => _hairLabel(s),
          icon: (s) => _hairIcon(s),
          color: outfit.hairColor,
          onSelect: provider.updateDraftHair,
        );
      case _Category.hat:
        return _ItemList<HatStyle>(
          items: HatStyle.values,
          selected: outfit.hatStyle,
          label: (s) => _hatLabel(s),
          icon: (s) => _hatIcon(s),
          color: outfit.hatColor,
          onSelect: provider.updateDraftHat,
        );
      case _Category.skin:
        return const SizedBox.shrink();
    }
  }

  Widget _buildColorChip(Color color, OutfitConfig outfit, CharacterProvider provider) {
    Color? currentColor;
    switch (_selectedCategory) {
      case _Category.dress:
        currentColor = outfit.dressColor;
        break;
      case _Category.top:
        currentColor = outfit.topColor;
        break;
      case _Category.pants:
        currentColor = outfit.pantsColor;
        break;
      case _Category.shoes:
        currentColor = outfit.shoesColor;
        break;
      case _Category.hair:
        currentColor = outfit.hairColor;
        break;
      case _Category.hat:
        currentColor = outfit.hatColor;
        break;
      case _Category.skin:
        currentColor = outfit.skinColor;
        break;
    }
    final isSelected = currentColor.toARGB32() == color.toARGB32();

    return GestureDetector(
      onTap: () => _applyColor(color, provider),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 10),
        width: isSelected ? 40 : 34,
        height: isSelected ? 40 : 34,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B9D) : Colors.grey[300]!,
            width: isSelected ? 3 : 1.5,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 3))]
              : [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
        ),
        child: color == Colors.white
            ? Icon(Icons.circle_outlined, size: 14, color: Colors.grey[300])
            : null,
      ),
    );
  }

  void _applyColor(Color color, CharacterProvider provider) {
    switch (_selectedCategory) {
      case _Category.dress:
        provider.updateDraftDressColor(color);
        break;
      case _Category.top:
        provider.updateDraftTopColor(color);
        break;
      case _Category.pants:
        provider.updateDraftPantsColor(color);
        break;
      case _Category.shoes:
        provider.updateDraftShoesColor(color);
        break;
      case _Category.hair:
        provider.updateDraftHairColor(color);
        break;
      case _Category.hat:
        provider.updateDraftHatColor(color);
        break;
      case _Category.skin:
        provider.updateDraftSkinColor(color);
        break;
    }
  }

  String _catEmoji(_Category cat) {
    switch (cat) {
      case _Category.dress: return '👗';
      case _Category.top: return '👕';
      case _Category.pants: return '👖';
      case _Category.shoes: return '👟';
      case _Category.hair: return '💇';
      case _Category.hat: return '🎩';
      case _Category.skin: return '🎨';
    }
  }

  String _catLabel(_Category cat, Gender gender) {
    switch (cat) {
      case _Category.dress: return gender == Gender.female ? 'Dress' : 'Outfit';
      case _Category.top: return 'Top';
      case _Category.pants: return 'Pants';
      case _Category.shoes: return 'Shoes';
      case _Category.hair: return 'Hair';
      case _Category.hat: return 'Hat';
      case _Category.skin: return 'Skin';
    }
  }

  String _dressLabel(DressStyle s) {
    switch (s) {
      case DressStyle.none: return 'None';
      case DressStyle.aLine: return 'A-Line';
      case DressStyle.casual: return 'Casual';
      case DressStyle.ballgown: return 'Ballgown';
      case DressStyle.sundress: return 'Sundress';
      case DressStyle.tshirtDress: return 'T-Dress';
    }
  }

  IconData _dressIcon(DressStyle s) {
    switch (s) {
      case DressStyle.none: return Icons.remove_circle_outline;
      default: return Icons.checkroom_rounded;
    }
  }

  String _topLabel(TopStyle s) {
    switch (s) {
      case TopStyle.none: return 'None';
      case TopStyle.tshirt: return 'T-Shirt';
      case TopStyle.hoodie: return 'Hoodie';
      case TopStyle.buttonUp: return 'Button Up';
      case TopStyle.tank: return 'Tank Top';
    }
  }

  IconData _topIcon(TopStyle s) => Icons.dry_cleaning_rounded;

  String _pantsLabel(PantsStyle s) {
    switch (s) {
      case PantsStyle.none: return 'None';
      case PantsStyle.jeans: return 'Jeans';
      case PantsStyle.shorts: return 'Shorts';
      case PantsStyle.leggings: return 'Leggings';
      case PantsStyle.skirt: return 'Skirt';
      case PantsStyle.chinos: return 'Chinos';
    }
  }

  IconData _pantsIcon(PantsStyle s) => Icons.straighten_rounded;

  String _shoesLabel(ShoesStyle s) {
    switch (s) {
      case ShoesStyle.none: return 'None';
      case ShoesStyle.sandals: return 'Sandals';
      case ShoesStyle.sneakers: return 'Sneakers';
      case ShoesStyle.boots: return 'Boots';
      case ShoesStyle.heels: return 'Heels';
      case ShoesStyle.loafers: return 'Loafers';
    }
  }

  IconData _shoesIcon(ShoesStyle s) => Icons.sports_soccer_rounded;

  String _hairLabel(HairStyle s) {
    switch (s) {
      case HairStyle.longWavy: return 'Long Wavy';
      case HairStyle.longStraight: return 'Straight';
      case HairStyle.bun: return 'Bun';
      case HairStyle.shortCurly: return 'Curly';
      case HairStyle.shortStraight: return 'Short';
      case HairStyle.medium: return 'Medium';
    }
  }

  IconData _hairIcon(HairStyle s) => Icons.face_retouching_natural_rounded;

  String _hatLabel(HatStyle s) {
    switch (s) {
      case HatStyle.none: return 'None';
      case HatStyle.sunhat: return 'Sun Hat';
      case HatStyle.beanie: return 'Beanie';
      case HatStyle.cap: return 'Cap';
      case HatStyle.tophat: return 'Top Hat';
      case HatStyle.beret: return 'Beret';
    }
  }

  IconData _hatIcon(HatStyle s) => Icons.headphones_rounded;
}

class _ItemList<T> extends StatelessWidget {
  final List<T> items;
  final T selected;
  final String Function(T) label;
  final IconData Function(T) icon;
  final Color color;
  final void Function(T) onSelect;

  const _ItemList({
    required this.items,
    required this.selected,
    required this.label,
    required this.icon,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 4, 8, 12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final item = items[i];
        final isSelected = item == selected;
        return GestureDetector(
          onTap: () => onSelect(item),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFF6B9D).withOpacity(0.12) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? const Color(0xFFFF6B9D) : const Color(0xFFE8E8E8),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon(item),
                  color: isSelected ? const Color(0xFFFF6B9D) : Colors.grey[500],
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  label(item),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? const Color(0xFFFF6B9D) : Colors.grey[600],
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
