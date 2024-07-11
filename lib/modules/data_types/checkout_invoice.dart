class InvoiceItem
{
  String title;
  String? value;

  InvoiceItem({required this.title,required String value})
  {
    this.value = '$value EGP';
  }

}