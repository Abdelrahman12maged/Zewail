import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('من نحن'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logof.png',
                  width: 150.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  'معلومات عنا',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  '''مؤسسة روزويل التعليمية هي مؤسسة تعليمية وتدريبية تأسست في عام 2009. تختص المؤسسة في تقديم خدمات التعليم والتدريب عبر مجموعة متنوعة من البرامج والدورات التعليمية. تهدف روزويل إلى تحقيق التميز في مجال التعليم وتمكين الطلاب والمحترفين من تطوير مهاراتهم ومعرفتهم.

منذ تأسيسها وحتى اليوم، تميزت مؤسسة روزويل بالجودة والاعتمادية في تقديم برامجها التعليمية. وقد قامت ببناء سمعة قوية في مجالات مثل التعليم العالي، والتدريب المهني، والتطوير الشخصي.

بفضل خبرتها واهتمامها بتلبية احتياجات الطلاب والمتعلمين، استطاعت مؤسسة روزويل أن تحقق نجاحاً ملحوظاً في مجال التعليم والتدريب، وتستمر في تقديم خدماتها المميزة لمساعدة الأفراد على تحقيق أهدافهم التعليمية والمهنية.''',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
