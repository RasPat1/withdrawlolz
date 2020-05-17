def countPaths(n, m) {
	Map<String, Integer> memo = [:]
	countPathsImpl(n, m, memo)
}

def countPathsImpl(n, m, memo) {
	Long result = 0

	if (n <= 0 || m <= 0) {
		result = 1
	} else {
		String key = "${n}__${m}"
		if (memo[key] != null) {
			result = memo[key]
		} else {
			result = countPathsImpl(n-1, m, memo) + countPathsImpl(n, m-1, memo)
			memo[key] = result`
		}
	}

	return result
}

println countPaths(0,0)
println countPaths(1,1)
println countPaths(2,1)
println countPaths(1,2)
println countPaths(2,2)
println countPaths(3,3)
println countPaths(10,10)
def start = System.currentTimeMillis()
println countPaths(21, 100)
def end = System.currentTimeMillis()
println "Time: ${end - start}"