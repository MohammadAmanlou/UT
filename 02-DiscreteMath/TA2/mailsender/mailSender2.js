function sendScores() {

  var num_drill_q = 2;
  var num_homework_q = 3;
  var num_quize_q = 1;
  var num_class_q = 8 ;

  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet1 = ss.getSheetByName('Student. Info.'); 
  var sheet2 = ss.getSheetByName('Logic.'); 
  var data1 = sheet1.getDataRange().getValues();
  var data2 = sheet2.getDataRange().getValues();
  var unit = ' استقرا' ; // dont forget space after name of unit
  var subject = '  نمرات مبحث' + unit + ' درس ریاضیات گسسته'
  
  for (var i = 1; i < data1.length; i++) {
    var email = data1[i][0];
    var scores = '';
    for (var j = 3; j < data2.length; j+=2) {
      if (data1[i][1] == data2[j][0]) {
        var q = 0;
        scores += '**تمرین مقدماتی:**\n'
        var num_q = 1
        for (q ; q < num_drill_q*2  ; q +=2 ){
          scores += "شماره سوال:"
          scores += num_q
          scores += "\n"
          if (data2[j+1][q + 2] != ""){
            scores += data2[j+1][q + 2] + '\n';
            scores += data2[j+1][q + 3] + '\n';
            if(data2[j+1][q + 3] != ""){
              scores += '\n'
            }
          }
          else{
            scores += 'عدم شرکت.' + '\n\n';
          }
          num_q += 1
        }
        scores += "_____________________________________________\n"
        scores += '**تکلیف پیشرفته:**\n'
        q = q + 3;
        var num_q = 1
        for ( q ; q < num_homework_q*2 + num_drill_q*2 + 3 ; q +=2 ){
          scores += "شماره سوال:"
          scores += num_q
          scores += "\n"
          if ((data2[j+1][q + 2] != "") && (data2[j+1][q + 2] != " ") && (data2[j+1][q + 2] != null)){
            scores += data2[j+1][q + 2] + '\n';
            scores += data2[j+1][q + 3] + '\n';
            if(data2[j+1][q + 3] != ""){
              scores += '\n'
            }
          }
          else{
            scores += 'عدم شرکت.' + '\n\n';
          }
          num_q += 1
        }
        scores += "_____________________________________________\n"
        q = q + 3;
        scores += '**کوئیز:**\n'
        var num_q = 1
        for (q ; q < num_quize_q*2 + num_homework_q*2 + num_drill_q*2 + 6 ; q +=2 ){
          scores += "شماره سوال:"
          scores += num_q
          scores += "\n"
          if ((data2[j+1][q + 2] != "") && (data2[j+1][q + 2] != " ") && (data2[j+1][q + 2] != null)){
            scores += data2[j+1][q + 2] + '\n';
            scores += data2[j+1][q + 3] + '\n';
            if(data2[j+1][q + 3] != ""){
              scores += '\n'
            }
          }
          else{
            scores += 'عدم شرکت.' + '\n\n';
          }
          num_q += 1
        }
        scores += "_____________________________________________\n"
        scores += '**سوالات کلاسی:**\n'
        q = q + 3;
        var num_q = 1
        for (q ; q < num_class_q*2 + num_homework_q*2 + num_drill_q*2 + num_quize_q*2 + 9 ; q +=2 ){
          scores += "شماره سوال:"
          scores += num_q
          scores += "\n"
          if ((data2[j+1][q + 2] != "") && (data2[j+1][q + 2] != " ") && (data2[j+1][q + 2] != null)){
            scores += data2[j+1][q + 2] + '\n';
            scores += data2[j+1][q + 3] + '\n';
            if(data2[j+1][q + 3] != ""){
              scores += '\n'
            }
          }
          else{
            scores += 'عدم شرکت.' + '\n\n';
          }
          num_q += 1
        }
      }
    }
  //     var message = 'نمرات مبحث' + unit + ' ' +
  //  'شما به شرح زیر است:\n\n' + scores + 
  //  'در صورت وجود هرگونه ابهام، با ایمیل دستیار آموزشی مربوط به هر تمرین که در سربرگ تمرین مندرج است، در ارتباط باشید.\n'+
  //   '\nبا آرزوی بهترین ها برای شما ,\nتیم دستیاران آموزشی درس ریاضیات گسسته';
    
    
  //   // var message = 'Dear student,\n\nYour scores are as follows:\n\n' + scores + '\nBest regards,\nYour teacher';
  //   MailApp.sendEmail(email, subject, message);
  }
  var message = 'نمرات مبحث' + unit + ' ' +
  'شما به شرح زیر است:\n\n' + scores + 
  'در صورت وجود هرگونه ابهام، با ایمیل دستیار آموزشی مربوط به هر تمرین که در سربرگ تمرین مندرج است، در ارتباط باشید.\n'+
   '\nبا آرزوی بهترین ها برای شما ,\nتیم دستیاران آموزشی درس ریاضیات گسسته';
  
  MailApp.sendEmail("mohammadamanlou2@gmail.com", subject, message);
}