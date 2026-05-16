import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterModel _character = const CharacterModel();
  OutfitConfig _draftOutfit = const OutfitConfig();

  CharacterModel get character => _character;
  OutfitConfig get draftOutfit => _draftOutfit;

  void setPlayerInfo(String name, int age) {
    _character = _character.copyWith(playerName: name, playerAge: age);
    notifyListeners();
  }

  void setGender(Gender gender) {
    final defaultOutfit = gender == Gender.male
        ? const OutfitConfig(
            hairStyle: HairStyle.shortStraight,
            dressStyle: DressStyle.none,
            topStyle: TopStyle.tshirt,
            topColor: Color(0xFF4A90D9),
            pantsStyle: PantsStyle.jeans,
            pantsColor: Color(0xFF2C5F8A),
            shoesStyle: ShoesStyle.sneakers,
            shoesColor: Color(0xFFFFFFFF),
          )
        : const OutfitConfig();
    _character = _character.copyWith(gender: gender, currentOutfit: defaultOutfit);
    _draftOutfit = defaultOutfit;
    notifyListeners();
  }

  void setCharacterName(String name) {
    _character = _character.copyWith(characterName: name);
    notifyListeners();
  }

  void beginCustomization() {
    _draftOutfit = _character.currentOutfit;
  }

  void updateDraftHair(HairStyle style) {
    _draftOutfit = _draftOutfit.copyWith(hairStyle: style);
    notifyListeners();
  }

  void updateDraftHairColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(hairColor: color);
    notifyListeners();
  }

  void updateDraftDress(DressStyle style) {
    _draftOutfit = _draftOutfit.copyWith(
      dressStyle: style,
      topStyle: style != DressStyle.none ? TopStyle.none : _draftOutfit.topStyle,
      pantsStyle: style != DressStyle.none ? PantsStyle.none : _draftOutfit.pantsStyle,
    );
    notifyListeners();
  }

  void updateDraftDressColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(dressColor: color);
    notifyListeners();
  }

  void updateDraftTop(TopStyle style) {
    _draftOutfit = _draftOutfit.copyWith(
      topStyle: style,
      dressStyle: style != TopStyle.none ? DressStyle.none : _draftOutfit.dressStyle,
    );
    notifyListeners();
  }

  void updateDraftTopColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(topColor: color);
    notifyListeners();
  }

  void updateDraftPants(PantsStyle style) {
    _draftOutfit = _draftOutfit.copyWith(pantsStyle: style);
    notifyListeners();
  }

  void updateDraftPantsColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(pantsColor: color);
    notifyListeners();
  }

  void updateDraftShoes(ShoesStyle style) {
    _draftOutfit = _draftOutfit.copyWith(shoesStyle: style);
    notifyListeners();
  }

  void updateDraftShoesColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(shoesColor: color);
    notifyListeners();
  }

  void updateDraftHat(HatStyle style) {
    _draftOutfit = _draftOutfit.copyWith(hatStyle: style);
    notifyListeners();
  }

  void updateDraftHatColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(hatColor: color);
    notifyListeners();
  }

  void updateDraftSkinColor(Color color) {
    _draftOutfit = _draftOutfit.copyWith(skinColor: color);
    notifyListeners();
  }

  void saveOutfit(String name) {
    final saved = _draftOutfit.copyWith(outfitName: name);
    _character = _character.copyWith(
      currentOutfit: saved,
      savedOutfits: [..._character.savedOutfits, saved],
    );
    _persistOutfits();
    notifyListeners();
  }

  void applyOutfitFromLocker(OutfitConfig outfit) {
    _character = _character.copyWith(currentOutfit: outfit);
    _draftOutfit = outfit;
    notifyListeners();
  }

  void cancelCustomization() {
    _draftOutfit = _character.currentOutfit;
    notifyListeners();
  }

  Future<void> _persistOutfits() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _character.savedOutfits.map((o) => jsonEncode(o.toJson())).toList();
    await prefs.setStringList('savedOutfits', list);
  }

  Future<void> loadSavedOutfits() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('savedOutfits') ?? [];
    final outfits = list
        .map((s) => OutfitConfig.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
    _character = _character.copyWith(savedOutfits: outfits);
    notifyListeners();
  }
}
