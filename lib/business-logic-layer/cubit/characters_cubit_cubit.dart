import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_api/data-layer/models/characters.dart';
import 'package:flutter_bloc_api/data-layer/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_cubit_state.dart';

class CharactersCubitCubit extends Cubit<CharactersCubitState> {
  final CharactersRepository charactersRepository;
  List<Character> characters;
  CharactersCubitCubit(this.charactersRepository, this.characters)
      : super(CharactersCubitInitial());

  List<Character> getAllCharacter() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersCubitLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
