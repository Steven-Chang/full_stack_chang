# Full Stack Chang

## Setup

Set master.key as required

### Load local database from Heroku production

clean your local database:
```
rake db:schema:load
```
dump your heroku database:
```
heroku pg:backups:capture
heroku pg:backups:download
```
load data in your local database
```
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d full_stack_chang_development latest.dump
```

### Development

```
rails s
```

## Checking code

```
rspec
rubocop -A
haml-lint app/views/
yarn prettier --write app/javascript/
scss-lint app/assets/stylesheets/
rake immigrant:check_keys
rake active_record_doctor
```

## Semaphoreci && Heroku

https://docs.semaphoreci.com/examples/heroku-deployment/

## References

