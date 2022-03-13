# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2).

Dates in this file are in format of YYYY-MM-DD (2019-12-13 means 13th of December 2019).

## [[0.0.2]](https://github.com/kmalkin/tf-aws-minecraft/releases/tag/0.0.2) - 2022-03-25

### Added

* Added capability to have Spot fleet backed asg. (World backups become very important at this point.)[@kmalkin](https://github.com/kmalkin)

## [[0.0.1]](https://github.com/kmalkin/tf-aws-minecraft/releases/tag/0.0.1) - 2021-10-18

### Added

* Basic TF code for deployment to aws. [@kmalkin](https://github.com/kmalkin)
* TF code for sgs, ec2, iam all done. along with user data template. [@kmalkin](https://github.com/kmalkin)
* Added variablisation and configuration options. [@kmalkin](https://github.com/kmalkin)
* Created buckets for auto backup and restore [@kmalkin](https://github.com/kmalkin)
