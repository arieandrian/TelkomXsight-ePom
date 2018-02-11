//
//  ViewController.m
//  TelkomXsight
//
//  Created by Arie Andrian on 10/02/18.
//  Copyright © 2018 Arie Andrian. All rights reserved.
//

#import "ViewController.h"
#import "insertOTP.h"

@interface ViewController () <UITextFieldDelegate> {
    UITextField *entryTopUp;
    UITextField *typeOTP;
    UITextField *descTopUp;
    UIButton *verifyOTP;
    int otpType;
    NSURL *url;
    UILabel *errMsg;
    int otpCode;
    NSString *msisdn;
    int procPay;
    int nomTopUp;
    NSString *descPay;
    UIButton *submit;
    NSString *finMsg;
}

@property (nonatomic, strong)insertOTP *popinsertOTPView;

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Define phoneNum
    msisdn = @"+62816102453";
    
    self.view.backgroundColor = [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(250/255.0) alpha:1];
    
    entryTopUp = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height/3 - 50, self.view.frame.size.width/2, 40)];
    entryTopUp.borderStyle = UITextBorderStyleRoundedRect;
    //entryTopUp.layer.borderWidth = 1;
    entryTopUp.layer.cornerRadius = 5;
    entryTopUp.layer.masksToBounds = YES;
    entryTopUp.clipsToBounds = YES;
    entryTopUp.font = [UIFont systemFontOfSize:15];
    entryTopUp.placeholder = @"Please enter nominal";
    entryTopUp.autocorrectionType = UITextAutocorrectionTypeNo;
    entryTopUp.keyboardType = UIKeyboardTypeNumberPad;
    entryTopUp.returnKeyType = UIReturnKeyDone;
    entryTopUp.clearButtonMode = UITextFieldViewModeWhileEditing;
    entryTopUp.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    entryTopUp.delegate = self;
    
    descTopUp = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height/3, self.view.frame.size.width/2, 40)];
    descTopUp.borderStyle = UITextBorderStyleRoundedRect;
    descTopUp.layer.cornerRadius = 5;
    descTopUp.layer.masksToBounds = YES;
    descTopUp.clipsToBounds = YES;
    descTopUp.font = [UIFont systemFontOfSize:15];
    descTopUp.placeholder = @"ePom TopUp";
    descTopUp.autocorrectionType = UITextAutocorrectionTypeNo;
    descTopUp.keyboardType = UIKeyboardTypeNumberPad;
    descTopUp.returnKeyType = UIReturnKeyDone;
    descTopUp.clearButtonMode = UITextFieldViewModeWhileEditing;
    descTopUp.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    descTopUp.delegate = self;
    
    submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height/3 + 50, self.view.frame.size.width/2, 40);
    [submit setTitle:@"ePom TopUp" forState:UIControlStateNormal];
    submit.titleLabel.textColor = [UIColor whiteColor];
    //submit.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    submit.backgroundColor = [UIColor blueColor];
    submit.layer.masksToBounds = YES;
    submit.clipsToBounds = YES;
    submit.layer.cornerRadius = 5;
    [submit addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:entryTopUp];
    [self.view addSubview:descTopUp];
    [self.view addSubview:submit];
    
    _popinsertOTPView = [[insertOTP alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 100, 0, self.view.frame.size.width/2, 150)];
    _popinsertOTPView.backgroundColor = [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(250/255.0) alpha:1];
    _popinsertOTPView.layer.borderWidth = 0.5;
    _popinsertOTPView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _popinsertOTPView.layer.cornerRadius = 10;
    _popinsertOTPView.clipsToBounds = YES;
    _popinsertOTPView.layer.masksToBounds = YES;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
    [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"hide" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    //[_popAddGroupView addSubview:btn];
    
    typeOTP = [[UITextField alloc] initWithFrame:CGRectMake(20, 25, _popinsertOTPView.frame.size.width - 40, 40)];
    typeOTP.borderStyle = UITextBorderStyleRoundedRect;
    typeOTP.font = [UIFont systemFontOfSize:15];
    typeOTP.placeholder = @"4 digits OTP";
    typeOTP.autocorrectionType = UITextAutocorrectionTypeNo;
    typeOTP.keyboardType = UIKeyboardTypeNumberPad;
    typeOTP.returnKeyType = UIReturnKeyDone;
    typeOTP.clearButtonMode = UITextFieldViewModeWhileEditing;
    typeOTP.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    typeOTP.delegate = self;
    
    [_popinsertOTPView addSubview:typeOTP];
    
    verifyOTP = [[UIButton alloc] initWithFrame:CGRectMake(20, _popinsertOTPView.frame.size.height - 60, _popinsertOTPView.frame.size.width - 40, 40)];
    [verifyOTP addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [verifyOTP setTitle:@"Continue" forState:UIControlStateNormal];
    verifyOTP.layer.cornerRadius = 5;
    verifyOTP.clipsToBounds = YES;
    verifyOTP.layer.masksToBounds = YES;
    verifyOTP.backgroundColor = [UIColor blueColor];
    
    [_popinsertOTPView addSubview:verifyOTP];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:entryTopUp];
}

