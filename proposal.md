# afrostream-stats


# Architecture

Harvester

```
   Inputs                            Transformers                           Queries

[ BILLING ]    \         
[ BACKO ]       |       [ Last Subscribed ]                               parametrables
[ PF ]          |  =>   [ Views ]       \                         =>
(...)           |       (...)            } [ ViewsByAccounts ]
[ LOGENTRIES ]  |       [ Accounts ]    /
[ FRONT ]      /
```

## Inputs

Each input is a Task of type "input"

## Core

const core = new Core();

core.getTasks(Core.Task.STATUS_STARTED)
core.createTask('name', options)
core.on('')
core.emit('')

## Task

each task react to events

const core = new Core();
const task = new core.createTask(name, options);

task._id
task._name
task._createdAt
task._status
task.start()
task.pause()
task.stop()
task.getId()
task.getStatus() // Core.Task.STATUS_STARTED, Core.Task.STATUS_PAUSED, Core.Task.STATUS_STOPPED

task.on('paused', ...)
task.on('started', ...)
task.on('stopped', ...)

class MyTask extends Core.Task
{

}

const core = new Core();
core.register(MyTask);

### Input Tasks


class MyTask extends Core.Task
{
  constructor(core) {

  }
}

## Queries

- exposable en REST
- paramétrables : nom

# Api

core.getInputs()
