#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (FindTarget)

-(NSInteger)findTarget:(NSInteger)target;
-(NSInteger)findTargetRotateSorted:(NSInteger)target;

@end

@implementation NSArray (FindTarget)

-(NSInteger)findTarget:(NSInteger)target
{
  for (NSInteger i = 0;i < self.count; i++) {
  if ([(NSNumber*)self[i] intValue] == target) {
  return i;
  }
  }

  return -1;
}
/*
-(NSInteger)findTargetRotateSorted:(NSInteger)target
{
  NSLog(@"find %ld", target);
  if (self.count == 0) {
  return -1;
  }

  NSInteger prev = [(NSNumber*)self[0] intValue];
  if (target == prev) {
  return 0;
  }

  NSInteger i, current;
  if (target < prev) {
  for (i = self.count - 1;i > 0; i--) {
  NSLog(@"%ld", i);
  current = [(NSNumber*)self[i] intValue];
  if (prev < current) {
  // end of back sorted part
  return -1;
  }
  if (current == target) {
  return i;
  }
  prev = current;
  }
  } else {
  for (i = 1;i < self.count; i++) {
  NSLog(@"%ld", i);
  current = [(NSNumber*)self[i] intValue];
  if (prev > current) {
  // end of front sorted part
  return -1;
  }
  if (current == target) {
  return i;
  }
  prev = current;
  }
  }

  return -1;
}*/

// binary search log(n)
-(NSInteger)findTargetRotateSorted:(NSInteger)target
{
  if (self.count == 0) {
  return -1;
  }

  NSInteger low = 0;
  NSInteger up = self.count - 1;
  NSInteger med, medVal, lowVal, upVal;

  while (low < up) {
  med = (low + up) / 2;
  lowVal = [(NSNumber*)self[low] intValue];
  upVal = [(NSNumber*)self[up] intValue];
  medVal = [(NSNumber*)self[med] intValue];

  if (medVal == target) {
  return med;
  }

  if (lowVal < medVal) {
  if (target > lowVal && target < medVal) {
  up = med - 1;
  } else {
  low = med + 1;
  }
  } else {
  if (target > medVal && target < upVal) {
  low = med + 1;
  } else {
  up = med - 1;
  }
  }
  }

  return ([(NSNumber*)self[low] intValue] == target) ? low : -1;
}

@end

int main (int argc, const char * argv[])
{
  @autoreleasepool {
  NSArray *data1 = @[@(4), @(5), @(1), @(2), @(3)];
  NSLog(@"%ld", [data1 findTargetRotateSorted:1]);
  NSLog(@"%ld", [data1 findTargetRotateSorted:0]);
  }
}

