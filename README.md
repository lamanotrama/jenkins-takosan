# Jenkins Takosan

Jenkins build result notification with [takosan](https://github.com/kentaro/takosan)

## Requirement

* Ruby

## Setup

* Create new free-style job on Jenkins
* Parameterized build setting ([fig.1](#fig1))
  * `takosan` is takosan endpoint
  * `channel` is Slack channel
  * `job` is $JOB_URL of parent job (make to pass through from parent job)
  * `url` is $BUILD_URL of parent job (make to pass through from parent job)
* Build: run shell script

```
curl -s https://raw.github.com/lamanotrama/jenkins-takosan/v1.0/takosan.rb | ruby
```

* Invoke from other jobs with parameters ([fig.2](#fig2))
  * Choose `Complete (always trigger)`

```
job=$JOB_NAME
url=$BUILD_URL
```

---


