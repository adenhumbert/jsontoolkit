/// @description json_test_insert_nested()

// 8.1: Non-existent top layer
var filling_map = JsonStruct(JsonMap(
    "d", "e"
));
var filling_list = JsonStruct(JsonList(
    "a", "b", "c"
));
assert_equal(json_insert_nested(-1, "a", filling_map), 0, "8.1.1: Failed nonsense test!");
assert_equal(json_insert_nested("nonsense", 2, filling_list), 0, "8.1.2: Failed nonsense test!");

// 8.2: Top level is map
var fixture = JsonStruct(JsonMap(
    "foo", "boo"
));

// 8.2.1: Shouldn't choke on overshot paths
assert_equal(json_insert_nested(fixture, "foo", "waahoo", filling_map), -2, "8.2.1a: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, "foo", "waahoo", filling_list), -2, "8.2.1b: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, "foo", 0, filling_map), -2, "8.2.1c: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, "foo", 0, filling_list), -2, "8.2.1d: Failed to handle overshot path!");

// 8.2.2: Should set sublists
assert_equal(json_insert_nested(fixture, "bar", filling_list), 1, "8.2.2.1a: Sublist insert-nest failed!");
assert_equal(json_get(fixture, "bar", 0), "a", "8.2.2.1b: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, "bar", 1), "b", "8.2.2.1c: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, "bar", 2), "c", "8.2.2.1d: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, "bar", 3), undefined, "8.2.2.1b: Sublist insert-nest didn't happen!");

// 8.2.3: Should set submaps
assert_equal(json_insert_nested(fixture, "baz", filling_map), 1, "8.2.3.1a: Submap insert-nest failed!");
assert_equal(json_get(fixture, "baz", "d"), "e", "8.2.3.1b: Submap insert-nest didn't happen!");
assert_equal(json_get(fixture, "baz", "k"), undefined, "8.2.3.1c: Submap insert-nest didn't happen!");


// 8.3: Top level is "list"
json_destroy(fixture);
fixture = JsonStruct(JsonList(
    "foo",
    "bar",
    "baz"
));
filling_map = JsonStruct(JsonMap(
    "D", "E"
));
filling_list = JsonStruct(JsonList(
    "A", "B", "C"
));

// 8.3.1: Shouldn't choke on overshot paths
assert_equal(json_insert_nested(fixture, 0, "waahoo", filling_map), -2, "8.3.1a: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, 0, "waahoo", filling_list), -2, "8.3.1b: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, 0, 0, filling_map), -2, "8.3.1c: Failed to handle overshot path!");
assert_equal(json_insert_nested(fixture, 0, 0, filling_list), -2, "8.3.1d: Failed to handle overshot path!");

// 8.3.2: Should set sublists
assert_equal(json_insert_nested(fixture, 1, filling_list), 1, "8.3.2.1a: Sublist insert-nest failed!");
assert_equal(json_get(fixture, 1, 0), "A", "8.3.2.1b: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, 1, 1), "B", "8.3.2.1c: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, 1, 2), "C", "8.3.2.1d: Sublist insert-nest didn't happen!");
assert_isnt_defined(json_get(fixture, 1, 3), "8.3.2.1e: Sublist insert-nest didn't happen!");
assert_equal(json_get(fixture, 0), "foo", "8.3.2.1f: Sublist insert-nest shifted wrong entry!");
assert_equal(json_get(fixture, 2), "bar", "8.3.2.1g: Sublist insert-nest shifted wrong entry!");
assert_equal(json_get(fixture, 3), "baz", "8.3.2.1h: Sublist insert-nest shifted wrong entry!");

// 8.3.3: Should set submaps
assert_equal(json_insert_nested(fixture, undefined, filling_map), 1, "8.3.3.1a: Submap insert-nest failed!");
assert_equal(json_get(fixture, 4, "D"), "E", "8.3.3.1b: Submap insert-nest didn't happen!");
assert_isnt_defined(json_get(fixture, 4, "k"), "8.3.3.1c: Submap insert-nest didn't happen!");

// Cleanup
json_destroy(fixture);

