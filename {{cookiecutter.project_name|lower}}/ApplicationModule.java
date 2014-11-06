package {{cookiecutter.java_package_base}}.{{cookiecutter.project_name|lower}};

import com.google.common.collect.ImmutableSet;

import com.google.common.util.concurrent.ServiceManager;

import com.google.inject.AbstractModule;

import javax.inject.Singleton;
import com.google.inject.Provides;

public class ApplicationModule extends AbstractModule {
    @Override
    protected void configure() {

    }

    @Provides @Singleton
    ServiceManager serviceManager(final HelloWorldService service) {
        return new ServiceManager(ImmutableSet.of(service));
    }
}

