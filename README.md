# KitchenToolkit

[![GitHub license](https://img.shields.io/github/license/jbox-web/kitchen-toolkit.svg)](https://github.com/jbox-web/kitchen-toolkit/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/jbox-web/kitchen-toolkit.svg?branch=master)](https://travis-ci.org/jbox-web/kitchen-toolkit)
[![Code Climate](https://codeclimate.com/github/jbox-web/kitchen-toolkit/badges/gpa.svg)](https://codeclimate.com/github/jbox-web/kitchen-toolkit)
[![Test Coverage](https://codeclimate.com/github/jbox-web/kitchen-toolkit/badges/coverage.svg)](https://codeclimate.com/github/jbox-web/kitchen-toolkit/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/jbox-web/kitchen-toolkit.svg)](https://gemnasium.com/github.com/jbox-web/kitchen-toolkit)

KitchenToolkit est un outil en ligne de commande qui permet de gérer facilement plusieurs profils Kitchen simultanément.

Les profils Kitchen (`.kitchen.yml`) doivent être placés dans le répertoire `config/kitchen` de votre projet Kitchen.

```sh
Commands:
  ci-tool converge KITCHEN_PROFILE SUITE_NAME  # Run Salt on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool create KITCHEN_PROFILE SUITE_NAME    # Create the virtual machine for SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool destroy KITCHEN_PROFILE SUITE_NAME   # Destroy the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool dump KITCHEN_PROFILE SUITE_NAME      # Dump pillars of the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool help [COMMAND]                       # Describe available commands or one specific command
  ci-tool list KITCHEN_PROFILE                 # List instances of virtual machines of KITCHEN_PROFILE
  ci-tool login KITCHEN_PROFILE SUITE_NAME     # Log into the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool package KITCHEN_PROFILE SUITE_NAME   # Run Kitchen package on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool prepare KITCHEN_PROFILE SUITE_NAME   # Prepare the virtual machine for SUITE_NAME defined in KITCHEN_PROFILE
  ci-tool test KITCHEN_PROFILE SUITE_NAME      # Dump pillars of the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE then run Kitchen tests
  ci-tool verify KITCHEN_PROFILE SUITE_NAME    # Run Kitchen tests on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE

Options:
  [--dry-run], [--no-dry-run]
```
