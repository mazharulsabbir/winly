class PaymentmentMathodModel {
  final String tittle;
  final int index;

  const PaymentmentMathodModel({required this.tittle, required this.index});

  static List<PaymentmentMathodModel> paymentList = const [
    PaymentmentMathodModel(tittle: 'Bkash', index: 0),
    PaymentmentMathodModel(tittle: 'Nagad', index: 1),
    PaymentmentMathodModel(tittle: 'Card', index: 2)
  ];
}
