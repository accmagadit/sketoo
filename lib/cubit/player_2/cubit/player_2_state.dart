part of 'player_2_cubit.dart';

class Player_2State {
  final int koin;
  final int babak;
  final bool hasClick;
  final List<String> pasukanHewan;

  const Player_2State({this.koin = 0, this.pasukanHewan = const [], this.babak=0, this.hasClick=false});

  @override
  List<Object?> get props => [koin, pasukanHewan, babak, hasClick];
}

final class Player_2Initial extends Player_2State {}
