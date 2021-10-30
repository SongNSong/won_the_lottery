class LottoSheet {
  final String gameRound;
  final String sellerCode;
  final Map<String, List<int>> lottoSets;

  LottoSheet({required this.gameRound, required this.sellerCode, required this.lottoSets});

  @override
  String toString() {
    return "회차: $gameRound, 판매코드: $sellerCode, ${lottoSets.toString()}";
  }
}
