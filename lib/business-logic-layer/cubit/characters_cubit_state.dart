part of 'characters_cubit_cubit.dart';

@immutable
sealed class CharactersCubitState {}

final class CharactersCubitInitial extends CharactersCubitState {}

class CharactersCubitLoaded extends CharactersCubitState {
  final List<Character> characters;
  CharactersCubitLoaded(this.characters);
}
