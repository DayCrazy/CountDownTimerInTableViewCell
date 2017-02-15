# CountDownTimerInTableViewCell
类似各种支付倒计时，或者秒杀需要在TableViewCell中嵌入多个倒计时，本次只实现了基本功能，期待后续优化

###1、为了实现跳转页面后再回来倒计时没有结束，将计时器加载在子线程中。添加到RunLoop中，给予资源，开启。

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
	
###2、数据加载需要服务器传入才可实现跨页不断。数据格式如下，可调整，传入的是该条状态开始的时间

	- (NSMutableArray*)dataArray{
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray arrayWithObjects:@"2017-02-15  15:00:00",@"2017-02-15 15:00:10",@"2017-02-15 15:00:20",@"2017-02-15 15:00:00",@"2017-02-15 15:00:40",@"2017-02-15 15:00:50",@"2017-02-15 15:00:00",@"2017-02-15 15:00:10",@"2017-02-15 15:00:35",@"2017-02-15 15:00:40",nil];
    }
    
    return _dataArray;
    
	}
	
###3、定义总的倒计时时间 
 #define TOTALTIME   60*60