- (void)getToken {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //URLRequest
    url = [NSURL URLWithString:@"https://api.mainapi.net/token"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Get token
    NSString *params = @"grant_type=client_credentials";
    [urlRequest addValue: @"Basic Q28xRGJDRU5GeHBMZG1nWTNPVHQ1Tkt1TGhrYTpXdmQzVEtiajFqYnhEdUMwb3FxME9rbVlqT1Vh" forHTTPHeaderField: @"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

    otpCode = typeOTP.text.intValue;
    nomTopUp = entryTopUp.text.intValue;
    
    if ([descTopUp.text isEqual:@""]) {
        descPay = @"ePom TopUp";
    } else {
        descPay = descTopUp.text;
    }
    
    //Push Request
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",responseDict);
        NSLog(@"String adalah: %d dan %d dan %@ dan nomTopUp %d",otpCode,otpType,msisdn,procPay);
        
        if (otpType==1) {
            [self smsOTP:[responseDict objectForKey:@"access_token"] phoneNum:msisdn digits:[NSNumber numberWithInt:4].intValue];
        } else if (otpType==2) {
            [self verifyOTP:[responseDict objectForKey:@"access_token"] otpString:[NSString stringWithFormat:@"%d",otpCode] digits:[NSNumber numberWithInt:4].intValue];
        } else if (otpType==3) {
            [self finpay:[responseDict objectForKey:@"access_token"] nominal:procPay desc:descPay];
        } else if (otpType==4) {
            [self smsNotif:[responseDict objectForKey:@"access_token"] phoneNum:msisdn content:finMsg];
        }
        
    }];
    [dataTask resume];
}


