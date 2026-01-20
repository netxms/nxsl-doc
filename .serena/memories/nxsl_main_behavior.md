# NXSL Implicit vs Explicit Main Behavior

## Implicit Main (`$main`)
- All code outside functions is wrapped into `$main()` internally (note the `$` prefix)
- Code executes sequentially in order of appearance
- Function definitions are processed but not executed until called

## Example: Sequential Execution
```nxsl
println("1");
function f() {
  println("2");
}
println("3");
f();
// Output: 1 3 2
```

## Critical: Explicit `main()` Overrides `$main`
When both implicit code AND explicit `main()` function exist:
- The implicit `$main()` is **discarded entirely**
- Only the explicit `main()` executes

### Demonstration
```nxsl
// test.nxsl - with explicit main()
println("$main()");  // This line is IGNORED

function main() {
    println("main()");
}
// Output: main()
```

```nxsl
// test1.nxsl - no explicit main()
println("$main()");  // This line executes

function another_function() {
    println("main()");
}
// Output: $main()
```

## Documentation Implication
This is why `main()` is deprecated - users defining `main()` with top-level code will silently lose that top-level code execution. Best practice: don't define `main()`, let the interpreter use implicit `$main`.
