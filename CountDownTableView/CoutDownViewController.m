//
//  CoutDownViewController.m
//  CountDownTableView
//
//  Created by 李丹阳 on 2017/2/15.
//  Copyright © 2017年 李丹阳. All rights reserved.
//

#import "CoutDownViewController.h"
#import "NSDate+Helper.h"

#define TOTALTIME   60*60

@interface CoutDownViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView* showTableView;
    //    NSMutableArray* dataArray;
    NSTimer* countDownTimer;
    
    NSInteger loopCount;
    
    
    
}

@property (nonatomic, assign) NSInteger timeInterval;




@end

@implementation CoutDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initTableView{
    
    showTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    showTableView.delegate = self;
    showTableView.dataSource = self;
    [showTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"showTableViewCell"];
    [self.view addSubview:showTableView];
    
    _dataArray = self.dataArray;
    
    _timeInterval = 0;
    
    NSThread* currentThread = [[NSThread alloc]initWithTarget:self selector:@selector(threadSart:) object:nil];
    [currentThread start];
    
}

- (NSMutableArray*)dataArray{
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray arrayWithObjects:@"2017-02-15  15:00:00",@"2017-02-15 15:00:10",@"2017-02-15 15:00:20",@"2017-02-15 15:00:00",@"2017-02-15 15:00:40",@"2017-02-15 15:00:50",@"2017-02-15 15:00:00",@"2017-02-15 15:00:10",@"2017-02-15 15:00:35",@"2017-02-15 15:00:40",nil];
    }
    
    return _dataArray;
    
}

- (void)threadSart:(id)object{
    
    @autoreleasepool {
        
        NSRunLoop* timeRunLoop = [NSRunLoop currentRunLoop];
        CFRunLoopObserverRef runLoopRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            
            
        });
        
        if (runLoopRef) {
            CFRunLoopRef cfLoop = [timeRunLoop getCFRunLoop];
            CFRunLoopAddObserver(cfLoop, runLoopRef, kCFRunLoopDefaultMode);
        }
        
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountDownTimer:) userInfo:nil repeats:YES];
    
        while (loopCount);
        
        [timeRunLoop run];

        
        if (runLoopRef) {
            CFRelease(runLoopRef);
        }
        NSLog(@"thread end=================");
        
    }
    
}

#pragma mark 🎱 tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"showTableViewCell"];
    
    NSString* timeStr = _dataArray[indexPath.row];
    
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:timeStr];
    NSTimeInterval start = [startD timeIntervalSinceNow];

    NSInteger countDown = TOTALTIME - (-start);
    
    if (TOTALTIME>countDown>0) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"倒计时%li:%li",countDown/60%60,countDown%60];
    }else{
        
        cell.textLabel.text = @"倒计时结束";
    }
    
    return cell;
    
}

- (void)CountDownTimer:(id)inform{
    
    _timeInterval ++;
    
    for (int i = 0; i< _dataArray.count; i++) {
        
        NSString* countStr = _dataArray[i];
        
        if (countStr.integerValue >0) {
            
            NSDateFormatter *date = [[NSDateFormatter alloc]init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *startD = [date dateFromString:countStr];
            [startD dateByAddingTimeInterval:-1];
            
            countStr = [startD stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            _dataArray[i] = countStr;
        }
    }
    
    [showTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [countDownTimer invalidate];
    self.block(_dataArray);
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
