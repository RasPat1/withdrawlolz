1) Use thoughtbots [laptop setup script](https://github.com/thoughtbot/laptop)
```
curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
sh mac 2>&1 | tee ~/laptop.log
```
2) Create the app using [suspenders](https://github.com/thoughtbot/suspenders)
```
gem install suspenders
suspenders app-name --heroku true --github raspat1/app-nameroject --webkit false
```

Between stapes 1 and 2...
* Postgres is installed and running
* Most dependencise will be runnign and installed form step 1

TODO
* Shove this all in a docker container... It's 2021 no one wants to have to deal with the unqiue and fragile state of thier laptops after that last eperiment with Brainfuck...
