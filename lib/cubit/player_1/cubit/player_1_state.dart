part of 'player_1_cubit.dart';

class Player_1State extends Equatable {
  final int koin;
  final int babak;
  final bool hasClick;
  final List<String> pasukanHewan;

  const Player_1State(
      {this.koin = 0, this.pasukanHewan = const [], this.babak = 0,this.hasClick = false});

  @override
  List<Object?> get props => [koin, pasukanHewan, babak, hasClick];
}

final class Player_1Initial extends Player_1State {}
