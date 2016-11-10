//
//  TwitterInserirViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 23/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "TwitterInserirViewController.h"
#import "TweetService.h"
#import "CategoriaModel.h"
#import "SlideNavigationController.h"
#import "TwitterViewController.h"

@interface TwitterInserirViewController () <UITextViewDelegate, IQDropDownTextFieldDelegate, TweetServiceDelegate> {
    
    NSInteger keyboardSize;
    UIView* activeField;
    CGRect originalPositionView;
    BOOL keyboardIsUp;
    
    // Services
    TweetService* tweetServ;
}

// Variables
@property (strong, nonatomic) NSMutableArray* categoriaList;
@property (nonatomic) BOOL isQuerying;

@end

@implementation TwitterInserirViewController

#pragma mark - Defaults Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // === Setting delegates
    
    tweetServ = [TweetService new];
    tweetServ.delegate = self;
    
    // ========================================================
    
    // === Setting layouts
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    self.btnTweetar.layer.masksToBounds = YES;
    self.btnTweetar.layer.cornerRadius = 10;
    
    CALayer *categoriaLayer = self.categoria.layer;
    [categoriaLayer setCornerRadius:5];
    [categoriaLayer setBorderWidth:1];
    categoriaLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    CALayer *txtPostLayer = self.txtPost.layer;
    [txtPostLayer setCornerRadius:5];
    [txtPostLayer setBorderWidth:1];
    txtPostLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    // ========================================================
    
    // === Setting Categorias
    
    self.categoriaList = [CategoriaModel getFullItemsList];
    
    NSMutableArray* categorias = [NSMutableArray new];
    for (CategoriaModel* categoria in self.categoriaList) {
        [categorias addObject:categoria.nome];
    }
    
    self.categoria.delegate = self;
    [self.categoria setItemList:categorias];
    
    // ========================================================
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    originalPositionView = self.view.frame;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveViewUp:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveViewDown:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveViewUp:)
                                                 name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidBeginEditingNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - TwitterInserir Methods

- (IBAction)onCloseButtonPressed:(id)sender {
    
    self.categoria.text = @"";
    self.txtPost.text = @"";
    self.lblCountCaracter.text = @"140";
    
    [self.view endEditing:YES];
    [(id<TwitterViewControllerDelegate>)self.delegate onCloseButtonPressed];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweetarButtonPressed:(id)sender {
    
    int selectedCategoria = (int) self.categoria.selectedRow;
    NSString* post = self.txtPost.text;
    
    NSString* error = @"";
    
    if (selectedCategoria == -1) {
        error = @"Informe a Categoria para tweetar.";
    } else if (post == nil || [post isEqualToString:@""]) {
        error = @"Digite um texto para tweetar.";
    }
    
    if (![error isEqualToString:@""]) {
        
        UIAlertView *alert =[[UIAlertView alloc]
                             initWithTitle:@"Atenção"
                             message:error
                             delegate:self
                             cancelButtonTitle:@"Ok"
                             otherButtonTitles:nil, nil];
        [alert show];
        
        return ;
    }
    
    if (!self.isQuerying) {
        
        self.isQuerying = YES;
        
        Tweet2* tweet = [Tweet2 new];
        tweet.categoria = (CategoriaModel*) [self.categoriaList objectAtIndex:selectedCategoria];
        tweet.post = post;
        
        [tweetServ inserir:tweet];
        
//        NSLog(@"%ld - %@",(long)self.categoria.selectedRow, self.txtPost.text);
    }
}

- (IBAction)onContentViewTapped:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - IQDropDownTextFieldDelegate

- (void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item {
//    NSLog(@"%@",item);
}

#pragma mark - TextField Hidden

#define ANIMATION_DURATION 0.15

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)moveViewUp:(NSNotification*)aNotification
{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        
        if ([aNotification.name isEqualToString:UIKeyboardDidShowNotification]) {
            NSDictionary* info = [aNotification userInfo];
            keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            if (keyboardSize >= self.view.frame.size.height) {
                keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.width;
            }
        }
        if (keyboardSize > 0) {
            CGRect bkgndRect = originalPositionView;
            CGRect frameReal = [activeField convertRect:activeField.bounds toView:self.view];
            float bottomY = frameReal.origin.y + frameReal.size.height + 5;
            float keyboardY = bkgndRect.size.height - keyboardSize;
            if (bottomY > keyboardY) {
                bkgndRect.origin.y -= (bottomY - keyboardY);
            }
            [self.view setFrame:bkgndRect];
            
            keyboardIsUp = YES;
        }
        
    }
     ];
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)moveViewDown:(NSNotification*)aNotification
{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [self.view setFrame:originalPositionView];
        keyboardIsUp = NO;
    }];
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textField
{
    activeField = textField;
//    if (CGRectIsEmpty(originalPositionView)) {
        originalPositionView = self.view.frame;
//    }
}

- (void) textViewDidEndEditing:(UITextView *)textField {
    activeField = nil;
}

- (BOOL)textView:(UITextView *)textField shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL canChange = YES;
    
    int characterLimit = 140;
    int textFieldLength = (int) [textField.text length] + 1;
    int newLength = 0;
    
    if (range.length > 0) {
        
        textFieldLength = (int) [textField.text length] - (int) range.length;
        
        newLength = characterLimit - textFieldLength;
        self.lblCountCaracter.text = [NSString stringWithFormat:@"(%d)", newLength];
    } else if (textFieldLength <= characterLimit) {
        
        newLength = characterLimit - textFieldLength;
        self.lblCountCaracter.text = [NSString stringWithFormat:@"(%d)", newLength];
        
    } else {
        canChange = NO;
    }
    
    return canChange;
}

#pragma mark - BaseServiceDelegate

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    NSLog(@"Service Delegate error: %@", error);
    NSLog(@"Service Delegate method: %@", method);
    
    self.isQuerying = NO;
}

#pragma mark TweetServiceDelegate

- (void) inserirResult:(Tweet2*) tweet success:(BOOL)success {
    
    self.isQuerying = NO;
    
    [(id<TweetServiceDelegate>)self.delegate inserirResult:tweet success:success];
    
    [self onCloseButtonPressed:nil];
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
