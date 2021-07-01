class UPCValidation {
  final String upcNumber;

  UPCValidation(this.upcNumber);

  bool isUPCNumberValid() {
    if (upcNumber.length < 7) return false;
    if (upcNumber.length > 15) return false;
    return int.tryParse(upcNumber) != null;
  }


}