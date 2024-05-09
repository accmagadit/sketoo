import 'package:bloc/bloc.dart';
part 'player_2_state.dart';

class Player_2Cubit extends Cubit<Player_2State> {
  Player_2Cubit() : super(Player_2Initial());

  void addPasukanHewan(String hewan) {
    List<String> updatedPasukanHewan = List.from(state.pasukanHewan)
      ..add(hewan);
    int jumlahKoin = state.koin;
    int babak = state.babak;
    bool hasClick = state.hasClick;
    emit(Player_2State(
        pasukanHewan: updatedPasukanHewan,
        koin: jumlahKoin,
        babak: babak,
        hasClick: hasClick));
  }

  void changeKoinValue(int amount) {
    int jumlahKoin = state.koin;
    List<String> updatedPasukanHewan = state.pasukanHewan;
    int babak = state.babak;
    bool hasClick = state.hasClick;
    emit(Player_2State(
        koin: jumlahKoin + amount,
        pasukanHewan: updatedPasukanHewan,
        babak: babak,
        hasClick: hasClick));
  }

  void subtractionKoin(int amount) {
    int jumlahKoin = state.koin;
    List<String> updatedPasukanHewan = state.pasukanHewan;
    int babak = state.babak;
    bool hasClick = state.hasClick;
    emit(Player_2State(
        koin: jumlahKoin - amount,
        pasukanHewan: updatedPasukanHewan,
        babak: babak,
        hasClick: hasClick));
  }

  void addBabak() {
    int jumlahKoin = state.koin;
    List<String> updatedPasukanHewan = state.pasukanHewan;
    int babak = state.babak;
    bool hasClick = state.hasClick;
    emit(Player_2State(
        koin: jumlahKoin,
        pasukanHewan: updatedPasukanHewan,
        babak: babak + 1,
        hasClick: hasClick));
  }

  void changeHasClick() {
    int jumlahKoin = state.koin;
    List<String> updatedPasukanHewan = state.pasukanHewan;
    int babak = state.babak;
    bool hasClick = state.hasClick;
    emit(Player_2State(
        koin: jumlahKoin,
        pasukanHewan: updatedPasukanHewan,
        babak: babak,
        hasClick: !hasClick));
  }
}
