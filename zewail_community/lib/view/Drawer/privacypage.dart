import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: PrivacyPolicyContent(),
      ),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double fontSize =
            screenWidth > 600 ? 18 : 14; // Adjust values as needed

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy of http://rozewail.com/',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text("""Privacy Policy of http://rozewail.com/
At Rozewail, we collect and manage user data according to the following Privacy Policy.

Data Collected
We collect information you provide directly to us. For example, we collect information when you create an account, subscribe, participate in any interactive features of our services, fill out a form, request customer support or otherwise communicate with us. The types of information we may collect include your name, email address, postal address, credit card information and other contact or identifying information you choose to provide.

We collect anonymous data from every visitor of the Website to monitor traffic and fix bugs. For example, we collect information like web requests, the data sent in response to such requests, the Internet Protocol address, the browser type, the browser language, and a timestamp for the request.

We also use various technologies to collect information, and this may include sending cookies to your computer. Cookies are small data files stored on your hard drive or in your device memory that helps us to improve our services and your experience, see which areas and features of our services are popular and count visits. We may also collect information using web beacons (also known as "tracking pixels"). Web beacons are electronic images that may be used in our services or emails and to track count visits or understand usage and campaign effectiveness. Our Privacy Policy was created with the help of the Privacy Policy Template and the Generate Privacy Policy Generator.

Use of the Data
We only use your personal information to provide you the Rozewail services or to communicate with you about the Website or the services.

We employ industry standard techniques to protect against unauthorized access of data about you that we store, including personal information.

We do not share personal information you have provided to us without your consent, unless:

Doing so is appropriate to carry out your own request
We believe it's needed to enforce our legal agreements or that is legally required
We believe it's needed to detect, prevent or address fraud, security or technical issues
Sharing of Data
We don't share your personal information with third parties. Aggregated, anonymized data is periodically transmitted to external services to help us improve the Website and service.

We may allow third parties to provide analytics services. These third parties may use cookies, web beacons and other technologies to collect information about your use of the services and other websites, including your IP address, web browser, pages viewed, time spent on pages, links clicked and conversion information.

We also use social buttons provided by services like Twitter, Google+, LinkedIn and Facebook. Your use of these third party services is entirely optional. We are not responsible for the privacy policies and/or practices of these third party services, and you are responsible for reading and understanding those third party services' privacy policies.

Cookies
We may use cookies on our site to remember your preferences.

For more general information on cookies, please read "What Are Cookies".

Opt-Out, Communication Preferences
You may modify your communication preferences and/or opt-out from specific communications at any time. Please specify and adjust your preferences.

Security
We take reasonable steps to protect personally identifiable information from loss, misuse, and unauthorized access, disclosure, alteration, or destruction. But, you should keep in mind that no Internet transmission is ever completely secure or error-free. In particular, email sent to or from the Sites may not be secure.

About Children
The Website is not intended for children under the age of 13. We do not knowingly collect personally identifiable information via the Website from visitors in this age group.

Changes to the Privacy Policy
We may amend this Privacy Policy from time to time. Use of information we collect now is subject to the Privacy Policy in effect at the time such information is used.

If we make major changes in the way we collect or use information, we will notify you by posting an announcement on the Website or sending you an email.

سياسة الخصوصية الخاصة بـ http://rozewail.com/
في Rozewail, نجمع بيانات المستخدم ونديرها وفقًا لسياسة الخصوصية التالية.

البيانات المجمعة
نقوم بجمع المعلومات التي تقدمها لنا مباشرة. على سبيل المثال ، نقوم بجمع المعلومات عند إنشاء حساب أو الاشتراك أو المشاركة في أي ميزات تفاعلية لخدماتنا أو ملء نموذج أو طلب دعم العملاء أو التواصل معنا بأي طريقة أخرى. تشمل أنواع المعلومات التي قد نجمعها اسمك وعنوان بريدك الإلكتروني وعنوانك البريدي ومعلومات بطاقة الائتمان وغيرها من معلومات الاتصال أو التعريف التي تختار تقديمها.

نقوم بجمع بيانات مجهولة المصدر من كل زائر للموقع لمراقبة حركة المرور وإصلاح الأخطاء. على سبيل المثال ، نقوم بجمع معلومات مثل طلبات الويب والبيانات المرسلة استجابة لهذه الطلبات وعنوان بروتوكول الإنترنت ونوع المتصفح ولغة المتصفح والطابع الزمني للطلب.

نستخدم أيضًا تقنيات مختلفة لجمع المعلومات ، وقد يشمل ذلك إرسال ملفات تعريف الارتباط إلى جهاز الكمبيوتر الخاص بك. ملفات تعريف الارتباط هي ملفات بيانات صغيرة مخزنة على محرك الأقراص الثابتة لديك أو في ذاكرة جهازك والتي تساعدنا على تحسين خدماتنا وتجربتك ، ومعرفة المجالات والميزات الخاصة بخدماتنا الشائعة وعدد الزيارات قد نقوم أيضًا بجمع المعلومات باستخدام إشارات الويب (المعروفة أيضًا باسم "بكسل التتبع"). إشارات الويب هي صور إلكترونية يمكن استخدامها في خدماتنا أو رسائل البريد الإلكتروني الخاصة بنا ولتتبع عدد الزيارات أو فهم الاستخدام وفعالية الحملة. تم إنشاء سياسة الخصوصية الخاصة بنا بمساعدة نموذج سياسة الخصوصية و إنشاء منشئ نهج الخصوصية .

