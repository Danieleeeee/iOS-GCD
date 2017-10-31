//
//  ViewController.m
//  GCD
//
//  Created by sino on 17/5/4.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//GCD:只要函数是异步函数且不是主队列 就会开线程
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self asyncConcurrent];
//    [self asyncSerial];
//    [self syncConcurrent];
//    [self syncSerial];
//    [self asyncMain];
//    [self syncMain];
    //如果在子线程调: 同步函数--主队列就不会死锁
//    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
}


//异步函数--并发队列:会开启多个线程,队列中的任务是异步执行的(无序)
-(void)asyncConcurrent{
    //<#const char * _Nullable label#> C语言的字符串就是一个标签,没什么用
    //<#dispatch_queue_attr_t  _Nullable attr#> 描述信息 告诉他我们要创建一个并发队列 DISPATCH_QUEUE_CONCURRENT并发 DISPATCH_QUEUE_SERIAL 串行队列
    //创建一个队列
//    dispatch_queue_t queue = dispatch_queue_create("com.baidu.download", DISPATCH_QUEUE_CONCURRENT);
    //添加任务到队列中(无序)
    //获取 一个全局并发队列
    //参数一:优先级
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"download1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download4----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download5----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download6----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download7----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download8----%@",[NSThread currentThread]);
    });
}

//异步函数--串行队列:会开一条线程,队列中的任务是有序执行的
-(void)asyncSerial{
    
    dispatch_queue_t queue = dispatch_queue_create("com.baidu.download", DISPATCH_QUEUE_SERIAL);
    //添加任务到队列中(无序)
    dispatch_async(queue, ^{
        NSLog(@"download1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download4----%@",[NSThread currentThread]);
    });
}

//异步函数--主队列:不会开线程,所有任务都在主线程中执行
-(void)asyncMain{
    //异步函数特点如果前面没执行完毕,不会影响后面执行
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"download1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download4----%@",[NSThread currentThread]);
    });

    
}

//同步函数--主队列:会产生死锁,如果主队列发现当前主线程有任务执行,那么主队列会暂停调队列里面的任务,直到主线程空闲为止
-(void)syncMain{
    //同步函数特点立刻马上执行,如果前面没执行完毕,后面的也不会执行
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        
        NSLog(@"download1----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"download2----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"download3----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
    
        NSLog(@"download4----%@",[NSThread currentThread]);
    });

}

//同步函数--并发队列:不会开发线程,队列中的任务是有序执行的
-(void)syncConcurrent{

    dispatch_queue_t queue = dispatch_queue_create("com.baidu.download", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"download1----%@",[NSThread currentThread]);

    });
    
    dispatch_sync(queue, ^{
        NSLog(@"download2----%@",[NSThread currentThread]);
        
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3----%@",[NSThread currentThread]);
        
    });
    dispatch_sync(queue, ^{
        NSLog(@"download4----%@",[NSThread currentThread]);
        
    });
}

//同步函数--串行队列:不会开发线程,队列中的任务是有序执行的
-(void)syncSerial{
    
    dispatch_queue_t queue = dispatch_queue_create("com.baidu.download", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"download1----%@",[NSThread currentThread]);
        
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"download2----%@",[NSThread currentThread]);
        
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3----%@",[NSThread currentThread]);
        
    });
    dispatch_sync(queue, ^{
        NSLog(@"download4----%@",[NSThread currentThread]);
        
    });
}


@end
