const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print("Simple Calculator (Zig v0.14.1)\n", .{});
    try stdout.print("Enter an operator (+, -, *, /): ", .{});

    var op_buffer: [2]u8 = undefined;
    const op_slice = try stdin.readUntilDelimiterOrEof(&op_buffer, '\n');
    if (op_slice == null or op_slice.?.len < 1) {
        try stdout.print("Invalid operator input.\n", .{});
        return;
    }
    const op = op_slice.?[0];

    try stdout.print("Enter first value: ", .{});
    var line_buffer1: [100]u8 = undefined;
    const line1 = try stdin.readUntilDelimiterOrEof(&line_buffer1, '\n');
    if (line1 == null) {
        try stdout.print("Invalid input.\n", .{});
        return;
    }
    const val1 = std.fmt.parseFloat(f64, line1.?) catch {
        try stdout.print("Failed to parse first value.\n", .{});
        return;
    };

    try stdout.print("Enter second number: ", .{});
    var line_buffer2: [100]u8 = undefined;
    const line2 = try stdin.readUntilDelimiterOrEof(&line_buffer2, '\n');
    if (line2 == null) {
        try stdout.print("Invalid input.\n", .{});
        return;
    }
    const val2 = std.fmt.parseFloat(f64, line2.?) catch {
        try stdout.print("Failed to parse second value.\n", .{});
        return;
    };

    var result: f64 = 0;
    switch (op) {
        '+' => result = val1 + val2,
        '-' => result = val1 - val2,
        '*' => result = val1 * val2,
        '/' => {
            if (val2 == 0) {
                try stdout.print("Error: Can not divide by zero!\n", .{});
                return;
            }
            result = val1 / val2;
        },
        else => {
            try stdout.print("Unknown operator: {c}\n", .{op});
            return;
        },
    }

    try stdout.print("Result: {d} {c} {d} = {d}\n", .{ val1, op, val2, result });
}
