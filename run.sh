#!/bin/bash

helm package charts/* -d ./packages
helm repo index .