//
//  AgendaViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 15/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaService.h"
#import "RNActivityView.h"
#import <JTCalendar/JTCalendar.h>
#import "BaseViewController.h"

@interface AgendaViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) AgendaModel *agenda;

@end

@interface AgendaViewController : BaseViewController<JTCalendarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) IBOutlet UIButton *buttonMensalSemanal;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong,nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSString *titulo;
@property(nonatomic,strong)NSString *acao;
@property(nonatomic,strong)NSString *acaoObter;

@end
