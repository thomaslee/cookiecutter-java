package {{cookiecutter.java_package_base}}.{{cookiecutter.project_name|lower}};

import com.google.common.util.concurrent.AbstractScheduledService;

import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Singleton;
import javax.inject.Inject;

@Singleton
public final class HelloWorldService extends AbstractScheduledService {
    private static final Logger log = LoggerFactory.getLogger(HelloWorldService.class);

    @Inject
    public HelloWorldService() {
    }

    @Override
    protected void runOneIteration() {
        log.info("tick");
    }

    @Override
    protected Scheduler scheduler() {
        return Scheduler.newFixedDelaySchedule(0, 2, TimeUnit.SECONDS);
    }
}

