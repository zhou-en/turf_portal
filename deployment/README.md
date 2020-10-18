# [Deploy Django Service Using Gunicorn and Nginx on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04)

---

[TOC]

<!-- toc -->

  * [Install Packages from the Ubuntu Repositories for Python 3](#Install-Packages-from-the-Ubuntu-Repositories-for-Python-3)
  * [Create the PostgreSQL Database and User](#Create-the-PostgreSQL-Database-and-User)
  * [Create a Python 3 Virtual Environment for your Project](#Create-a-Python-3-Virtual-Environment-for-your-Project)
  * [Create and Configure a New Django Project](#Create-and-Configure-a-New-Django-Project)
  * [Create a Gunicorn systemd Service File `gunicorn.service` in `/etc/systemd/system/`](#Create-a-Gunicorn-systemd-Service-File-gunicornservice-in-etcsystemdsystem)
    + [Check for the Gunicorn Socket File](#Check-for-the-Gunicorn-Socket-File)
  * [Configure Nginx to Proxy Pass to Gunicorn](#Configure-Nginx-to-Proxy-Pass-to-Gunicorn)
    + [creating and opening a new server block in Nginx’s `sites-available` directory:](#creating-and-opening-a-new-server-block-in-Nginx’s-sites-available-directory)
    + [The comple nginx conf file](#The-comple-nginx-conf-file)
    + [Now, we can enable the file by linking it to the sites-enabled directory:](#Now-we-can-enable-the-file-by-linking-it-to-the-sites-enabled-directory)
- [Test `nginx`](#Test-nginx)

<!-- tocstop -->

## Install Packages from the Ubuntu Repositories for Python 3

```sh
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx
```

## Create the PostgreSQL Database and User

```sh
sudo -u postgres psql
```

We are setting the default encoding to UTF-8, which Django expects. We are also setting the default transaction isolation scheme to “read committed”, which blocks reads from uncommitted transactions. Lastly, we are setting the timezone. By default, our Django projects will be set to use UTC. These are all recommendations from the [Django project itself](https://docs.djangoproject.com/en/1.9/ref/databases/#optimizing-postgresql-s-configuration):

```sql
CREATE USER myprojectuser WITH PASSWORD 'password';
ALTER ROLE myprojectuser SET client_encoding TO 'utf8';
ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE myprojectuser SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;
```

## Create a Python 3 Virtual Environment for your Project

```sh
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv
mkdir ~/myproject
cd ~/myproject
virtualenv myprojectenv
source myprojectenv/bin/activate
```

With your virtual environment active, install Django, Gunicorn, and the psycopg2 PostgreSQL adaptor with the local instance of pip:

```sh
pip install django gunicorn psycopg2
```

## Create and Configure a New Django Project

See: [How To Set Up Django with Postgres, Nginx, and Gunicorn on Ubuntu 16.04 \| DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04/#create-and-configure-new-django-project)

## Create a Gunicorn systemd Service File `gunicorn.service` in `/etc/systemd/system/`

```sh
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=sammy
Group=www-data
WorkingDirectory=/home/sammy/myproject
ExecStart=/home/sammy/myproject/myprojectenv/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/sammy/myproject/myproject.sock myproject.wsgi:application

[Install]
WantedBy=multi-user.target
```

Start and enable gunicorn on system startup

```sh
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
```

### Check for the Gunicorn Socket File

- Check gunicorn status

  ```sh
  sudo systemctl status gunicorn
  ```

- Next, check for the existence of the myproject.sock file within your project directory:

  ```sh
  ls /home/sammy/myproject
  manage.py  myproject  myprojectenv  myproject.sock  static
  ```

- View gunicorn logs

```sh
sudo journalctl -u gunicorn
```

- If you make changes to the /etc/systemd/system/gunicorn.service file, reload the daemon to reread the service definition and restart the Gunicorn process by typing:

```sh
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
```

## Configure Nginx to Proxy Pass to Gunicorn

### creating and opening a new server block in Nginx’s `sites-available` directory:

```sh
sudo nano /etc/nginx/sites-available/myproject
```

### The comple nginx conf file

```nginx
server {
    listen 80;
    server_name server_domain_or_IP;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/sammy/myproject;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/sammy/myproject/myproject.sock;
    }
}
```

### Now, we can enable the file by linking it to the sites-enabled directory:

```sh
sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
```

- Test `nginx`

```sh
sudo nginx -t
```

- Restart

```sh
sudo systemctl restart nginx
```

- Finally, we need to open up our firewall to normal traffic on port 80. Since we no longer need access to the development server, we can remove the rule to open port 8000 as well:

```sh
sudo ufw delete allow 8000
sudo ufw allow 'Nginx Full'
```
