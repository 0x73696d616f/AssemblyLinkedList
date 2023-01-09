# Run tests
tests :;
	@forge test -vvv

# Benchmark linked list in anvil
benchmark :;
	chmod +x benchmark.sh 
	./benchmark.sh