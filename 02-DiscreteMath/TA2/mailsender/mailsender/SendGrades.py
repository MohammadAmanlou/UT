#!/usr/bin/env python
# coding: utf-8

# In[1]:


import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from tqdm.notebook import tqdm

class MailSender :
    def __init__(self, sender_address, sender_pass) :
        self.sender_address = sender_address
        self.sender_pass = sender_pass
        self.fixed_title = False
        self.fixed_msg = False
        self.fixed_file_name = False
        self.fixed_file_addr = False
        self.title = ''
        self.msg = ''
        self.file_name = ''
        self.file_addr = ''

    def fix_title(self, title) :
        self.title = title
        self.fixed_title = True

    def fix_msg(self, msg) :
        self.msg = msg
        self.fixed_msg = True

    def fix_file_name(self, file_name) :
        self.file_name = file_name
        self.fixed_file_name = True

    def fix_file_addr(self, addr) :
        self.file_addr = addr
        self.fixed_file_addr = True

    def send(self, to, title='', msg='', file_name='', have_file=True, file_addr='') :
        mail_content = self.msg if self.fixed_msg else msg
        
        message = MIMEMultipart("alternative")
        message['From'] = "تیم دستیاران آموزشی درس آمار و احتمالات مهندسی"
        message['To'] = to
        message['Subject'] = self.title if self.fixed_title else title

        # message.attach(MIMEText(mail_content, 'plain'))
        message.attach(MIMEText(mail_content, 'html'))

        if have_file :
            attach_file_name = self.file_addr if self.fixed_file_addr else file_addr
            attach_file = open(attach_file_name, 'rb')
            payload = MIMEBase('application', 'octate-stream')
            payload.set_payload((attach_file).read())
            encoders.encode_base64(payload)
            filename = self.file_name if self.fixed_file_name else file_name
            payload.add_header('Content-Disposition', 'attachment', filename=filename)
            message.attach(payload)
            
        session = smtplib.SMTP('smtp.gmail.com', 587)
        session.starttls()
        session.login(self.sender_address, self.sender_pass)
        text = message.as_string()
        session.sendmail(self.sender_address, to, text)
        session.quit()

    def send_batch(self, to, file_name=[], have_file=True, file_addr=[]) :
        if not self.fixed_title or not self.fixed_msg :
            print('msg is not fixed')
            return
        for i in tqdm(range(len(to))) :
            if have_file :
                self.send(
                    to[i],
                    file_name=self.file_name if self.fixed_file_name else file_name[i],
                    file_addr=self.file_addr if self.fixed_file_addr else file_addr[i]
                )
            else :
                self.send(
                    to[i],
                    have_file=False
                )


# In[2]:


import pandas as pd

class FeedBacksProvider:
    #structure={'problem_name': (grade_column, comment_column, fix_text)}
    #header inputs = (name, title)
    #footer inputs = ()
    #feedback_line inputs = (problem_name, grade, grade_range, comment, fix_text)
    def __init__(self, sheet_name, title, structure, css='',
                 header="با سلام خدمت {}, بازخورد مربوط به مبحث {} به پیوست ارسال می‌گردد. در هر قسمت ایمیل  مصحح مربوطه آمده که در صورت وجود هر گونه ابهام یا اعتراض می‌توانید از این طریق با مصحح مربوطه ارتباط داشته باشید.".format,
                 feedback_line="شما از {} نمره {} از {} را دریافت کردید.<br/>{}<br>{}".format,
                 footer="".format,
                 sid=0, name=1, grade_range=1, start=4):
        self.df = pd.read_csv(sheet_name)
        self.css = css
        self.start = start-2
        self.grade_range = grade_range-1
        self.sid = sid
        self.name = name
        self.header = header
        self.footer = footer
        self.feedback_line = feedback_line
        self.structure = structure
        self.title = title

    def provide(self):
        self.feedbacks = {}
        for i,sid in enumerate(self.df.iloc[self.start:, self.sid]):
            i += self.start
            get = lambda col, index=i: self.df.iloc[index, col]
            self.feedbacks[sid] = '<head>\n'
            self.feedbacks[sid]+= '<style type="text/css" media="screen">\n'
            self.feedbacks[sid]+= self.css+'\n'
            self.feedbacks[sid]+= '</style>\n'
            self.feedbacks[sid]+= '</head>\n'
            self.feedbacks[sid]+= '<body>\n'
            self.feedbacks[sid]+= f'<p dir="rtl">{self.header(get(self.name), self.title)}</p>\n'
            self.feedbacks[sid]+= '<hr>\n'
            for problem_name, (grade, comment, fix_text) in self.structure.items():
                line = self.feedback_line(
                            problem_name,
                            get(grade) if str(get(grade))!='nan' else 0,
                            get(grade,self.grade_range),
                            get(comment) if type(comment) is str else '',
                            fix_text)
                self.feedbacks[sid]+= f'<p dir="rtl">{line}</p>\n<hr>\n'
            self.feedbacks[sid]+= f'<p dir="rtl">{self.footer()}</p>\n'
            self.feedbacks[sid]+= '</body>\n'
            


# In[3]:


title = 'شمارش مقدماتی'
f = FeedBacksProvider('Grades1400 - شمارش مقدماتی.csv', title,
                     {
                         'سوال اول': (2,3,'@gimail.com'),
                         'سوال دوم': (4,5,'@gimail.com'),
                         'سوال سوم': (6,7,'@gimail.com'),
                         'سوال چهارم': (8,9,'@gimail.com'),
                         'سوال پنجم': (10,11,'@gimail.com'),
                         'سوال ششم': (12,13,'@gimail.com'),
                         'سوال اول آزمون کوتاه': (16,17,'@gimail.com'),
                         'سوال دوم آزمون کوتاه': (18,19,'@gimail.com'),
                     }, css=open('df_style.css').read(),
                     )
f.provide()


# In[4]:


from IPython.core.display import display, HTML
display(HTML(f.feedbacks['810199319']))


# In[5]:


mail_sender = MailSender('ut.eps.ta@gmail.com','renyhkflsxxieoxu')

title_ = 'بازخورد تکلیف - {}'.format(title)
mail_sender.fix_title(title_)

emails = pd.read_csv('Grades1400 - Emails.csv').iloc[:,[0,1]]
sid2email = {str(s):e for s,e in zip(emails.iloc[:,1].tolist(),emails.iloc[:,0].tolist())}

mail_sender.send(to='moein2000n@gmail.com',
                 msg=f.feedbacks["810199485"],
                 have_file=False)
# for sid, msg in tqdm(f.feedbacks.items()) :
#     mail_sender.send(to=sid2email[sid],
#                      msg=msg,
#                      have_file=False)
#     print('\r',sid,end='')


# In[ ]:




