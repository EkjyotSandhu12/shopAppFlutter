class customException implements Exception{

  String message;

  customException(this.message);

  String toString(){
    return message;
  }

}