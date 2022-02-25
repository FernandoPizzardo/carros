import 'carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    final carros = <Carro>[];

    carros.add(Carro(
      nome: "Audi GT",
      urlFoto:
          "https://cdn.tstatic.net/tribunnews/foto/bank/images/audi-gt-r-2018_20180330_085221.jpg",
    ));
    carros.add(Carro(
      nome: "Green GT",
      urlFoto: "https://i.redd.it/63ag38bnbuf11.jpg",
    ));

    carros.add(Carro(
        nome: "Purple GT",
        urlFoto:
            "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.redd.it%2Fcvh194mzwok11.jpg&f=1&nofb=1"));

    return carros;
  }
}
