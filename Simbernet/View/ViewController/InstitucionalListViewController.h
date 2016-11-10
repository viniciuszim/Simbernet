//
//  InstitucionalListViewController.h
//  Simbernet
//
//  Created by Vinicius Miguel on 26/10/15.
//  Copyright © 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InstitucionalListViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
//@property (strong, nonatomic) IBOutlet UILabel *lblDescription;

@end

@interface InstitucionalListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;

@end
