# Linux stress tests (overclocking)

- [Prime95](https://www.mersenne.org/download/) - memory and CPU
- [y-cruncher](http://www.numberworld.org/y-cruncher/)
- [Memtest86](https://www.memtest.org/)
- <https://www.karhusoftware.com/ramtest/#introduction>
- sudo apt install stressapptest
  - `timeout 7h ./mprime -t; stressapptest -W -M $(free -m | awk '/Mem:/ {print int($2 * 0.95)}') -s 60000`
- ...

Complementary Tests: After MemTest86, also stress-test in Windows/Linux using tools like:
TM5 (TestMem5) with Anta777 Extreme preset
HCI MemTest (400%+ coverage per thread)
Karhu RAM Test (10,000% coverage for high reliability)
Prime95 (Blend Test for memory-intensive workloads)

## Windows only

- <https://www.karhusoftware.com/ramtest/#introduction>

## To try

- <https://www.phoronix-test-suite.com/>


<https://www.techpowerup.com/forums/threads/program-for-basic-memory-testing.311786/>

<https://www.reddit.com/r/AMDHelp/comments/17og1bi/stress_test_your_ram/>
