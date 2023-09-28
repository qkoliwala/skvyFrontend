class ContactsLog{

 int? noContacts;
 String? comments;

 Map<String, dynamic> toJson() => {
  'noContacts': noContacts,
  'comments': comments,
 };
}