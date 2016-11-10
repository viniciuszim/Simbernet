//
//  DownloadViewController.h
//  Simbernet
//
//  Created by Vinicius Miguel on 14/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "IQDropDownTextField.h"

@interface DownloadTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgIconeArquivo;
@property (strong, nonatomic) IBOutlet UILabel *lblArquivoNome;
@property (strong, nonatomic) IBOutlet UILabel *lblArquivoData;

@end

@interface DownloadViewController : BaseViewController

@end
