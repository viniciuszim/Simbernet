//
//  BaseViewController.m
//  Simbernet
//
//  Created by Rafael Paiva Silva on 2/2/15.
//  Copyright (c) 2015 in6. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Coloca a barra pra esconder já que na view superior sempre mostra
    self.navigationController.navigationBarHidden = NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
