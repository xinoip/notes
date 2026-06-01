# Linux Perf Tool

`perf` is a CLI tool for instrumenting and analyzing Linux kernel facilities.

- Record, analyze, trace various stuff
- Tracepoints
- Exceptions
- Event Counting

## Listing Available Things

`perf list` lists all available stuff that you can track and work with `perf`.
`perf list tracepoints` lists the kernel tracepoints.

## Recording, Tracing, Analyzing

This is an example of recording a trace of a block I/O issue:

```sh
sudo perf record -e -a block:block_rq_issue sleep 4
```

`sleep 4` is saying to only record for 4 seconds. `-a` means to record on
all CPUs.

After recording, you can analyze the trace with `perf report` or `perf script`.
