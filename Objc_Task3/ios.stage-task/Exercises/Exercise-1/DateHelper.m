#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

- (NSString *)monthNameBy:(NSUInteger)monthNumber {
    if (0 < monthNumber && monthNumber <= 12) {
        NSDateFormatter *df = [NSDateFormatter new];
        NSString *monthName = [df monthSymbols][monthNumber - 1];
        return monthName;
    }
    return nil;
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate *parsedDate = [df dateFromString:date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:parsedDate];
    return components.day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];

    NSInteger dayN = [calendar component:NSCalendarUnitWeekday fromDate:date];

    if (dayN) {
        return [df shortWeekdaySymbols][(NSUInteger) (dayN - 1)];
    }

    return nil;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dateWeek = [calendar component:NSCalendarUnitWeekOfYear fromDate:date];
    NSInteger currentWeek = [calendar component:NSCalendarUnitWeekOfYear fromDate:[NSDate now]];

    return dateWeek == currentWeek;
}

@end
