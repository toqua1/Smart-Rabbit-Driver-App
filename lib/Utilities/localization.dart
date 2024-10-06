import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  static const Locale fallbackLocale = Locale('en', 'US');
  static const String languageCodeKey = 'language_code';

  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(languageCodeKey);

    if (langCode != null && locales.containsKey(langCode)) {
      Get.updateLocale(locales[langCode]!);
    } else {
      Get.updateLocale(fallbackLocale); // Set to default locale
    }
  }

  static final Map<String, Locale> locales = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', 'EG'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Recieved From Warehouse':'Recieved From Warehouse',
          'Received From Warehouse Done':'Received From Warehouse Done',
          'Received From Warehouse':'Received From Warehouse',
          'Don\'t forget to get delivery price only from store':'Don\'t '
              'forget to get delivery price only from store',
          'Don\'t forget to get total order price from receiver':'Don\'t '
              'forget to get total order price from receiver',

          'Error retrieving location:':'Error retrieving location:',
          'Show Location':'Show Location',
          'No coordinates found for this address.':'No coordinates found for '
              'this address.',
          'Back To Warehouse Done':'Back To Warehouse Done',
          'Cancelled':'Cancelled',

          'Notes':'Notes',
          'Enter your notes':'Enter your notes',
          'Sorry this service is not available':'Sorry this service is not '
              'available',
          'Select Number':'Select Number',
          'Received Done':'Received Done',
          'Shipped Done':'Shipped Done',
          'Transferred Done':'Transferred Done',
          'Completed Done':'Completed Done',
          'Recieved':'Recieved',
          'Wallet is not available at Pickup role':'Wallet is not available '
              'at Pickup role',

          'Tracking Date':'Tracking Date',
          'No Dates Mentioned':'No Dates Mentioned',
          'QR Code Scanner':'QR Code Scanner',
          'QR Code scan successful':'QR Code scan successful',

          'Good Afternoon':'Good Afternoon',
          'Good Evening':'Good Evening',
          'Good Night':'Good Night',
          'Invalid QR code':'Invalid QR code',
          // wallet screen
          'Pick Up':'Pick Up',
          'Drop Off':'Drop Off',
          'Yesterday':'Yesterday',
          'Tomorrow':'Tomorrow',

          'Order status updated to':'Order status updated to',
          'Failed to update order':'Failed to update order',
          'Assigned':'Assigned',
          'Received':'Received',
          'Shipped':'Shipped',
          'Transfered':'Transfered',
          'Complete':'Complete',

          'Close':'Close',
          'Store':'Store',
          'Order Details':'Order Details',
          'Name':'Name',
          'Phone Number':'Phone Number',
          'Address':'Address',
          'Total':'Total',
          'Payment Method':'Payment Method',
          'Transaction & Track ID':'Transaction & Track ID',

          'Wallet History':'Wallet History',
          'Available balance': 'Available balance',
          'Search...':'Search...',
          'Tracking ID':'Tracking ID',
          'Today':'Today',
          'Search':'Search',
          'No recent searches':'No recent searches',
          'Not Found': 'Not Found',
          'Sorry the keyword you entered cannot be '
              'found. Please check again or search with another keyword.': 'Sorry the keyword you entered cannot be '
  'found. Please check again or search with another keyword.',
          'Recent':'Recent',
          'Clear All':'Clear All',
        'Results for ':'Results for ',
          'found ':'found ',
          'Enter Order ID':'Enter Order ID',
          'No orders available':'No orders available',

        // store information
          'Address is required':'Address is required',
          'Phone Number is required':'Phone Number is required',
          'Please upload required images. ':'Please upload required images. ',
          'Order status updated to Complete':'Order status updated to Complete',
          'Failed to update order status':'Failed to update order status',
          // nav bar
          'Home':'Home',
          'Scan':'Scan',
          'Wallet':'Wallet',
          // drawer
          'Account':'Account',
          'Notification':'Notification',
          'Order History':'Order History',
          'Incentives':'Incentives',
          'Performance':'Performance',
          'Safety':'Safety',
          'Comments':'Comments',
          'Privacy Policy':'Privacy Policy',
          'Settings':'Settings',
          'Logout':'Logout',
          // order summary
          'Successfully sent':'Successfully sent',
          'Successfully received': 'Successfully received',
          // region
          'In which region?':'In which region?',

          // account status
          'Continue As':'Continue As',
          'Drop off':'Drop off',
          'Pick up':'Pick up',
          'Pick up & Drop off':'Pick up & Drop off',
          'Save':'Save',
          'Done':'Done',
          'Error':'Error',
          'Success':'Success',
          'Sign Up failed, Try again!':'Sign Up failed, Try again!',
          'Fill all fields!':'Fill all fields!',
          // create pass page
          'Sign Up':'Sign Up',
          "   Create \n Password":"   Create \n Password",
          'Continue':'Continue',
          'Please fill empty field':'Please fill empty field',

          'Package Information':'Package Information',
          'Pickup Location':'Pickup Location',
          'Parcel Type':'Parcel Type',
          'Delivery Charge':'Delivery Charge',
          'SAR':'SAR',
          'Payment':'Payment',
          'Cash':'Cash',
          'Online':'Online',
          'Unavailable':'Unavailable',
          'Online payment is currently not available.':'Online payment is currently not available.',
          'Wallet payment is currently not available.':'Wallet payment is '
              'currently not available.',
          'Payment collect from':'Payment collect from',
          'Pick location': 'Pick location',
          'Please tap on location icon to get your address':'Please tap on location icon to get your'
              ' address',
          'Address Details':'Address Details',
          'Address Name':'Address Name',

          'Barcode Scanner':'Barcode Scanner',
          'Open Scanner':'Open Scanner',
          'Barcode Result':'Barcode Result',
          'Details':'Details',
          'Barcode scan successful':'Barcode scan successful',


          'Edit Profile': 'Edit Profile',

          'Change Password': 'Change Password',
          'Change Language': 'Change Language',
          'Security': 'Security',
          'Help Center': 'Help Center',
          'Hi': 'Hi',
          'Good Morning':'Good Morning',
          'Feel Free using our services': 'Feel Free using our services',
          'My Order': 'My Order',
          'Create Order': 'Create Order',
          'Track Order': 'Track Order',
          'My Account': 'My Account',
          'Reports': 'Reports',
          'greeting': 'Hi, @username👋',
          'Completed Orders': 'Completed Orders',
          'Cash Orders': 'Cash Orders',
          'Orders Visa': 'Orders Visa',
          'Wallet Orders': 'Wallet Orders',
          'Pending Withdraw': 'Pending Withdraw',
          'Cancelled Orders': 'Cancelled Orders',
          'My Orders': 'My Orders',
          'ongoing': 'ongoing',
          'completed': 'completed',
          'Ongoing': 'Ongoing',
          'Completed': 'Completed',
          'All': 'All',
          'Pick Time': 'Pick Time',
          'Parcel Weight': 'Parcel Weight',
          'parcels type': 'parcels type',
          'Your Location': 'Your Location',
          'Contact Number': 'Contact Number',
          'Another Number': 'Another Number',
          'Description': 'Description',
          'Receiver Name': 'Receiver Name',
          'Next': 'Next',
          'Date': 'Date',
          'To': 'To',
          'From': 'From',
          'weight': 'weight',
          'Please enter your phone number to continue':
              'Please enter your phone number to continue',
          'Please fill the field': 'Please fill the field',
          'Location': 'Location',
          'Delivery Location': 'Delivery Location',
          'Delivery Contact Number': 'Delivery Contact Number',
          'Another Delivery Number': 'Another Delivery Number',
          'Enter phone number.': 'Enter phone number.',

          // Added texts for ForgotPassword screen
          'Reset Password': 'Reset Password',
          'Please enter your email address to reset password':
              'Please enter your email address to reset password',
          'Email Address': 'Email Address',
          'Please enter your email address': 'Please enter your email address',
          'Send Email': 'Send Email',
          'Email sent successfully': 'Email sent successfully',
          'Sorry, User Not Found': 'Sorry, User Not Found',

          // Added texts for OtpScreen
          'Please enter the OTP sent to your email':
              'Please enter the OTP sent to your email',
          'OTP Verified Successfully': 'OTP Verified Successfully',
          'Oops...': 'Oops...',
          'Invalid OTP': 'Invalid OTP',
          // Added texts for ChangePasswordScreen
          'Please enter your new password': 'Please enter your new password',
          'Password': 'Password',
          'Please confirm your new password':
              'Please confirm your new password',
          'Confirm Password': 'Confirm Password',
          'Password changed successfully': 'Password changed successfully',
          'Password don\'t match': 'Password don\'t match',
          'Change password': 'Change password',
          // Added texts for BioDataPage
          "What's Your Name?": "What's Your Name?",
          "Fill Your FULL NAME correctly": "Fill Your FULL NAME correctly",
          "Full Name": "Full Name",
          'Full Name is required':'Full Name is required',
          "Please enter username": "Please enter username",
          'Invalid Mobile Number':  'Invalid Mobile Number',

          "Create Account": "Create Account",
          "Submit": "Submit",
          "Account created successfully": "Account created successfully",
          "Sorry, something went wrong": "Sorry, something went wrong",

          "Create Password": "Create Password",
          "Set a secure password for your account":
              "Set a secure password for your account",

          "Store Information": "Store Information",
          "Save your important information securely.":
              "Save your important information securely.",
          "National ID Number": "National ID Number",
          "National ID": "National ID",
          "Tax Number": "Tax Number",
          "Product Type": "Product Type",
          "National ID Card (front)": "National ID Card (front)",
          "National ID Card (back)": "National ID Card (back)",
          "Tax Number Photo": "Tax Number Photo",
          "Commercial Register Photo": "Commercial Register Photo",
          "Please enter National ID": "Please enter National ID",
          "Please enter Tax Number": "Please enter Tax Number",
          "Please enter Product Type": "Please enter Product Type",
          'Upload National ID Face':'Upload National ID Face',
          'Upload National ID Back':'Upload National ID Back',
          'Upload driving license':'Upload driving license',

          "What's Your Email?": "What's Your Email?",
          "Fill Your EMAIL correctly": "Fill Your EMAIL correctly",
          "Email": "Email",
          "Please enter email": "Please enter email",
          'Fill email correctly.':'Fill email correctly.',

          'landing_welcome': 'Yo! Welcome to smart rabbit',
          'landing_login_prompt': 'Login to get started with our services',
          'landing_continue_google': 'Continue with Google',
          'landing_continue_facebook': 'Continue with Facebook',
          'landing_continue_apple': 'Continue with Apple',
          'landing_or_login': 'or login with',
          'landing_login_now': 'Login now',
          'landing_register_prompt': "Don't have an account? Register now",

          'login_title': 'Login',
          'login_prompt': 'Please login to use our services',
          'login_password': 'Password',
          'login_password_hint': 'Please enter password',
          'login_forgot_password': 'Forgot Your Password?',
          'login_button': 'Login',
          'login_no_account_prompt': "Don't have an account? ",
          'login_register_now': 'Register now',
          'login_success': 'Logged in',
          'login_error_title': 'Oops...',
          'login_error_message': 'Sorry, something went wrong',
        },
        'ar_EG': {
          'Error retrieving location:':'خطأ في استرداد الموقع:',
          'Show Location':'إظهار الموقع',
          'No coordinates found for this address.':'لم يتم العثور على إحداثيات لهذا العنوان.',
          'Back To Warehouse Done':'تم الإعادة الي المستودع',
          'Cancelled':'تم الإلغاء',
          'Recieved From Warehouse':'تم الاستلام من المستودع',
          'Received From Warehouse Done':'تم الاستلام من المستودع',
          'Received From Warehouse':'تم الاستلام من المستودع',
          'Don\'t forget to get delivery price only from store':'لا تنسي '
              'الحصول على سعر التوصيل من المتجر فقط',
          'Don\'t forget to get total order price from receiver':'لا تنسي '
              'الحصول على السعر الإجمالي للطلب من المتلقي',

          'Notes':'ملاحظات',
          'Enter your notes':'ادخل ملاحظاتك',
  'Sorry this service is not available':'عفوا هذه الخدمة ليست متوفرة حاليا',
          'Select Number':'اختر رقم',
          'Received Done':'تم الاستلام من المتجر',
          'Shipped Done':'تم الشحن الي المخزن',
          'Transferred Done':'تم النقل من المخزن',
          'Completed Done':'تم الشحن الي العميل',
          'Recieved':'تم النقل من المتجر',
  'Wallet is not available at Pickup role':'المحفظة غير متاحة في وظيفة '
      'الاستلام',
          'Tracking Date':'تاريخ التتبع',
          'No Dates Mentioned':'لم يتم ذكر تواريخ',
          'QR Code Scanner':' الماسح الضوئي ',
          'QR Code scan successful':'تم مسح الرمز بنجاح',

          'Good Afternoon':'مساء الخير',
          'Good Evening':'مساء الخير',
          'Good Night':'طاب مساؤك',
          'Invalid QR code':'رمز الاستجابة السريعة غير صالح',
          // wallet screen
          'Yesterday':'أمس',
          'Tomorrow':'غداً',
          'Pick Up':'الاستلام',
          'Drop Off':'التوصيل',
          'Order status updated to':' تحديث حالة الطلب إلى',
          'Failed to update order':'فشل في تحديث الطلب الي',
          'Assigned':'قيد الانتظار',
          'Received':'تم النقل من المتجر  ',
          'Shipped':'تم الشحن الي المخزن',
          'Transfered':' تم النقل من المخزن',
          'Complete':'تم الشحن بنجاح',

          'Close':'اغلق',
          'Store':'المتجر',
          'Order Details':'تفاصيل الطلب',
          'Name':'الاسم',
          'Address':'العنوان',
          'Payment Method':'طريقة الدفع',
          'Transaction & Track ID':'الرقم التعريفي',
          'Wallet History':'سجل المحفظة',
          'Available balance': 'الرصيد المتوفر',
          'Search...':'بحث ....',
          'Tracking ID':'رقم التتبع',
          'Today':'اليوم',
          'Search':'البحث',
          'No recent searches':'لا توجد عمليات بحث حديثة',
          'Not Found': 'لم يتم العثور عليه',
          'Sorry the keyword you entered cannot be '
              'found. Please check again or search with another keyword.': 'عذراً، لم يتم العثور على الكلمة الرئيسية التي أدخلتها. يرجى التحقق مرة أخرى أو البحث باستخدام كلمة رئيسية أخرى.',
          'Recent':'مؤخرًا',
          'Clear All':'مسح الكل',
          'Results for ':'نتائج لـ ',
          'found ':'وجد ',
          'Enter Order ID':'أدخل معرف الطلب',
          'No orders available':'لا توجد طلبات متاحة',
          'SAR':'ريال سعودي',

          // store information
          'Address is required':'العنوان مطلوب',
          'Phone Number is required':'رقم الهاتف مطلوب',
          'Please upload required images. ':'برجاء تحميل الصور المطلوبة',
          'Order status updated to Complete':'تم تحديث حالة الطلب إلى مكتمل',
          'Failed to update order status':'فشل في تحديث حالة الطلب',
          // nav bar
          'Home':'الصفحة الرئيسية',
          'Scan':'الماسح الضوئى',
          'Wallet':'المحفظة',
          // drawer
          'Account':'الحساب الشخصي',
          'Notification':'الإشعارات',
          'Order History':'سجل الطلبات',
          'Incentives':'الحوافز',
          'Performance':'الأداء',
          'Safety':'الأمان',
          'Comments':'التعليقات',
          'Privacy Policy':'سياسة الخصوصية',
          'Settings':'الإعدادات',
          'Logout':'تسجيل خروج',
          // order summary
          'Successfully sent':'تم الإرسال بنجاح',
          'Successfully received': 'تم الاستلام بنجاح',
          // region
          'In which region?':'في أي منطقة؟',

          // account status
          'Continue As':'استمر ك',
          'Drop off':'تسليم فقط',
          'Pick up':'استلام فقط',
          'Pick up & Drop off':'استلام و تسليم',
          'Save':'حفظ',
          'Error':'خطأ',
          'Done':'انتهي',
          'Success':'تمت العملية بنجاح',
          'Sign Up failed, Try again!':'!فشل التسجيل، حاول مرة اخري',
          'Fill all fields!':'! إملأ كل الخانات',
          // create pass page
          'Sign Up':'تسجيل الدخول',
          "   Create \n Password":" قم بتعيين\nكلمة مرور   ",
          'Continue':'استمر',
          'Please fill empty field':'إملأ الخانات الفارغه',

          'Barcode Scanner':'ماسح الباركود',
          'Open Scanner':'افتح الماسح الضوئي',
          'Barcode Result':'نتيجة الباركود',
          'Details':'تفاصيل',
          'Barcode scan successful':'تم مسح الباركود بنجاح',

          'Package Information':'معلومات الطرد',
          'Pickup Location':'مكان الاستلام',
          'Parcel Type':'نوع الطرد',
          'Delivery Charge':'رسوم الشحن',
          'Total':'السعر الكلي',
          'Payment':'طريقة الدفع',
          'Cash':'كاش',
          'Online':'اونلاين',
          'Unavailable':'غير متوفر',
          'Online payment is currently not available.':'الدفع اونلاين غير متاح '
              'حاليًا.',
          'Wallet payment is currently not available.':'الدفع عبر المحفظة غير '
              'متاح حاليًا.',
          'Payment collect from':'تحصيل الدفع من',
          'Pick location': 'موقع التحصيل',

          'Please tap on location icon to get your address':'الرجاء الضغط على أيقونة الموقع للحصول على عنوانك',
          'Address Details':'تفاصيل العنوان',
          'Address Name':'اسم العنوان',


          'Edit Profile': 'تعديل الملف الشخصي',

          'Phone Number': 'رقم الهاتف',
          'Change Password': 'تغيير كلمة المرور',
          'Change Language': 'تغيير اللغة',
          'Security': 'الأمان',
          'Help Center': 'مركز المساعدة',
          'Hi': 'مرحباً',
          'Good Morning':'صباح الخير ',
          'Feel Free using our services': 'لا تتردد في استخدام خدماتنا',
          'My Order': 'طلباتي',
          'Create Order': 'إنشاء طلب',
          'Track Order': 'تتبع الطلب',
          'My Account': 'حسابي',
          'Reports': 'التقارير',
          'greeting': 'مرحباً، @username👋',
          'Completed Orders': 'الطلبات المكتملة',
          'Cash Orders': 'طلبات نقدية',
          'Orders Visa': 'طلبات فيزا',
          'Wallet Orders': 'طلبات المحفظة',
          'Pending Withdraw': 'السحب المعلق',
          'Cancelled Orders': 'الطلبات الملغاة',
          'My Orders': 'طلباتي',
          'ongoing': 'قيد التنفيذ',
          'completed': 'تم التنفيذ',
          'Ongoing': 'قيد التنفيذ',
          'Completed': 'تم التنفيذ',
          'All': 'الكل',
          'Pick Time': 'وقت الاستلام',
          'Parcel Weight': 'وزن الطرد',
          'parcels type': 'نوع الطرد',
          'Your Location': 'موقعك',
          'Contact Number': 'رقم الاتصال',
          'Another Number': 'رقم آخر',
          'Description': 'الوصف',
          'Receiver Name': 'اسم المستلم',
          'Next': 'التالي',
          'Date': 'التاريخ',
          'To': 'إلى',
          'From': 'من',
          'weight': 'الوزن',
          'Please fill the field': 'يرجى تعبئة الحقل',
          'Location': 'الموقع',
          'Please enter your phone number to continue':
              'الرجاء إدخال رقم هاتفك للمتابعة',
          'Delivery Location': 'موقع التسليم',
          'Delivery Contact Number': 'رقم الاتصال للتسليم',
          'Another Delivery Number': 'رقم تسليم آخر',
          'Enter phone number.': 'أدخل رقم الهاتف.',

          // Added texts for ForgotPassword screen
          'Reset Password': 'إعادة تعيين كلمة المرور',
          'Please enter your email address to reset password':
              'يرجى إدخال عنوان بريدك الإلكتروني لإعادة تعيين كلمة المرور',
          'Email Address': 'عنوان البريد الإلكتروني',
          'Please enter your email address':
              'يرجى إدخال عنوان بريدك الإلكتروني',
          'Send Email': 'إرسال البريد الإلكتروني',
          'Email sent successfully': 'تم إرسال البريد الإلكتروني بنجاح',
          'Sorry, User Not Found': 'عذرًا، المستخدم غير موجود',

          // Added texts for OtpScreen
          'Please enter the OTP sent to your email':
              'يرجى إدخال رمز التحقق الذي أُرسل إلى بريدك الإلكتروني',
          'OTP Verified Successfully': 'تم التحقق من الرمز بنجاح',
          'Oops...': 'عذرًا...',
          'Invalid OTP': 'رمز التحقق غير صحيح',
          // Added texts for ChangePasswordScreen
          'Please enter your new password': 'يرجى إدخال كلمة مرور جديدة',
          'Enter your password':' ادخل كلمة مرور ',
          'Password': 'كلمة المرور',
          'Please confirm your new password': 'يرجى تأكيد كلمة المرور الجديدة',
          'Confirm Password': 'تأكيد كلمة المرور',
          'Password changed successfully': 'تم تغيير كلمة المرور بنجاح',
          'Password don\'t match': 'كلمات المرور غير متطابقة',
          'Change password': 'تغيير كلمة المرور',
          // Added texts for BioDataPage
          "What's Your Name?": "ما هو اسمك؟",
          "Fill Your FULL NAME correctly": "املأ اسمك الكامل بشكل صحيح",
          "Full Name": "الاسم الكامل",
          'Full Name is required':'الاسم كامل مطلوب',
          "Please enter username": "يرجى إدخال اسم المستخدم",
          "Create Account": "إنشاء حساب",
          "Submit": "إرسال",
          "Account created successfully": "تم إنشاء الحساب بنجاح",
          "Sorry, something went wrong": "عذرًا، حدث خطأ ما",

          "Create Password": "إنشاء كلمة المرور",
          "Set a secure password for your account": "حدد كلمة مرور آمنة لحسابك",

          "Store Information": "معلومات المتجر",
          "Save your important information securely.":
              "احفظ معلوماتك الهامة بأمان.",
          "National ID Number": "رقم الهوية الوطنية",
          "National ID": "الهوية الوطنية",
          "Tax Number": "الرقم الضريبي",
          "Product Type": "نوع المنتج",
          "National ID Card (front)": "بطاقة الهوية الوطنية (أمامي)",
          "National ID Card (back)": "بطاقة الهوية الوطنية (خلفي)",
          "Tax Number Photo": "صورة الرقم الضريبي",
          "Commercial Register Photo": "صورة السجل التجاري",
          'Upload National ID Face':'قم بتحميل بطاقة الهوية الوطنية (أمامي) ',
          'Upload National ID Back':'قم بتحميل بطاقة الهوية الوطنية (خلفي)  ',
          'Upload driving license':'قم بتحميل رخصه القيادة',

          "Please enter National ID": "يرجى إدخال رقم الهوية الوطنية",
          "Please enter Tax Number": "يرجى إدخال الرقم الضريبي",
          "Please enter Product Type": "يرجى إدخال نوع المنتج",

          "What's Your Email?": "ما هو بريدك الإلكتروني؟",
          "Fill Your EMAIL correctly": "املأ بريدك الإلكتروني بشكل صحيح",
          "Email": "البريد الإلكتروني",
          "Please enter email": "يرجى إدخال البريد الإلكتروني",
          'Fill email correctly.':'إملأ البريد الإلكتروني بشكل صحيح',
          'Invalid Mobile Number':'رقم غير صحيح',

          'landing_welcome': 'مرحبًا! مرحبًا بك في سمارت رابيت',
          'landing_login_prompt': 'قم بتسجيل الدخول للبدء في استخدام خدماتنا',
          'landing_continue_google': 'الاستمرار مع جوجل',
          'landing_continue_facebook': 'الاستمرار مع فيسبوك',
          'landing_continue_apple': 'الاستمرار مع أبل',
          'landing_or_login': 'أو تسجيل الدخول باستخدام',
          'landing_login_now': 'تسجيل الدخول الآن',
          'landing_register_prompt': 'ليس لديك حساب؟ سجل الآن',

          'login_title': 'تسجيل الدخول',
          'login_prompt': 'يرجى تسجيل الدخول لاستخدام خدماتنا',
          'login_password': 'كلمة المرور',
          'login_password_hint': 'يرجى إدخال كلمة المرور',
          'login_forgot_password': 'هل نسيت كلمة المرور؟',
          'login_button': 'تسجيل الدخول',
          'login_no_account_prompt': 'ليس لديك حساب؟ ',
          'login_register_now': 'سجل الآن',
          'login_success': 'تم تسجيل الدخول',
          'login_error_title': 'عذرًا...',
          'login_error_message': 'عذرًا، حدث خطأ ما',
        },
      };

  void changeLocale(String langCode) async {
    final locale = locales[langCode];
    if (locale != null) {
      Get.updateLocale(locale);

      // Save the selected language in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(languageCodeKey, langCode);
    }
  }

  Locale get currentLocale => Get.locale ?? fallbackLocale;
}
