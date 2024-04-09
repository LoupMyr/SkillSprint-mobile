class Exercice {
  String _uid;
  int _nbSerie;
  int _nbRep;

  Exercice(this._uid, this._nbSerie, this._nbRep);

  int get nbRep => _nbRep;

  set nbRep(int value) {
    _nbRep = value;
  }

  int get nbSerie => _nbSerie;

  set nbSerie(int value) {
    _nbSerie = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}