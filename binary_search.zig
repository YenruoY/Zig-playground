const std = @import("std");
const print = std.debug.print;
const stdin = std.io.getStdIn();
const reader = stdin.reader();

pub fn main() !void {
    print("Hello world!\n", .{});

    var array = [_]u32{0} ** 15;

    // populating array with random generated numbers
    for (&array) |*elm| {
        var tmp = try gen_rand();
        elm.* = tmp;
    }

    // printing array elements
    print("Random Array : ", .{});
    for (array) |elm| {
        print("{} ", .{elm});
    }
    print("\n", .{});

    // sorting the array
    try bubble_sort(&array);

    // printing sorted array
    print("Sorted Array : ", .{});
    for (array) |elm| {
        print("{} ", .{elm});
    }
    print("\n", .{});

    // generating a random number in the range
    const to_find: u32 = try gen_rand();
    print("Finding the number : {}\n", .{to_find});

    // calling binary search function
    binary_search(&array, to_find);
}

fn gen_rand() !u32 {
    // generates seed by using nanoTimestamp within range 10000
    const nanoTime: u32 = @intCast(@mod(std.time.nanoTimestamp(), 10000));

    // random function object
    var prng = std.rand.DefaultPrng.init(nanoTime);
    const rand = prng.random();

    return rand.uintLessThan(u32, 100);
}

fn bubble_sort(aPtr: *[15]u32) !void {
    // var tmp: u32 = aPtr[0];
    var max: u32 = aPtr[0];
    for (0..(aPtr.len - 1)) |i| {
        for (0..(aPtr.len - i - 1)) |k| {
            if (aPtr[k] > aPtr[k + 1]) {
                max = aPtr[k];
                aPtr[k] = aPtr[k + 1];
                aPtr[k + 1] = max;
            }
        }
    }
}

fn binary_search(aPtr: *[15]u32, to_find: u32) void {
    var flag: i32 = -1;
    var lPtr: usize = 0;
    var rPtr: usize = aPtr.len - 1;
    var mid: usize = 0;

    while (mid != @divTrunc((lPtr + rPtr), 2)) {
        mid = @divTrunc(lPtr + rPtr, 2);
        print("Mid : {}\n", .{mid});

        if (aPtr[mid] == to_find) {
            flag = @intCast(mid);
        } else if (to_find < aPtr[mid]) {
            rPtr = mid;
        } else if (aPtr[mid] < to_find) {
            lPtr = mid;
        }
    }

    if (flag == -1) {
        print("Element not found! \n", .{});
    } else {
        print("Element found at : {}\n", .{flag + 1});
    }
}
