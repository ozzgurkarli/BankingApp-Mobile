// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class Localizer
{
  static int index = 0;
  static const List<String> index_text = ["EN", "TR"];
  
  static const List<String> qr_code_operations = ["Karekod İşlemleri", "QR Operations"];
  static const List<String> login = ["Giriş Yap", "Login"];
  static const List<String> notifications = ["Bildirimler", "Notifications"];
  static const List<String> credit_calculation = ["Kredi Hesaplama", "Credit Calculation"];
  static const List<String> market_information = ["Piyasa Bilgileri", "Market Information"];
  static const List<String> i_want_to_be_a_customer = ["Müşteri olmak istiyorum", "I want to be a customer"];
  static const List<String> did_you_forget_your_password = ["Şifreni mi unuttun?", "Did you forget your password?"];
  static const List<String> change_customer = ["Müşteri değiştir", "Change customer"];
  static const List<String> welcome___with_comma = ["Hoşgeldin, ", "Welcome, "];
  static const List<String> remaining_attempts = ["Kalan deneme hakkı: ", "Remaining attempts: "];
  static const List<String> last_transactions = ["Son İşlemlerim", "Last Transactions"];
  static const List<String> send_money = ["Para Gönder", "Send Money"];
  static const List<String> money_transfer = ["Para Transferi", "Money Transfer"];
  static const List<String> password_must_be_6_char_long = ["Parola 6 karakter olmalı.", "Password must be 6 characters long."];
  static const List<String> password_changed_successfully = ["Parola başarıyla değiştirildi.", "Password changed successfully"];
  static const List<String> entered_passwords_do_not_match = ["Girilen parolalar eşleşmiyor.", "The entererd passwords do not match."];
  static const List<String> incorrect_password_entry = ["Hatalı parola girişi yapıldı.\n", "Incorrect password entry.\n"];
  static const List<String> incorrect_identity_no_entry = ["Hatalı 'T.C. Kimlik No' girişi yapıldı.\n", "Incorrect 'Identity No' entry.\n"];
  static const List<String> error = ["Hata", "Error"];
  static const List<String> ok = ["Tamam", "Ok"];
  static const List<String> success = ["Başarılı", "Success"];
  static const List<String> account_created = ["Tebrikler, hesabın oluşturuldu. Email adresine gönderdiğimiz geçici parola ile giriş yapıp kendi parolanı oluşturabilirsin.", "Congratulations, your account has been created. You can log in with the temporary password we sent to your email address and create your own password."];
  static const List<String> error_database = ["Veritabanına bağlanırken hata oluştu.\n", "An error occurred while connecting to the database.\n"];

  static const List<String> password = ["Parola", "Password"];
  static const List<String> new_password = ["Yeni Parola", "New Password"];
  static const List<String> new_password__again = ["Yeni Parola(Tekrar)", "New Password(Again)"];
  static const List<String> name = ["Ad", "Name"];
  static const List<String> surname = ["Soyad", "Surname"];
  static const List<String> email = ["Email", "Email"];
  static const List<String> identity_no = ["T.C. Kimlik No", "Identity No"];
  static const List<String> phone_no = ["Telefon No", "Phone No"];
  static const List<String> city = ["İl", "City"];
  static const List<String> district = ["İlçe", "District"];
  static const List<String> gender = ["Cinsiyet", "Gender"];
  static const List<String> profession = ["Meslek", "Profession"];
  static const List<String> monthly_income = ["Aylık Gelir", "Monthly Income"];
  static const List<String> select_a_profession = ["Meslek seç...", "Select a profession..."];
  static const List<String> select_a_city = ["İl seç...", "Select a city..."];
  static const List<String> select_a_currency = ["Döviz cinsi seç...", "Select a currency type..."];
  static const List<String> select_a_billing_day = ["Kesim günü seç...", "Select a billing day..."];
  static const List<String> select_a_date = ["Tarih seç...", "Select a date..."];
  static const List<String> select_a_card_type = ["Kart türü seç...", "Select a card type..."];
  static const List<String> select_an_account = ["Hesap seç...", "Select an account..."];
  static const List<String> select_a_district = ["İlçe seç...", "Select a district..."];
  static const List<String> select_a_gender = ["Cinsiyet seç...", "Select a gender..."];
  static const List<String> email_is_invalid = ["Email adresi geçerli değil.", "Email address is invalid."];
  static const List<String> date_is_invalid = ["Tarih geçerli değil.", "Date is invalid."];
  static const List<String> home = ["Ana Sayfa", "Home"];
  static const List<String> all_transactions = ["Tüm İşlemler", "All Transactions"];
  static const List<String> account_no = ["Hesap Numarası", "Account Number"];
  static const List<String> sender_account = ["Gönderen Hesap", "Sender Account"];
  static const List<String> namesurname = ["Ad Soyad", "Name Surname"];
  static const List<String> recipient = ["Alıcı", "Recipient"];
  static const List<String> phoneno_is_invalid = ["Telefon no geçerli değil.", "Phone no is invalid."];
  static const List<String> view_all_transactions = ["Tüm İşlemleri Görüntüle", "View All Transactions"];
  
  static const List<String> approve = ["Onay", "Approve"];
  static const List<String> nevermind = ["Vazgeç", "Nevermind"];
  static const List<String> my_accounts = ["Hesaplarım", "My Accounts"];
  static const List<String> clear = ["Temizle", "Clear"];
  static const List<String> filter = ["Filtrele", "Filter"];
  static const List<String> my_cards = ["Kartlarım", "My Cards"];
  static const List<String> settings = ["Ayarlar", "Settings"];
  static const List<String> log_out = ["Çıkış yap", "Log out"];
  static const List<String> currency_type = ["Döviz Cinsi", "Currency Type"];
  static const List<String> open_an_account = ["Hesap Aç", "Open An Account"];
  static const List<String> card_application = ["Kart Başvurusu", "Card Application"];
  static const List<String> approve_application = ["Başvuruyu Onayla", "Approve Application"];
  static const List<String> card_type = ["Kart Türü", "Card Type"];
  static const List<String> billing_day = ["Kesim Günü", "Billing Day"];
  static const List<String> requested_limit = ["Talep Edilen Limit", "Requested Limit"];
  static const List<String> amount = ["Miktar", "Amount"];
  static const List<String> lowest_amount = ["En Düşük Miktar", "Lowest Amount"];
  static const List<String> highest_amount = ["En Yüksek Miktar", "Highest Amount"];
  static const List<String> transaction_date = ["İşlem Tarihi", "Transaction Date"];
  static const List<String> start_date = ["Başlangıç Tarihi", "Start Date"];
  static const List<String> end_date = ["Bitiş Tarihi", "End Date"];
  static const List<String> incoming = ["Gelen", "Incoming"];
  static const List<String> outgoing = ["Giden", "Outgoing"];
  static const List<String> account_added = ["Hesap başarıyla oluşturuldu. Ana sayfada 'Hesaplarım' arasında görebilirsin.", "Account created successfully. You can see it under 'My Accounts' on the main page."];
  static const List<String> card_approved = ["Kart başvurun onaylandı. Ana sayfada 'Kartlarım' arasında görebilirsin.", "Your card application approved. You can see it under 'My Cards' on the main page."];
  static const List<String> balance = ["Bakiye", "Balance"];
    static const List<String> send_postdated = ["İleri Tarihli Gönder", "Send Postdated"];
    static const List<String> transaction_queued = ["İşlemin sıraya alındı.", "Your process has been queued."];
    static const List<String> no_credit_card = ["Henüz bir kredi kartın yok. 'Tüm İşlemler' menüsünden kart başvurusunda bulunabilirsin.", 
"You don't have a credit card yet. You can apply for one from the 'All Transactions' menu."];
  static const List<String> outstanding_balance = ["Kullanılabilir Limit", "Outstanding Balance"];
  static const List<String> customer_will_logged_out_to_change = ["Müşteri değiştirmek için güncel müşteriden çıkış yapılacaktır. Onaylıyor musun?", "To change a customer, the current customer will be logged out. Do you approve?"];
  static const List<String> customer_will_logged_out = ["Müşteriden çıkış yapılacaktır. Onaylıyor musun?", "The current customer will be logged out. Do you approve?"];
  static const List<String> customer_will_logged_out_to_create_new = ["Yeni müşteri oluşturmak için güncel müşteriden çıkış yapılacaktır. Onaylıyor musun?", "To create a new customer, the current customer will be logged out. Do you approve?"];
  static const List<String> this_field_cannot_be_left_empty = ["Bu alan boş bırakılamaz.", "This field cannot be left empty."];
  static const List<String> identity_no_must_be_11_char_long = ["'T.C. Kimlik No' 11 karakter olmalı.", "'Identity No' must be 11 characters long."];
  static const List<String> no_customers_matching_entered_information = ["Girilen bilgilerle eşleşen müşteri bulunamadı.", "No customers matching the entered information were found."];

  static String Get(List<String> list){
    return list[index];
  }
}