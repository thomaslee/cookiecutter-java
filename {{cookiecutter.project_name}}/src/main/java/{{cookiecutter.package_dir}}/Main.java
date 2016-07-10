package {{cookiecutter.package}};

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * This class contains the program entry point.
 */
public final class Main {
    /**
     * SLF4J logger.
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);

    /**
     * The program entry point.
     *
     * @param args command line arguments
     */
    public static void main(final String... args) {
        LOGGER.info("Hello, World");
    }

    /**
     * Do not allow instances of {@link Main} to be created.
     */
    private Main() {
    }
}