- (IBAction)smsOTP: (NSString *)token phoneNum:(NSString *)msisdn digits:(int)digit {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //URLRequest
    NSURL *url = [NSURL URLWithString:@"https://api.mainapi.net/smsotp/1.0.1/otp/epomkey"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Send PUT Params and add it to HTTPBody
    NSString *params = [NSString stringWithFormat:@"phoneNum=%@&digit=%d",msisdn,digit];
    [urlRequest addValue: [NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField: @"Authorization"];
    [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [urlRequest addValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

    // Push SMSOTP
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",responseDict);
        
        // Mendapatkan respon "Resource Forbidden" saat menggunakan API
        
        /*[typeOTP becomeFirstResponder];
        [_popinsertOTPView addSubview:typeOTP];
        [_popinsertOTPView addSubview:verifyOTP];*/
        [_popinsertOTPView showInView:self.view];
    }];
    [dataTask resume];
    
}

- (IBAction)verifyOTP: (NSString *)token otpString:(NSString *)string digits:(int)digit {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //URLRequest
    NSURL *url = [NSURL URLWithString:@"https://api.mainapi.net/smsotp/1.0.1/otp/epomkey/verifications"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    
    
    //Send POST Params and add it to HTTPBody
    NSString *params = [NSString stringWithFormat:@"otpstr=%@&digit=%d",string,digit];
    [urlRequest addValue: [NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField: @"Authorization"];
    [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [urlRequest addValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Verify SMSOTP
    errMsg = [[UILabel alloc] init];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCode = [[[[responseDict objectForKey:@"net"] objectForKey:@"mainapi"] objectForKey:@"fault"] objectForKey:@"code"];
        NSLog(@"Ini %d dan string %d",resultCode.intValue,string.intValue);
        
        // Melanjutkan proses jika otpCode=1234 (karena problem respon "resource forbidden" saat menggunakan API SMSOTP)
        if (string.intValue == 1234 && resultCode.intValue == 900908) {
            procPay = nomTopUp;
            otpType = 3;
            NSLog(@"Lanjutkan nomTopUp: %d",nomTopUp);
            [self getToken];
        } else {
            [self warning:@"Invalid OTP code"];
            NSLog(@"Invalid OTP code");
        }
    }];
    [dataTask resume];

}

- (IBAction)finpay: (NSString *)token nominal:(int)topUpNom desc:(NSString *)description {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //URLRequest
    NSURL *url = [NSURL URLWithString:@"https://api.mainapi.net/finpay/2.0.0/transactions"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Send POST Params and add it to HTTPBody
    NSString *params = [NSString stringWithFormat:@"ivp_method=create&ivp_store=19989&ivp_authkey=5m3JG-dSL3H~BwGP&ivp_amount=%d&ivp_currency=idr&ivp_test=1&ivp_cart=ePomTrans&ivp_desc=%@&return_auth=https://www.mainapi.net/auth.html&return_decl=https://www.mainapi.net/decl.html&return_can=https://www.mainapi.net/can.html",topUpNom,description];
    [urlRequest addValue: [NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField: @"Authorization"];
    [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [urlRequest addValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Send Finpay Transaction
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",responseDict);
        
        // Saat ini mengalami problem IP address exception pada Finpay Admin Page, but lets keep going ;)
        
        if ([[responseDict objectForKey:@"error"] isEqual:@""]) {
            NSLog(@"Transaction success with reference-id: %@ and redirecting to URL: %@",[[responseDict objectForKey:@"order"] objectForKey:@"ref"], [[responseDict objectForKey:@"order"] objectForKey:@"url"]);
            finMsg = [NSString stringWithFormat:@"Trans Ref-ID: %@",[[responseDict objectForKey:@"order"] objectForKey:@"ref"]];
        } else {
            NSLog(@"Transaction failed with error:\n%@\n%@\n%@",[[responseDict objectForKey:@"error"] objectForKey:@"note"],[[responseDict objectForKey:@"error"] objectForKey:@"message"],[[responseDict objectForKey:@"error"] objectForKey:@"details"]);
            [self warning:[NSString stringWithFormat:@"Transaction failed with error:\n%@\n%@\n%@",[[responseDict objectForKey:@"error"] objectForKey:@"note"],[[responseDict objectForKey:@"error"] objectForKey:@"message"],[[responseDict objectForKey:@"error"] objectForKey:@"details"]]];
            finMsg = [[responseDict objectForKey:@"error"] objectForKey:@"note"];
        }
     
        otpType = 4;
        [self getToken];
    }];
    [dataTask resume];
    
}

- (IBAction)smsNotif: (NSString *)token phoneNum:(NSString *)msisdn content:(NSString *)desc {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //URLRequest
    NSURL *url = [NSURL URLWithString:@"https://api.mainapi.net/smsnotification/1.0.0/messages"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Send POST Params and add it to HTTPBody
    NSString *params = [NSString stringWithFormat:@"msisdn=%@&content=%@",msisdn,desc];
    [urlRequest addValue: [NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField: @"Authorization"];
    [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [urlRequest addValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Push SMSNotification
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        // Mendapatkan respon "Resource Forbidden" saat menggunakan API
        
        NSLog(@"%@",responseDict);
        NSLog(@"Mengirim message to: %@ content: %@",msisdn,desc);
    }];
    [dataTask resume];
    
}

- (void)textFieldDidChange:(NSNotification *)notification {
    [errMsg removeFromSuperview];
}

- (IBAction)tapped:(id)sender {
    [entryTopUp removeFromSuperview];
    [descTopUp removeFromSuperview];
    [submit removeFromSuperview];
    
    [typeOTP becomeFirstResponder];
    //typeOTP.text = nil;
    otpType = 1;
    if ([entryTopUp.text isEqual:@""]) {
        [self warning:@"Entry cannot be empty!"];
        return;
    } else {
        [self getToken];
    }
    
    UIColor *baseColor = [UIColor colorWithRed:(0/255.0) green:(43/255.0) blue:(128/255.0) alpha:1];
    self.view.backgroundColor = [self darkerColor:baseColor];
    ///[_popinsertOTPView showInView:self.view];
}

- (void)hideBtnTapped {
    [self.view addSubview:entryTopUp];
    [self.view addSubview:descTopUp];
    [self.view addSubview:submit];
    
    self.view.backgroundColor = [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(250/255.0) alpha:1];
    [self.view endEditing:YES];
    entryTopUp.text = nil;
    [_popinsertOTPView dismiss];
    [_popinsertOTPView removeFromSuperview];
}

- (void)warning:(NSString *)msg {
    [errMsg removeFromSuperview];
    [self.view addSubview:entryTopUp];
    [self.view addSubview:descTopUp];
    [self.view addSubview:submit];
    errMsg = [[UILabel alloc] init];
    errMsg.text = msg;
    errMsg.textColor = [UIColor whiteColor];
    /*float widthMsg =
    [errMsg.text
     boundingRectWithSize:errMsg.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:errMsg.font }
     context:nil]
    .size.width;
    errMsg.frame = CGRectMake(self.view.bounds.size.width/2 - widthMsg/2, self.view.bounds.size.height/2, self.view.frame.size.width/2, 40);*/
    errMsg.frame = CGRectMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2, self.view.frame.size.width/2, 40);
    errMsg.lineBreakMode = NSLineBreakByWordWrapping;
    errMsg.textAlignment = NSTextAlignmentCenter;
    errMsg.numberOfLines = 0;
    [errMsg sizeToFit];
    [self.view addSubview:errMsg];
}

- (void)sendCode {
    NSLog(@"OTP Code: %@",typeOTP.text);
    if (otpType == 1) {
        otpType=2;
        [self getToken];
    }
    //otpType = 0;
    typeOTP.text = nil;
    [self hideBtnTapped];
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer
{
    [self hideBtnTapped];
    [self.view endEditing:YES];
}

- (UIColor *)darkerColor:(UIColor *)color
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
