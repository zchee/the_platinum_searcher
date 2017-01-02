default: build

build:
	go build ./cmd/pt

bench:
	time -p $(CMD) EXPORT_SYMBOL_GPL $(PROF_MODE) ~/src/github.com/torvalds/linux > /dev/null 2>&1

bench/pt: CMD:=./pt
bench/pt: bench

bench/rg: CMD:=rg
bench/rg: bench

profie/cpu: PROF_MODE:=--profile=cpu
profie/cpu: bench/pt
	go tool pprof -top -cum ./pt cpu.pprof
profie/web:
	go tool pprof -web -cum ./pt cpu.pprof

clean:
	${RM} ./pt*
