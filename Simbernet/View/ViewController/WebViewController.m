//
//  WebViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "WebViewController.h"
#import "UIView+RNActivityView.h"

@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *targetURL = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:20.0];

    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Show loading activity
    [self.view showActivityViewWithLabel:@"Carregando"];
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Hide loading activity
    [self.view hideActivityView];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"ocorreu um erro ao carregar webView: %@", error);
    
    // Hide loading activity
    [self.view hideActivityView];
    
    UIAlertView *alert =[[UIAlertView alloc]
                         initWithTitle:@"Erro"
                         message:@"Desculpe, um erro ocorreu."
                         delegate:self
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil, nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
