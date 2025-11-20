#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys

# Shim cgi module for Python 3.13+ compatibility
if sys.version_info >= (3, 13):
    import types
    import email.message

    def parse_header(line):
        m = email.message.Message()
        m['content-type'] = line
        params = m.get_params()
        if params is None:
            return m.get_content_type(), {}
        return m.get_content_type(), {k: v for k, v in params}

    cgi = types.ModuleType('cgi')
    cgi.parse_header = parse_header
    sys.modules['cgi'] = cgi


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'turf_portal.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
