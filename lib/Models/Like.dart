class Like
{
  String _idUtilisateur;
  String _idProgramme;

  Like(this._idUtilisateur, this._idProgramme);

  String get idProgramme => _idProgramme;

  set idProgramme(String value) {
    _idProgramme = value;
  }

  String get idUtilisateur => _idUtilisateur;

  set idUtilisateur(String value) {
    _idUtilisateur = value;
  }
}