استخدام البيانات
نحن نستخدم معلوماتك الشخصية فقط لتزويدك بـ Rozewailالخدمات أو للتواصل معك حول الموقع أو الخدمات.

نحن نستخدم تقنيات قياسية في الصناعة للحماية من الوصول غير المصرح به لبياناتك التي نقوم بتخزينها ، بما في ذلك المعلومات الشخصية.

يعد القيام بذلك مناسبًا لتنفيذ طلبك الخاص
نعتقد أنه ضروري لتنفيذ اتفاقياتنا القانونية أو أن ذلك مطلوب قانونيًا
نعتقد أنه ضروري لاكتشاف أو منع أو معالجة الاحتيال أو الأمان أو المشكلات الفنية
لا نشارك المعلومات الشخصية التي قدمتها إلينا دون موافقتك ، إلا إذا:
مشاركة البيانات
لا نشارك معلوماتك الشخصية مع جهات خارجية. يتم إرسال البيانات المجمعة مجهولة المصدر بشكل دوري إلى خدمات خارجية لمساعدتنا في تحسين موقع الويب والخدمة.
قد نسمح لأطراف ثالثة بتقديم خدمات تحليلية. قد تستخدم هذه الأطراف الثالثة ملفات تعريف الارتباط وإشارات الويب والتقنيات الأخرى لجمع معلومات حول استخدامك للخدمات ومواقع الويب الأخرى ، بما في ذلك عنوان IP الخاص بك ، ومتصفح الويب ، والصفحات التي تم عرضها ، والوقت الذي تقضيه على الصفحات ، والروابط التي تم النقر فوقها ، ومعلومات التحويل.
نستخدم أيضًا الأزرار الاجتماعية التي توفرها خدمات مثل Twitter و Google+ و LinkedIn و Facebook. يعد استخدامك لخدمات الجهات الخارجية هذه اختياريًا تمامًا. نحن لسنا مسؤولين عن سياسات الخصوصية و / أو الممارسات الخاصة بخدمات الطرف الثالث هذه ، وأنت مسؤول عن قراءة وفهم سياسات خصوصية خدمات الطرف الثالث هذه.
ملفات تعريف الارتباط
قد نستخدم ملفات تعريف الارتباط على موقعنا لتذكر تفضيلاتك.

لمزيد من المعلومات العامة حول ملفات تعريف الارتباط ، يرجى قراءة "ما المقصود بملفات تعريف الارتباط" .

إلغاء الاشتراك ، تفضيلات الاتصال
يجوز لك تعديل تفضيلات الاتصال و / أو إلغاء الاشتراك من اتصالات معينة في أي وقت. يرجى تحديد وتعديل تفضيلاتك.
الأمان
نتخذ خطوات معقولة لحماية معلومات التعريف الشخصية من الضياع أو سوء الاستخدام أو الوصول غير المصرح به أو الكشف أو التغيير أو الإتلاف. ولكن ، يجب أن تضع في اعتبارك أنه لا يوجد نقل عبر الإنترنت آمن تمامًا أو خالٍ من الأخطاء. على وجه الخصوص ، قد لا يكون البريد الإلكتروني المرسل من أو إلى المواقع آمنًا.
نتخذ خطوات معقولة لحماية معلومات التعريف الشخصية من الضياع أو سوء الاستخدام أو الوصول غير المصرح به أو الكشف أو التغيير أو الإتلاف. ولكن ، يجب أن تضع في اعتبارك أنه لا يوجد نقل عبر الإنترنت آمن تمامًا أو خالٍ من الأخطاء. على وجه الخصوص ، قد لا يكون البريد الإلكتروني المرسل من أو إلى المواقع آمنًا.
حول الأطفال
الموقع الإلكتروني غير مخصص للأطفال الذين تقل أعمارهم عن 13 عامًا. نحن لا نجمع عن قصد معلومات التعريف الشخصية عبر موقع الويب من الزائرين في هذه الفئة العمرية.
التغييرات في سياسة الخصوصية
يجوز لنا تعديل سياسة الخصوصية هذه من وقت لآخر. يخضع استخدام المعلومات التي نجمعها الآن لسياسة الخصوصية السارية وقت استخدام هذه المعلومات.
إذا أجرينا تغييرات كبيرة في الطريقة التي نجمع بها المعلومات أو نستخدمها ، فسنخطرك عن طريق نشر إعلان على موقع الويب أو إرسال بريد إلكتروني إليك.""")
          ],
        );
      },
    );
  }
}
