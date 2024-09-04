// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class Localizer
{
  static int index = 0;
  static const List<String> index_text = ["EN", "TR"];
  
  static const List<String> qr_code_operations = ["Karekod İşlemleri", "QR Code Operations"];
  static const List<String> login = ["Giriş Yap", "Login"];
  static const List<String> notifications = ["Bildirimler", "Notifications"];
  static const List<String> credit_calculation = ["Kredi Hesaplama", "Credit Calculation"];
  static const List<String> market_information = ["Piyasa Bilgileri", "Market Information"];
  static const List<String> i_want_to_be_a_customer = ["Müşteri olmak istiyorum", "I want to be a customer"];
  static const List<String> did_you_forget_your_password = ["Şifreni mi unuttun?", "Did you forget your password?"];
  static const List<String> change_customer = ["Müşteri değiştir", "Change customer"];
  static const List<String> welcome___with_comma = ["Hoşgeldin, ", "Welcome, "];
  static const List<String> remaining_attempts = ["Kalan deneme hakkı: ", "Remaining attempts: "];
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
  static const List<String> select_a_district = ["İlçe seç...", "Select a district..."];
  static const List<String> select_a_gender = ["Cinsiyet seç...", "Select a gender..."];
  static const List<String> email_is_invalid = ["Email adresi geçerli değil.", "Email address is invalid."];
  static const List<String> home = ["Ana Sayfa", "Home"];
  static const List<String> all_transactions = ["Tüm İşlemler", "All Transactions"];
  static const List<String> phoneno_is_invalid = ["Telefon no geçerli değil.", "Phone no is invalid."];
  
  static const List<String> approve = ["Onay", "Approve"];
  static const List<String> nevermind = ["Vazgeç", "Nevermind"];
  static const List<String> my_accounts = ["Hesaplarım", "My Accounts"];
  static const List<String> my_cards = ["Kartlarım", "My Cards"];
  static const List<String> log_out = ["Çıkış yap", "Log out"];
  static const List<String> currency_type = ["Döviz Cinsi", "Currency Type"];
  static const List<String> balance = ["Bakiye", "Balance"];
  static const List<String> available_limit = ["Kullanılabilir Limit", "Available Limit"];
  static const List<String> customer_will_logged_out_to_change = ["Müşteri değiştirmek için güncel müşteriden çıkış yapılacaktır. Onaylıyor musun?", "To change a customer, the current customer will be logged out. Do you approve?"];
  static const List<String> customer_will_logged_out_to_create_new = ["Yeni müşteri oluşturmak için güncel müşteriden çıkış yapılacaktır. Onaylıyor musun?", "To create a new customer, the current customer will be logged out. Do you approve?"];
  static const List<String> this_field_cannot_be_left_empty = ["Bu alan boş bırakılamaz.", "This field cannot be left empty."];
  static const List<String> identity_no_must_be_11_char_long = ["'T.C. Kimlik No' 11 karakter olmalı.", "'Identity No' must be 11 characters long."];
  static const List<String> no_customers_matching_entered_information = ["Girilen bilgilerle eşleşen müşteri bulunamadı.", "No customers matching the entered information were found."];

  static String Get(List<String> list){
    return list[index];
  }
}