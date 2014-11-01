package {{cookiecutter.java_package_base}}.{{cookiecutter.project_name|lower}};

import com.google.common.util.concurrent.ServiceManager;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Stage;

public final class Main {
    public static void main(final String[] args) {
        final Injector injector = Guice.createInjector(Stage.DEVELOPMENT, new ApplicationModule());
        final ServiceManager serviceManager = injector.getInstance(ServiceManager.class);
        Runtime.getRuntime().addShutdownHook(new Thread("Shutdown Hook") {
            @Override
            public void run() {
                serviceManager.stopAsync().awaitStopped();
            }
        });
        serviceManager.startAsync().awaitHealthy();
    }
}

