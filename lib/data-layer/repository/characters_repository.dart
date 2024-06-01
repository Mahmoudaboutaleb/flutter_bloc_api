// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc_api/data-layer/models/characters.dart';
import 'package:flutter_bloc_api/data-layer/web-services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;
  CharactersRepository(this.charactersWebServices);
  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((e) => Character.fromJson(e)).toList();
  }
}
