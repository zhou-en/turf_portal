# turf_portal

---

## Build Statuses

- [Develop](https://github.com/zhou-en/turf_portal/tree/develop)

    ![Develop Status](https://github.com/zhou-en/turf_portal/actions/workflows/main.yml/badge.svg?branch=develop)

- [Master](https://github.com/zhou-en/turf_portal/tree/master)

    ![Master Status](https://github.com/zhou-en/turf_portal/actions/workflows/main.yml/badge.svg?branch=master)


## Environment Dependencies

- For PDF feature to work, the following package has to be installed in the deployed environment:
```shell
sudo apt install wkhtmltopdf
```

## Backup Database on Lubuntu
- Login as `postgres` user: `sudo su - postgres`
- Dump `sql` file: `psql -U postgres turf-portal > db_backup.sql`
- Restore: `psql -U postgres postgresql://turf_portal_user:password@localhost:5432/turf_portal < db_backup.sql`
