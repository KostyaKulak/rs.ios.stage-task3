#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *> *)ratingArray {

    if (ratingArray.count < 3) {
        return 0;
    }
    NSMutableSet *finalSet = [NSMutableSet new];

    for (NSUInteger i = 0; i < ratingArray.count - 2; i++) {

        NSMutableArray *increaseBuffer = @[ratingArray[i]].mutableCopy;
        NSMutableArray *decreaseBuffer = @[ratingArray[i]].mutableCopy;

        for (NSUInteger j = i + 1; j < ratingArray.count; j++) {
            if (increaseBuffer.count > 1) {
                [increaseBuffer removeLastObject];
            }

            if (decreaseBuffer.count > 1) {
                [decreaseBuffer removeLastObject];
            }

            if (ratingArray[j].intValue > [increaseBuffer.lastObject intValue]) {
                [increaseBuffer addObject:ratingArray[j]];
            } else if (ratingArray[j].intValue < [decreaseBuffer.lastObject intValue]) {
                [decreaseBuffer addObject:ratingArray[j]];
            }

            for (NSUInteger k = j + 1; k < ratingArray.count; k++) {
                if (ratingArray[k].intValue > [increaseBuffer.lastObject intValue]) {
                    [increaseBuffer addObject:ratingArray[k]];
                } else if (ratingArray[k].intValue < [decreaseBuffer.lastObject intValue]) {
                    [decreaseBuffer addObject:ratingArray[k]];
                }

                if (increaseBuffer.count > 2) {
                    [finalSet addObject:[[increaseBuffer valueForKey:@"description"] componentsJoinedByString:@""]];
                    [increaseBuffer removeLastObject];
                }

                if (decreaseBuffer.count > 2) {
                    [finalSet addObject:[[decreaseBuffer valueForKey:@"description"] componentsJoinedByString:@""]];
                    [decreaseBuffer removeLastObject];
                }

            }

        }
    }
    return [finalSet count];
}

@end
