
# Alias - shortcut for any command

An **alias** allows us to assign a nickname to any command or group of
commands.  It's very similar to [git alias], let's take a look at the `openaps
alias --help` output:



```
usage: openaps-alias [-h] {add,remove,show} ...

 openaps-alias - manage aliases

optional arguments:
  -h, --help         show this help message and exit

## Alias Menu:
   aliases - manage alias configurations

  {add,remove,show}  Operation
    add              add - add an alias
    remove           remove - remove an alias
    show             show - show all aliases
```


Let's try a very trivial example with hello world again, `echo hello world` as an alias:

Adding an alias takes a name, and an alias definition (the commands to run).
The commands to run may be any command inside `openaps` toolkit, or if it
starts with a bang (`!`), it can run any arbitrary tool available on the
system.

## Hello world example
```
$ openaps alias add echo "! bash -c \"echo hello \$1\" --"
added echo ! bash -c "echo hello $1" --
$ openaps echo HUMAN
hello HUMAN
```
## Openaps example
We can "rename" commands this way, for example we can alias `openaps invoke` to `openaps report invoke`:

```
$ openaps alias add invoke "report invoke"
added invoke report invoke
$ openaps invoke fake-cgm-data.txt fake-oref0-data.txt
fake-cgm://JSON/shell/fake-cgm-data.txt
reporting fake-cgm-data.txt
fake-oref0://JSON/shell/fake-oref0-data.txt
reporting fake-oref0-data.txt
```

## Grouping commands logically
We can also group large groups of command invocations into one simple alias:
```bash
$ openaps alias add gather-all-fake \
  "report invoke howdy.txt fake-pump-data.txt fake-cgm-data.txt fake-oref0-data.txt"
added gather-all-fake report invoke howdy.txt fake-pump-data.txt fake-cgm-data.txt fake-oref0-data.txt
```
```bash
$ openaps gather-all-fake
howdy://text/shell/howdy.txt
reporting howdy.txt
fake-pump://JSON/shell/fake-pump-data.txt
reporting fake-pump-data.txt
fake-cgm://JSON/shell/fake-cgm-data.txt
reporting fake-cgm-data.txt
fake-oref0://JSON/shell/fake-oref0-data.txt
reporting fake-oref0-data.txt
```

An alias runs all the commands associated with it's definition.
It's the same as running the commands themselves.

[git alias]: https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases

