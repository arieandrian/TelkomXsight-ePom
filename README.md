# TelkomXsight-ePom
ePom using TelkomXsight's API

This is part of ePom Project to fulfill Telkom 2018 Hackathon's requirement

We are using three APIs from http://telkomxsight.com :
- SMSOTP
- SMSNotification
- Finpay

Source code consist of Topup scenario which is the same as currently used by ePom mobile application

TopUp rule can be explained as below:
1. Fill up TopUp nominal and description on the first page
2. Push "ePom TopUp" button to continue OTP verification
3. Enter 4 digits OTP verification code that is sent to mobile phone
4. Confirm OTP code by pressing "Continue", when got failed response it will be rolled back to the first page, and continue to payment page when it is succeed

Cheers,

Best Regards,

Arie Andrian
