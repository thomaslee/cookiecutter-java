package {{cookiecutter.package}};

import java.nio.CharBuffer;
import java.util.concurrent.TimeUnit;

import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Level;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Param;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.annotations.Warmup;

import org.openjdk.jmh.infra.Blackhole;

import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

@State(Scope.Benchmark)
@Warmup(iterations = 1, time = 1, timeUnit = TimeUnit.SECONDS)
@Measurement(iterations = 1, time = 1, timeUnit = TimeUnit.SECONDS)
@Fork(1)
public class TrivialBenchmark {
    @Param({"123", "123456"})
    public String param;

    private CharBuffer data;

    @Setup(Level.Trial)
    public void beforeTrial() {
        data = CharBuffer.wrap(param);
    }

    @Setup(Level.Invocation)
    public void beforeInvocation() {
        data.position(0);
    }

    @Benchmark
    @BenchmarkMode(Mode.AverageTime)
    @OutputTimeUnit(TimeUnit.MICROSECONDS)
    public void doBenchmark(final Blackhole bh, final MyState state) {
        bh.consume(foo());
    }

    @TearDown(Level.Invocation)
    public void afterInvocation() {
    }

    @TearDown(Level.Trial)
    public void afterTrial() {
    }

    private static int foo() {
        return 0;
    }

    /**
     * Run {@link TrivialBenchmark} directly.
     */
    public static void main(final String... args) throws Exception {
        final Options options = new OptionsBuilder()
            .include(TrivialBenchmark.class.getSimpleName())
            .build();
        new Runner(options).run();
    }

    @State(Scope.Benchmark)
    public static class MyState {
        @Setup(Level.Trial)
        public void before() {
        }

        @TearDown(Level.Trial)
        public void after() {
        }
    }
}

