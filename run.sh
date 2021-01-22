#!/bin/bash

helm package charts/* -d ./repository
helm repo index ./repository