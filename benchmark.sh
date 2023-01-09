#!/bin/bash

anvil --silent >/dev/null &
sleep 2
forge script script/Benchmark.s.sol:Benchmark -vv --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
kill $(pgrep anvil)