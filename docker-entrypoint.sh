#!/usr/bin/env bash
set -eu

if [[ "$(ls -A $LIFERAY_BASE)" ]]; then
    if [[ -d "$LIFERAY_BASE/tomcat" ]]; then
        mv "$LIFERAY_BASE/tomcat" "$LIFERAY_BASE/tomcat-$(cat tomcat_version)"
    fi
    cp -rv "$LIFERAY_BASE"/* "$LIFERAY_HOME"
fi

if [[ "$(id -u)" = '0' ]] && [[ ( "$1" == *'catalina.sh' ) || ( "$3" == *'catalina.sh'* ) ]]; then
    chown -R liferay:liferay "$LIFERAY_HOME"
    exec su-exec liferay "$@"
fi

exec "$@"