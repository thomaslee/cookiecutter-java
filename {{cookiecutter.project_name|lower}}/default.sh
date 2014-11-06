NAME={{cookiecutter.project_name|lower}}
JAVA="/opt/jdk/current/bin/java"
PIDFILE=/opt/$NAME/shared/tmp/${NAME}.pid
USER=vagrant
GROUP=vagrant
JAVA_OPTS="-Xmx512m -Xms512m -XX:+AggressiveOpts"
