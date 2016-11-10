//
//  AgendaViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 15/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "AgendaViewController.h"
#import "AgendaDetalheViewController.h"
#import "UIView+RNActivityView.h"
#import "UsuarioService.h"
#import "Usuario.h"

@implementation AgendaViewCell
@end

@interface AgendaViewController () <AgendaServiceDelegate, UserServiceDelegate> {
    NSMutableDictionary *_eventsByDate;
    NSDate *_dateSelected;
    NSMutableArray *agendaLista;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dataBaseAtual;
    
    BOOL carregou;
}

- (Usuario *)getUsuario;

@end

@implementation AgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    agendaLista = [NSMutableArray arrayWithObjects:
//                                  @"08:00 - Reunião Cliente 01", @"10:00 - Reunião Cliente 02",
//                                  @"14:30 - Reunião Cliente 03", @"17:00 - Reunião Cliente 04", nil];
    
    // Seta data atual;
    _dataBaseAtual = [NSDate date];
    _dateSelected = _dataBaseAtual;
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
//    [self createRandomEvents];

    // Lista compromissos do Java
    [self carregarCompromissos];
    
    // Lista compromissos do dia atual
    
    [self obterCompromissos];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    [self setTitle:self.titulo];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - Buttons callback

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 243;
    CGFloat newHeightTable = 215;
    CGFloat newYTable = 353;
    CGFloat newYButton = 345;
    NSString *backgroudButton = @"ic_arrow_drop_up_circle";
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 90.;
        newHeightTable = 365.;
        newYTable = 203.;
        newYButton = 190;
        backgroudButton = @"ic_arrow_drop_down_circle";
    }
    
    CGRect newFrameCalendar = self.calendarContentView.frame;
    CGRect newFrameTable = self.tableView.frame;
    CGRect newFrameButton = self.buttonMensalSemanal.frame;

    // Table
    newFrameTable.size.height = newHeightTable;
    newFrameTable.origin.y = newYTable;
    [self.tableView setFrame:newFrameTable];
    
    // Button Image
    [self.buttonMensalSemanal setBackgroundImage:[UIImage imageNamed:backgroudButton] forState:UIControlStateNormal];
    newFrameButton.origin.y = newYButton;
    [self.buttonMensalSemanal setFrame:newFrameButton];
    
    // Calendar
    newFrameCalendar.size.height = newHeight;
    [self.calendarContentView setFrame:newFrameCalendar];

    [self.view layoutIfNeeded];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"COMPROMISSOS";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [agendaLista count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"AgendaViewCellID";
    
    AgendaViewCell *cell = (AgendaViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    AgendaModel *agenda = (AgendaModel *) [agendaLista objectAtIndex:indexPath.row];

    if (agenda) {
        if (agenda.horaString && agenda.titulo) {
            cell.lblTitle.text = [NSString stringWithFormat: @"%@ - %@", agenda.horaString, agenda.titulo];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.lblTitle.text = @"Nenhum compromisso.";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AgendaModel *agenda = (AgendaModel *) [agendaLista objectAtIndex:indexPath.row];
    
    if (agenda) {
        if (agenda.horaString && agenda.titulo) {
    
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            AgendaDetalheViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AgendaDetalheViewController"];
            vc.agenda = agenda;

            [self.navigationController pushViewController:vc animated:YES];
    
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Test if the dayView is from another month than the page
    // Use only in month mode for indicate the day of the previous or next month
//    if([dayView isFromAnotherMonth]){
//        dayView.hidden = YES;
//    }
    // Today
    //else
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    // Your method to test if a date have an event for example
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    // Use to indicate the selected date
    _dateSelected = dayView.date;

    if ([self haveEventForDay:dayView.date]) {
        [self obterCompromissos];
    } else {
        AgendaModel *ag = [AgendaModel new];
        agendaLista = [NSMutableArray arrayWithObjects: ag, nil];

        [self.tableView reloadData];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Views customization

- (void)createMinAndMaxDate
{
    _todayDate = _dataBaseAtual;
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    NSLog(@"Next page loaded %@", calendar.date);
    _dataBaseAtual = calendar.date;
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [self carregarCompromissos];
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    NSLog(@"Previous page loaded %@", calendar.date);
    _dataBaseAtual = calendar.date;
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [self carregarCompromissos];
}

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    
    return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void) createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)carregarCompromissos {
    Usuario* usuario = [self getUsuario];
    AgendaService* agendaService = [AgendaService new];
    agendaService.delegate = self;

    NSString *dateString = [[self dateFormatter] stringFromDate:_dataBaseAtual];
    NSLog(@"ACAO: %@", self.acao);
    [agendaService listCompromissosMobile:dateString
                                     user:usuario
                                     acao:self.acao];
}

-(void)obterCompromissos {
    Usuario* usuario = [self getUsuario];
    AgendaService* agendaService = [AgendaService new];
    agendaService.delegate = self;
    
    NSString *dateString = [[self dateFormatter] stringFromDate:_dateSelected];
    [agendaService obterCompromissosDiaMobile:dateString
                                         user:usuario
                                         acao:self.acaoObter];
}

#pragma mark - Delegate

- (void)obterCompromissosDiaReturns:(NSMutableArray *)list {
    NSLog(@"Tamanho lista1: %lu", (unsigned long)[list count]);
    if (list) {
        agendaLista = [NSMutableArray arrayWithArray:list];
    } else {
        agendaLista = [NSMutableArray new];
    }

    [self.tableView reloadData];
    [self setNeedsStatusBarAppearanceUpdate];

}

- (void)listCompromissosReturns:(NSMutableArray *)list {

    carregou = YES;

    NSLog(@"Tamanho lista2: %lu", (unsigned long)[list count]);
    
    _eventsByDate = [NSMutableDictionary new];
    for (AgendaModel *agenda in list) {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *dateFromString = [NSDate new];
        dateFromString = [dateFormatter dateFromString:agenda.data];
        NSDate *eventDate = dateFromString;
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:eventDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:eventDate];

        NSLog(@"Data com compromisso %@", agenda.data);
    }
    
    [_calendarManager reload];
}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    
}

#pragma - UsuarioServiceDelegate

-(Usuario *)getUsuario
{
    return [Usuario getUsuario];
}

@end
